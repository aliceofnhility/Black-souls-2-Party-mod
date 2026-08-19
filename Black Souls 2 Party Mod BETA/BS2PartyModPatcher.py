import os
import sys
import zlib
import shutil
import struct
import tkinter as tk
from tkinter import ttk, filedialog, messagebox

APP_TITLE = "BLACK SOULS II Recruitable Party Mod"
MOD_NAME = b"BS2 Recruitable Party v0.8.5.2.6"
ARCHIVE_NAME = "Game.rgss3a"
ARCHIVE_BACKUP_SUFFIX = ".bs2partymod_backup"
SCRIPTS_ENTRY_NAME = "data/scripts.rvdata2"
OYSTER_SPRITE_REL = os.path.join("Graphics","Characters","$カキ.png")
OYSTER_SPRITE_ENTRY = "graphics/characters/$カキ.png"
SPRITE_BACKUP_SUFFIX = ".bs2partymod_backup"
JOIPLAY_SCRIPTS_REL = os.path.join("Data","Scripts.rvdata2")
JOIPLAY_BACKUP_SUFFIX = ".bs2partymod_backup"
RGSS3A_HEADER = b"RGSSAD\x00\x03"
DEFAULT_FILE_MAGIC = 0xDEADCAFE

# -----------------------------------------------------------------------------
# Ruby Marshal reader/writer for VX Ace Scripts.rvdata2
# -----------------------------------------------------------------------------

class MarshalReader:
    def __init__(self, data):
        self.d = data
        self.p = 0
        self.symbols = []
        self.objects = []

    def b(self):
        if self.p >= len(self.d):
            raise EOFError("Unexpected end of file")
        v = self.d[self.p]
        self.p += 1
        return v

    def read_fixnum(self):
        c = self.b()
        if c == 0:
            return 0
        if 5 <= c <= 127:
            return c - 5
        if 128 <= c <= 250:
            return c - 256 + 5
        if 1 <= c <= 4:
            n = 0
            for i in range(c):
                n |= self.b() << (8 * i)
            return n
        if 252 <= c <= 255:
            count = 256 - c
            n = 0
            for i in range(count):
                n |= self.b() << (8 * i)
            return n - (1 << (count * 8))
        raise ValueError(f"Invalid Marshal fixnum marker {c}")

    def read(self):
        tag = chr(self.b())
        if tag == "0":
            return None
        if tag == "T":
            return True
        if tag == "F":
            return False
        if tag == "i":
            return self.read_fixnum()
        if tag == '"':
            n = self.read_fixnum()
            s = self.d[self.p:self.p + n]
            self.p += n
            self.objects.append(s)
            return s
        if tag == "[":
            n = self.read_fixnum()
            a = []
            self.objects.append(a)
            for _ in range(n):
                a.append(self.read())
            return a
        if tag == ":":
            n = self.read_fixnum()
            s = self.d[self.p:self.p + n]
            self.p += n
            self.symbols.append(s)
            return ("sym", s)
        if tag == ";":
            return ("sym", self.symbols[self.read_fixnum()])
        if tag == "@":
            return self.objects[self.read_fixnum()]
        if tag == "I":
            obj = self.read()
            n = self.read_fixnum()
            for _ in range(n):
                self.read()
                self.read()
            return obj
        raise ValueError(
            f"Unsupported Ruby Marshal tag {tag!r}. "
            "This Scripts.rvdata2 format is not recognized."
        )


def enc_fixnum(n):
    if n == 0:
        return b"\x00"
    if 0 < n < 123:
        return bytes([n + 5])
    if -124 < n < 0:
        return bytes([(n - 5) & 0xff])
    if n > 0:
        raw = []
        x = n
        while x:
            raw.append(x & 255)
            x >>= 8
        if len(raw) > 4:
            raise ValueError("Integer too large for Ruby Marshal fixnum")
        return bytes([len(raw)]) + bytes(raw)
    for count in range(1, 5):
        if -(1 << (count * 8 - 1)) <= n <= (1 << (count * 8 - 1)) - 1:
            val = (1 << (count * 8)) + n
            return bytes([256 - count]) + bytes(
                (val >> (8 * i)) & 255 for i in range(count)
            )
    raise ValueError("Integer too small for Ruby Marshal fixnum")


def enc_str(v):
    b = v.encode("utf-8") if isinstance(v, str) else bytes(v)
    return b'"' + enc_fixnum(len(b)) + b


def enc_obj(o):
    if o is None:
        return b"0"
    if o is True:
        return b"T"
    if o is False:
        return b"F"
    if isinstance(o, int):
        return b"i" + enc_fixnum(o)
    if isinstance(o, (bytes, bytearray, str)):
        return enc_str(o)
    if isinstance(o, list):
        return b"[" + enc_fixnum(len(o)) + b"".join(enc_obj(x) for x in o)
    raise TypeError(f"Cannot encode {type(o)}")


def load_scripts_bytes(data):
    if data[:2] != b"\x04\x08":
        raise ValueError("Embedded Data\\Scripts.rvdata2 is not Ruby Marshal 4.8 data.")
    r = MarshalReader(data[2:])
    obj = r.read()
    if not isinstance(obj, list):
        raise ValueError("Scripts archive root is not an array")
    for i, e in enumerate(obj):
        if not (
            isinstance(e, list)
            and len(e) == 3
            and isinstance(e[2], (bytes, bytearray))
        ):
            raise ValueError(f"Unexpected script entry at index {i}")
    return obj


def save_scripts_bytes(entries):
    return b"\x04\x08" + enc_obj(entries)


def script_name(entry):
    name = entry[1]
    return name.decode("utf-8", "replace") if isinstance(name, bytes) else str(name)


def is_our_party_mod(entry):
    return script_name(entry).startswith("BS2 Recruitable Party")


def patch_scripts_bytes(original_data, source):
    entries = load_scripts_bytes(original_data)
    clean = [e for e in entries if not is_our_party_mod(e)]
    main_idx = next((i for i, e in enumerate(clean) if script_name(e) == "Main"), None)
    if main_idx is None:
        raise RuntimeError("Could not find the 'Main' script entry inside Scripts.rvdata2.")
    clean.insert(main_idx, [98941041, MOD_NAME, zlib.compress(source, 9)])
    patched = save_scripts_bytes(clean)

    verify = load_scripts_bytes(patched)
    matches = [e for e in verify if is_our_party_mod(e)]
    if len(matches) != 1 or zlib.decompress(matches[0][2]) != source:
        raise RuntimeError("Verification failed after creating patched Scripts.rvdata2.")
    return patched


def clean_scripts_bytes(original_data):
    entries = load_scripts_bytes(original_data)
    clean = [e for e in entries if not is_our_party_mod(e)]
    return save_scripts_bytes(clean)


# -----------------------------------------------------------------------------
# RGSS3A version 3 archive access
# Only the embedded Scripts.rvdata2 entry is decrypted/re-encrypted.
# Other archive data is never extracted.
# -----------------------------------------------------------------------------

class RGSS3AEntry:
    def __init__(self, name, offset, size, file_magic, metadata_pos):
        self.name = name
        self.offset = offset
        self.size = size
        self.file_magic = file_magic
        self.metadata_pos = metadata_pos


class RGSS3AArchive:
    def __init__(self, path):
        self.path = os.path.abspath(path)
        self.table_magic = None
        self.raw_magic = None
        self.entries = []
        self._read_table()

    @staticmethod
    def _u32(data):
        return struct.unpack("<I", data)[0]

    @staticmethod
    def _p32(value):
        return struct.pack("<I", value & 0xFFFFFFFF)

    def _read_table(self):
        file_size = os.path.getsize(self.path)
        with open(self.path, "rb") as f:
            header = f.read(8)
            if header != RGSS3A_HEADER:
                raise ValueError(
                    "Game.rgss3a is not an RPG Maker VX Ace RGSS3A version 3 archive."
                )
            raw = f.read(4)
            if len(raw) != 4:
                raise ValueError("Game.rgss3a is truncated before its archive key.")
            self.raw_magic = self._u32(raw)
            self.table_magic = (self.raw_magic * 9 + 3) & 0xFFFFFFFF

            entries = []
            while True:
                metadata_pos = f.tell()
                raw_offset = f.read(4)
                if len(raw_offset) != 4:
                    raise ValueError("Game.rgss3a metadata table is truncated.")
                offset = self._u32(raw_offset) ^ self.table_magic
                if offset == 0:
                    break

                fields = f.read(12)
                if len(fields) != 12:
                    raise ValueError("Game.rgss3a metadata entry is truncated.")
                size = self._u32(fields[0:4]) ^ self.table_magic
                file_magic = self._u32(fields[4:8]) ^ self.table_magic
                name_len = self._u32(fields[8:12]) ^ self.table_magic
                if name_len > 1024 * 1024:
                    raise ValueError("Game.rgss3a contains an invalid filename length.")

                encrypted_name = bytearray(f.read(name_len))
                if len(encrypted_name) != name_len:
                    raise ValueError("Game.rgss3a filename metadata is truncated.")
                for i in range(name_len):
                    encrypted_name[i] ^= (
                        self.table_magic >> ((i % 4) * 8)
                    ) & 0xFF
                name = bytes(encrypted_name).replace(b"\\", b"/").decode(
                    "utf-8", "replace"
                )

                if offset + size > file_size:
                    raise ValueError(
                        f"Archive entry {name!r} points outside Game.rgss3a."
                    )
                entries.append(
                    RGSS3AEntry(name, offset, size, file_magic, metadata_pos)
                )

            self.entries = entries

    def find_entry(self, name):
        wanted = name.replace("\\", "/").lower()
        for entry in self.entries:
            if entry.name.replace("\\", "/").lower() == wanted:
                return entry
        raise FileNotFoundError(f"{name} was not found inside Game.rgss3a.")

    @staticmethod
    def crypt_bytes(data, magic):
        out = bytearray(data)
        pos = 0
        current = magic & 0xFFFFFFFF
        aligned = (len(out) // 4) * 4
        while pos < aligned:
            value = struct.unpack_from("<I", out, pos)[0] ^ current
            struct.pack_into("<I", out, pos, value & 0xFFFFFFFF)
            current = (current * 7 + 3) & 0xFFFFFFFF
            pos += 4
        remainder_index = 0
        while pos < len(out):
            out[pos] ^= (current >> (remainder_index * 8)) & 0xFF
            remainder_index += 1
            pos += 1
        return bytes(out)

    def read_entry(self, entry):
        with open(self.path, "rb") as f:
            f.seek(entry.offset)
            encrypted = f.read(entry.size)
        if len(encrypted) != entry.size:
            raise IOError(f"Could not read the complete archive entry {entry.name}.")
        return self.crypt_bytes(encrypted, entry.file_magic)

    def replace_entry_by_append(self, entry_name, new_plain_data):
        """
        Append the replacement entry and redirect the existing metadata record.
        This avoids extracting or rewriting every other file in the archive.
        """
        entry = self.find_entry(entry_name)
        new_magic = DEFAULT_FILE_MAGIC
        encrypted = self.crypt_bytes(new_plain_data, new_magic)

        # Append first. If interrupted before metadata is changed, the old archive
        # still points to the original data and remains usable.
        with open(self.path, "r+b") as f:
            f.seek(0, os.SEEK_END)
            new_offset = f.tell()
            f.write(encrypted)
            f.flush()
            os.fsync(f.fileno())

            # Redirect only this entry. Filename length/name remain unchanged.
            f.seek(entry.metadata_pos)
            f.write(self._p32(new_offset ^ self.table_magic))
            f.write(self._p32(len(new_plain_data) ^ self.table_magic))
            f.write(self._p32(new_magic ^ self.table_magic))
            f.flush()
            os.fsync(f.fileno())

        # Re-read and verify the exact data now referenced by the archive.
        check = RGSS3AArchive(self.path)
        check_entry = check.find_entry(entry_name)
        actual = check.read_entry(check_entry)
        if actual != new_plain_data:
            raise RuntimeError(
                "Archive verification failed after replacing Data\\Scripts.rvdata2. "
                "Use Restore Original Archive to recover the backup."
            )




def app_resource(filename):
    base = getattr(sys, "_MEIPASS", os.path.dirname(os.path.abspath(__file__)))
    return os.path.join(base, filename)

def validate_game_dir(game_dir):
    game_dir=os.path.abspath(game_dir.strip().strip('"'))
    if not os.path.isfile(os.path.join(game_dir,"Game.exe")):
        raise FileNotFoundError("Game.exe was not found in the selected folder.")
    archive=os.path.join(game_dir,ARCHIVE_NAME)
    if not os.path.isfile(archive):
        raise FileNotFoundError("Game.rgss3a was not found in the selected folder.")
    rg=RGSS3AArchive(archive); rg.find_entry(SCRIPTS_ENTRY_NAME)
    return game_dir

def ensure_backup(path):
    backup=path+ARCHIVE_BACKUP_SUFFIX
    if os.path.isfile(backup):
        rg=RGSS3AArchive(backup); load_scripts_bytes(rg.read_entry(rg.find_entry(SCRIPTS_ENTRY_NAME)))
        return backup
    shutil.copy2(path,backup)
    # If updating an earlier party-mod build, remove only our section from the backup.
    rg=RGSS3AArchive(backup); e=rg.find_entry(SCRIPTS_ENTRY_NAME); data=rg.read_entry(e)
    if any(is_our_party_mod(x) for x in load_scripts_bytes(data)):
        rg.replace_entry_by_append(SCRIPTS_ENTRY_NAME, clean_scripts_bytes(data))
    return backup

def install_sprite(game_dir):
    src=app_resource(OYSTER_SPRITE_REL)
    if not os.path.isfile(src):
        raise FileNotFoundError("Bundled Cheeky Oyster sprite is missing.")
    dst=os.path.join(game_dir,OYSTER_SPRITE_REL)
    os.makedirs(os.path.dirname(dst),exist_ok=True)
    backup=dst+SPRITE_BACKUP_SUFFIX
    if os.path.isfile(dst) and not os.path.isfile(backup):
        shutil.copy2(dst,backup)
    shutil.copy2(src,dst)
    return dst,backup if os.path.isfile(backup) else None

def install_mod(game_dir):
    game_dir=validate_game_dir(game_dir); path=os.path.join(game_dir,ARCHIVE_NAME)
    source_path=app_resource("BS2_Recruitable_Party.rb")
    sprite_source=app_resource(OYSTER_SPRITE_REL)
    if not os.path.isfile(source_path):
        raise FileNotFoundError("BS2_Recruitable_Party.rb is missing.")
    if not os.path.isfile(sprite_source):
        raise FileNotFoundError("Bundled Cheeky Oyster sprite is missing.")

    source=open(source_path,'rb').read()
    sprite_bytes=open(sprite_source,'rb').read()
    backup=ensure_backup(path)
    shutil.copy2(backup,path)

    rg=RGSS3AArchive(path)

    e=rg.find_entry(SCRIPTS_ENTRY_NAME)
    patched=patch_scripts_bytes(rg.read_entry(e),source)
    rg.replace_entry_by_append(SCRIPTS_ENTRY_NAME,patched)

    try:
        rg.find_entry(OYSTER_SPRITE_ENTRY)
        rg.replace_entry_by_append(OYSTER_SPRITE_ENTRY,sprite_bytes)
    except Exception:
        matches=[x for x in rg.entries if x.name.lower()==OYSTER_SPRITE_ENTRY.lower()]
        if not matches:
            raise FileNotFoundError("Could not find Oyster sprite inside Game.rgss3a.")
        rg.replace_entry_by_append(matches[0].name,sprite_bytes)

    check=RGSS3AArchive(path)
    entries=load_scripts_bytes(check.read_entry(check.find_entry(SCRIPTS_ENTRY_NAME)))
    hits=[x for x in entries if is_our_party_mod(x)]
    if len(hits)!=1 or zlib.decompress(hits[0][2])!=source:
        raise RuntimeError("Final script verification failed.")

    sprite_entry=None
    try:
        sprite_entry=check.find_entry(OYSTER_SPRITE_ENTRY)
    except Exception:
        for x in check.entries:
            if x.name.lower()==OYSTER_SPRITE_ENTRY.lower():
                sprite_entry=x
                break
    if sprite_entry is None or check.read_entry(sprite_entry)!=sprite_bytes:
        raise RuntimeError("Final Oyster sprite archive verification failed.")

    sprite_path,sprite_backup=install_sprite(game_dir)
    return path,backup,sprite_path,sprite_backup

def validate_joiplay_game_dir(game_dir):
    """
    JoiPlay/RPG Maker Plugin can run the normal VX Ace game folder on Android.
    This install mode writes loose Data/Graphics files so no Android-side
    Python executable or RGSS3A rewriting is required.
    """
    game_dir=os.path.abspath(game_dir.strip().strip('"'))
    archive=os.path.join(game_dir,ARCHIVE_NAME)
    if not os.path.isfile(archive):
        raise FileNotFoundError(
            "Game.rgss3a was not found. Select the BLACK SOULS II folder "
            "that you will copy/use with JoiPlay."
        )
    rg=RGSS3AArchive(archive)
    rg.find_entry(SCRIPTS_ENTRY_NAME)
    return game_dir

def install_joiplay(game_dir):
    game_dir=validate_joiplay_game_dir(game_dir)

    source_path=app_resource("BS2_Recruitable_Party.rb")
    sprite_source=app_resource(OYSTER_SPRITE_REL)
    if not os.path.isfile(source_path):
        raise FileNotFoundError("BS2_Recruitable_Party.rb is missing.")
    if not os.path.isfile(sprite_source):
        raise FileNotFoundError("Bundled Cheeky Oyster sprite is missing.")

    source=open(source_path,'rb').read()

    # Read the original Scripts.rvdata2 from Game.rgss3a, inject the Party Mod,
    # then save it as a loose Data/Scripts.rvdata2 file. JoiPlay can use the
    # loose Data file without modifying the encrypted archive on Android.
    archive=os.path.join(game_dir,ARCHIVE_NAME)
    rg=RGSS3AArchive(archive)
    original=rg.read_entry(rg.find_entry(SCRIPTS_ENTRY_NAME))
    patched=patch_scripts_bytes(original,source)

    data_path=os.path.join(game_dir,JOIPLAY_SCRIPTS_REL)
    os.makedirs(os.path.dirname(data_path),exist_ok=True)
    data_backup=data_path+JOIPLAY_BACKUP_SUFFIX
    if os.path.isfile(data_path) and not os.path.isfile(data_backup):
        shutil.copy2(data_path,data_backup)
    with open(data_path,"wb") as f:
        f.write(patched)

    # Verify loose scripts contain exactly this mod version.
    entries=load_scripts_bytes(open(data_path,"rb").read())
    hits=[x for x in entries if is_our_party_mod(x)]
    if len(hits)!=1 or zlib.decompress(hits[0][2])!=source:
        raise RuntimeError("JoiPlay Scripts.rvdata2 verification failed.")

    # Loose Graphics override for the custom Oyster walking sheet.
    sprite_path=os.path.join(game_dir,OYSTER_SPRITE_REL)
    os.makedirs(os.path.dirname(sprite_path),exist_ok=True)
    sprite_backup=sprite_path+JOIPLAY_BACKUP_SUFFIX
    if os.path.isfile(sprite_path) and not os.path.isfile(sprite_backup):
        shutil.copy2(sprite_path,sprite_backup)
    shutil.copy2(sprite_source,sprite_path)

    if open(sprite_path,"rb").read()!=open(sprite_source,"rb").read():
        raise RuntimeError("JoiPlay Oyster sprite verification failed.")

    return data_path, data_backup if os.path.isfile(data_backup) else None, sprite_path, sprite_backup if os.path.isfile(sprite_backup) else None

def restore_joiplay(game_dir):
    game_dir=os.path.abspath(game_dir.strip().strip('"'))
    data_path=os.path.join(game_dir,JOIPLAY_SCRIPTS_REL)
    data_backup=data_path+JOIPLAY_BACKUP_SUFFIX

    if os.path.isfile(data_backup):
        shutil.copy2(data_backup,data_path)
    elif os.path.isfile(data_path):
        # If there was no pre-existing loose Scripts file, removing ours makes
        # the game fall back to the copy inside Game.rgss3a.
        try:
            entries=load_scripts_bytes(open(data_path,"rb").read())
            if any(is_our_party_mod(x) for x in entries):
                os.remove(data_path)
        except Exception:
            pass

    sprite=os.path.join(game_dir,OYSTER_SPRITE_REL)
    sprite_backup=sprite+JOIPLAY_BACKUP_SUFFIX
    if os.path.isfile(sprite_backup):
        shutil.copy2(sprite_backup,sprite)

    return data_path

def restore_mod(game_dir):
    game_dir=os.path.abspath(game_dir.strip().strip('"')); path=os.path.join(game_dir,ARCHIVE_NAME); backup=path+ARCHIVE_BACKUP_SUFFIX
    if not os.path.isfile(backup): raise FileNotFoundError("No party-mod archive backup was found.")
    RGSS3AArchive(backup).find_entry(SCRIPTS_ENTRY_NAME); shutil.copy2(backup,path)

    sprite=os.path.join(game_dir,OYSTER_SPRITE_REL)
    sprite_backup=sprite+SPRITE_BACKUP_SUFFIX
    if os.path.isfile(sprite_backup):
        shutil.copy2(sprite_backup,sprite)
    return path

class App(tk.Tk):
    def __init__(self):
        super().__init__(); self.title(APP_TITLE); self.geometry("760x420"); self.minsize(700,380)
        self.game_dir=tk.StringVar(); self.status=tk.StringVar(value="Select the BLACK SOULS II folder containing Game.exe and Game.rgss3a.")
        f=ttk.Frame(self,padding=18); f.pack(fill='both',expand=True)
        ttk.Label(f,text="BLACK SOULS II Recruitable Party Mod",font=("Segoe UI",17,"bold")).pack(anchor='w')
        ttk.Label(f,text="Game.rgss3a patcher with a bundled custom Cheeky Oyster sprite.").pack(anchor='w',pady=(2,16))
        box=ttk.LabelFrame(f,text="Game Folder",padding=10); box.pack(fill='x')
        row=ttk.Frame(box); row.pack(fill='x'); ttk.Entry(row,textvariable=self.game_dir).pack(side='left',fill='x',expand=True)
        ttk.Button(row,text="Browse...",command=self.browse).pack(side='left',padx=(8,0))
        note="Enjoy uwu"
        ttk.Label(f,text=note,wraplength=620).pack(anchor='w',pady=(16,10))
        row2=ttk.Frame(f); row2.pack(fill='x')
        ttk.Button(row2,text="Install / Update Party Mod",command=self.install).pack(side='left')
        ttk.Button(row2,text="Install for JoiPlay",command=self.install_joiplay).pack(side='left',padx=(10,0))
        ttk.Button(row2,text="Restore Previous Archive",command=self.restore).pack(side='left',padx=(10,0))
        row3=ttk.Frame(f); row3.pack(fill='x',pady=(8,0))
        ttk.Button(row3,text="Restore JoiPlay Files",command=self.restore_joiplay).pack(side='left')
        st=ttk.LabelFrame(f,text="Status",padding=10); st.pack(fill='both',expand=True,pady=(14,0))
        ttk.Label(st,textvariable=self.status,wraplength=610,justify='left').pack(anchor='nw')
    def browse(self):
        p=filedialog.askdirectory(title="Select BLACK SOULS II folder");
        if p: self.game_dir.set(p)
    def install(self):
        try:
            path,backup,sprite,sprite_backup=install_mod(self.game_dir.get()); self.status.set("Installed and verified.\nArchive backup: "+backup+"\nOyster sprite: "+sprite); messagebox.showinfo(APP_TITLE,"Party mod installed successfully.")
        except Exception as e:
            self.status.set("Install failed: "+str(e)); messagebox.showerror(APP_TITLE,str(e))
    def install_joiplay(self):
        try:
            scripts,backup,sprite,sprite_backup=install_joiplay(self.game_dir.get())
            self.status.set(
                "JoiPlay install created and verified.\n"
                "Loose scripts: "+scripts+"\n"
                "Oyster sprite: "+sprite+"\n"
                "Copy/use this BLACK SOULS II folder with JoiPlay."
            )
            messagebox.showinfo(APP_TITLE,"JoiPlay install files created successfully.")
        except Exception as e:
            self.status.set("JoiPlay install failed: "+str(e)); messagebox.showerror(APP_TITLE,str(e))
    def restore_joiplay(self):
        try:
            p=restore_joiplay(self.game_dir.get())
            self.status.set("Restored/removed JoiPlay loose mod files: "+p)
            messagebox.showinfo(APP_TITLE,"JoiPlay files restored.")
        except Exception as e:
            self.status.set("JoiPlay restore failed: "+str(e)); messagebox.showerror(APP_TITLE,str(e))
    def restore(self):
        try:
            p=restore_mod(self.game_dir.get()); self.status.set("Restored previous archive: "+p); messagebox.showinfo(APP_TITLE,"Previous archive restored.")
        except Exception as e:
            self.status.set("Restore failed: "+str(e)); messagebox.showerror(APP_TITLE,str(e))

if __name__=='__main__': App().mainloop()

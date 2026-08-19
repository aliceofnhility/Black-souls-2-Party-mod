#==============================================================================
# BLACK SOULS II Recruitable Party Mod v0.2.5
#==============================================================================
module BS2PartyMod
  VERSION = "0.2.5"
  PERSIST_FILE = "BS2PartyModPersistent.rvdata2"
  # Save inspection confirms the named playable protagonist is Actor 2.
  # Actor 1 is a dummy/alternate actor that receives the same chosen name.
  PLAYER_ID = 2
  REMINISCENCE_MAP_ID = 100
  REMINISCENCE_HELPER_EVENT_ID = 9999
  REMINISCENCE_HELPER_X = 9
  REMINISCENCE_HELPER_Y = 11
  MAX_BATTLE_MEMBERS = 4

  # key => [display name, dynamic actor id, source actor id]
  ROSTER = {
    1=>["Bunny Girl Mary",301,69], 2=>["Cheshire Cat",302,69],
    3=>["Cheeky Oyster",303,69], 4=>["Caterpillar Shisha",304,29],
    5=>["Foolish Bird Dodo",305,25], 6=>["Duchess Margaret Von Tyrol",306,33],
    7=>["Brutalizing Angel Lingeriena",307,72], 8=>["Doctor Blackwell",308,69],
    9=>["Dissolution Queen Sho",309,115], 10=>["Lizard Bill",310,21],
    11=>["White Rabbit Node",311,17], 12=>["White Unicorn Unis",312,61],
    13=>["White Lion Leiden",313,61], 14=>["Wolris, Predator of the Deep Sea",314,88],
    15=>["Red Idol Prickett",315,96], 16=>["Red Hood",316,67],
    17=>["Secret Princess Kuti",317,92], 18=>["Queen of the Heart Lorina",318,37],
    19=>["Mabel, Girl of Nihility",319,69], 20=>["Maid Victoria",320,72],
    21=>["Golden Chick",321,69], 22=>["Mad Bird Jubjub",322,80],
    23=>["Corpse Dragon Jabberwock",323,84], 24=>["Frumious Bandersnatch",324,76],
    25=>["Griffin Knight Griffy",325,61], 26=>["Mock Turtle",326,45],
    27=>["Meryphillia, the Ghoul",327,107], 28=>["Fairy Leaf",328,69],
    29=>["Knight Pumpkin-O",329,60], 30=>["Sackhead Girl",330,69]
  }

  KEYWORDS = {
    1=>["Jack the Ripper","Mary","ばにー"], 2=>["Cheshire Cat"], 3=>["oyster","カキ"],
    4=>["Shisha","シーシャ"], 5=>["Dodo","ドド"], 6=>["Duchess","Margaret","公爵","公爵夫人"],
    7=>["Lingeriena","Brutalizing Angel","ランジェ"], 8=>["Doctor Blackwell","Blackwell","ブラックウェル"],
    9=>["Sho","Dissolution Queen"], 10=>["Bill","ビル"], 11=>["Node","ノーデ"],
    12=>["Unis","ユニ"], 13=>["Leiden","ライデン"], 14=>["Wolris","Walrus","シヴーチ"],
    15=>["Prickett","プリケット"], 16=>["Red Hood","赤ずきん"], 17=>["Kuti","クティ"],
    18=>["Lorina","ロリーナ"], 19=>["Mabel","メイベル"], 20=>["Victoria","ビク","ヴィクトリア","ビクトリア"],
    21=>["Golden Chick","ひよこ","金の雛"], 22=>["Jubjub","ジャブジャブ"], 23=>["Jabberwock","ジャバウォック"],
    24=>["Bandersnatch","バンダースナッチ"], 25=>["Griffy","グリ","グリフィ"],
    26=>["Mock Turtle","Mocky","ウミ","ウミガメ"], 27=>["Meryphillia","ミランダ"],
    28=>["Leaf","リーフ"], 29=>["Pumpkin","パンプキン","ぱんぷ"], 30=>["Sackhead","麻袋女"]
  }

  SKILLS = {
    1=>["Break","Dodge"],
    2=>["Dodge","Break","Treponema","Quick Dance","Grit"],
    3=>["Crushing Depths","Mana Drain","Stone Flesh","Silence Bubble"],
    4=>["Sleep","Soul Light","Dispel","Green Power","Puff of Smoke"],
    5=>["Omniblow","Dodge","Break","Ram","Scrape Flesh","Acrobatics","Run like Dodo"],
    6=>["Sphere of Darkness","Rain of Darkness","Swarm of Darkness","Sleep","Flame","Silence Bubble","Bloody Carthus","Dodge"],
    7=>["Dodge","Break","Brutal Angel's Lullaby","Mana Drain","Dark Side Moon","Omnicurse"],
    8=>["Dodge","Break","Produce Vial"],
    9=>["Acid Rain","Black Wave","Glorpy Purr"],
    10=>["Soul Arrow","Soul Discharge","Soul Light","Soul Radiance","Poison","Poison 2"],
    11=>["Spiritual Unity","Dodge","Knight's Pride","King's Order","Requiem"],
    12=>["Dodge","Break","Counter","Lunge","Riposte","Grand Challenge"],
    13=>["Roar of Thunder","Lion Whirlwind"],
    14=>["Crushing Depths","Ram","Erase"],
    15=>["Queenly Kick","Dodge","Break","Sing"],
    17=>["Dispel","Soul Light","Heavy Soul Discharge","Buccal Cone","The Stars are right","Raise"],
    18=>["Behead","Red Rose","Royal Tea","Dodge","Break"],
    19=>["Awakening","Black Slash","Black Wave","Catherine's Wheel","Counter"],
    20=>["Dodge","Break","Enemy Poison Tea","Mana Drain","Dark Side Moon","Omnicurse"],
    21=>[],
    22=>["Mad Bird's Shriek","Scratch","Ram","Storm Ruler","Supreme Storm Ruler","Dodge","Break"],
    23=>["Dodge","Break","Dusk of Resentment","Corpse-Dragon's Coercion","Soul Break","Poison Breath"],
    24=>["Dodge","Break","Ram","Frumious Wrath","Scorching Flames","Divine Lightning","Counter","Conflagration","Flame"],
    25=>["Soul Radiance","Dodge","Break","Spear Thrust"],
    26=>["Delicious Soup","Dodge","Raise"],
    27=>["Dodge","Break","Miranda's Axe","Execution Verdict"],
    28=>[], 29=>["Thrust","Double Slash","Rain of Darkness","Break","Guard","Blood Edge"], 30=>[]
  }

  SKILL_IDS = {1=>[13,12],2=>[12,13,814,573,75],3=>[552,50,22,136],4=>[39,15,96,139],5=>[212,12,13,455,117,87,340],6=>[28,29,30,39,132,136,145,12],7=>[12,13,50,141,240],8=>[12,13],9=>[842,293],10=>[14,24,15,25,35,36],11=>[32,12,93,140,138],12=>[12,13,21,969,970,971],13=>[985,986],14=>[552,455,113],15=>[452,12,13,454],17=>[96,15,88,569,581,33],18=>[151,425,844,12,13],19=>[850,849,293,846,21],20=>[12,13,50,141,240],21=>[],22=>[497,67,455,191,193,12,13],23=>[12,13,464,465,466,211],24=>[12,13,455,469,314,128,21,143,132],25=>[25,12,13,71],26=>[604,12,33],27=>[12,13,498,615],28=>[],29=>[60,59,29,13,2,119],30=>[]}



  COVENANT_SPIRITS = {4=>[13,14,15,16],5=>[9,10,11,12],6=>[17,18,19,20],9=>[65,66,67,68],
    10=>[5,6,7,8],11=>[1,2,3,4],14=>[49,50,51,52],15=>[57,58,59,60],17=>[53,54,55,56],
    18=>[21,22,23,24],20=>[33,34,35,36],22=>[41,42,43,44],23=>[45,46,47,48],24=>[37,38,39,40],26=>[29,30,31,32]}

  COOLDOWNS = {"Puff of Smoke"=>5,"Glorpy Purr"=>5,"Produce Vial"=>1,"The Stars are right"=>20,
    "Behead"=>3,"Red Rose"=>5,"Enemy Poison Tea"=>10,"Scorching Flames"=>5,"Divine Lightning"=>6,"Spear Thrust"=>2}

  CUSTOM_SKILLS = {
    "Puff of Smoke"=>[50,8], "Brutal Angel's Lullaby"=>[200,8], "Produce Vial"=>[150,11],
    "Glorpy Purr"=>[300,7], "Enemy Poison Tea"=>[300,2], "Sing"=>[2000,2]
  }

  CUSTOM_SKILL_DESCRIPTIONS = {
    "Puff of Smoke"=>"Blows smoke across allies increasing overall attack,\nbut causing worsened defense"
  }

  SKILL_ALIASES = {
    "Mana Drain"=>"Drain Mana",
    "Silence Bubble"=>"Asphyxiation Bubble",
    "Poison 2"=>"Poison II",
    "Omniblow"=>"Omnistrike",
    "The Stars are right"=>"The Stars Are Right"
  }

  LOCKED_EQUIPS = {22=>["Butcher's Ring"],28=>["Mary's Magical Wand","Leaf's Ring"]}
  START_EQUIPS = {2=>["Kaiser Knuckles"],12=>["Unis' Rapier"],13=>["Leiden's Twin Axes"],
    22=>["Mad Bow Jubjub","Butcher's Ring"],23=>["Rotten Scythe Jabberwock"],
    24=>["Violent Sword Bandersnatch"],
    25=>["Griffin Shield"],26=>["Mock Turtle's Ladle"],27=>["Miranda's Axe"],
    28=>["Mary's Magical Wand","Leaf's Ring"]}

  PERSIST_KEYS = [:end_g,:grand_guignol_end,:all_fairytales,:jubjub_ring,:leaf_relocated,:jabber_20_souls]
  JUBJUB_MADNESS_SWITCHES = (475..484).to_a + [566]

  def self.log(msg)
    File.open("BS2PartyMod.log","ab") {|f| f.write("#{msg}\r\n") } rescue nil
  end
  def self.sys
    $game_system
  end
  def self.cycle
    sys.instance_variable_get(:@bs2pm_cycle) || sys.instance_variable_set(:@bs2pm_cycle,{})
  end
  def self.persist
    @persist ||= begin
      File.exist?(PERSIST_FILE) ? (Marshal.load(File.binread(PERSIST_FILE)) rescue {}) : {}
    end
  end
  def self.save_persist
    File.binwrite(PERSIST_FILE,Marshal.dump(persist)) rescue nil
  end

  def self.unlock_all_recruits?
    !!(sys && sys.instance_variable_get(:@bs2pm_unlock_all_recruits))
  rescue
    false
  end

  def self.global_ai?
    !!(sys && sys.instance_variable_get(:@bs2pm_global_ai))
  rescue
    false
  end

  def self.set_global_ai(value)
    sys.instance_variable_set(:@bs2pm_global_ai,!!value)
    # Clear any pending Leaf takeover roll when AI is enabled.
    if value
      leaf=actor(28) rescue nil
      leaf.instance_variable_set(:@bs2pm_leaf_takeover_turn,false) if leaf
    end
    show(value ? "Ally AI enabled." : "Ally AI disabled.")
    log("Room of Reminiscence: global ally AI #{value ? 'ON' : 'OFF'}")
  end

  def self.unlock_all_recruits
    sys.instance_variable_set(:@bs2pm_unlock_all_recruits,true)
    show("All recruit conditions are now unlocked.")
    log("Room of Reminiscence: Unlock all recruits enabled")
  end

  def self.undo_recruit_progression
    sys.instance_variable_set(:@bs2pm_unlock_all_recruits,false)
    # Reset only Party Mod progression. Base-game story switches, Covenants,
    # endings, items, and quest state are intentionally left untouched.
    sys.instance_variable_set(:@bs2pm_cycle,{})
    @persist={}
    save_persist
    if $game_party
      ROSTER.each_key do |k|
        next if k.to_i==11 && runtime_actor_id($game_party.leader).to_i==actor_id(k).to_i
        $game_party.remove_actor(actor_id(k)) rescue nil
      end
    end
    show("Party Mod recruit progression has been reset.")
    log("Room of Reminiscence: recruit progression reset")
  end
  def self.flag(k,persistent=false)
    (persistent ? persist : cycle)[k]
  end
  def self.set_flag(k,v=true,persistent=false)
    (persistent ? persist : cycle)[k]=v; save_persist if persistent; v
  end
  def self.actor_id(key); ROSTER[key][1]; end
  def self.runtime_actor_id(actor)
    return nil unless actor
    return actor.actor_id if actor.respond_to?(:actor_id)
    actor.instance_variable_get(:@actor_id) rescue nil
  end
  def self.key_for_actor(actor)
    aid=runtime_actor_id(actor)
    ROSTER.keys.find{|k| ROSTER[k][1]==aid}
  end
  def self.actor(key); $game_actors[actor_id(key)]; end
  def self.in_party?(key)
    return false unless $game_party
    wanted=actor_id(key)
    $game_party.members.any?{|a| runtime_actor_id(a).to_i==wanted.to_i}
  end
  def self.name(key); ROSTER[key][0]; end

  def self.normalize_name(v)
    v.to_s.downcase.gsub(/[^a-z0-9]+/,"")
  end
  def self.by_name(arr,name)
    return nil unless arr
    target=normalize_name(name)
    arr.find{|x| x && normalize_name(x.name)==target}
  end
  def self.skill(name)
    actual=SKILL_ALIASES[name.to_s] || name.to_s
    s=by_name($data_skills,actual)
    log("missing technique #{name.inspect} (resolved #{actual.inspect})") unless s
    s
  end
  def self.item(name); by_name($data_items,name); end
  def self.weapon(name); by_name($data_weapons,name); end
  def self.armor(name); by_name($data_armors,name); end
  def self.state(name); by_name($data_states,name); end


  ACTOR_SCHEMA_VERSION = 210

  # Actor 1 begins the database on a deliberately extreme dummy class (13).
  # The opening event later assigns Grimm's real playable class.  Companions
  # therefore MUST copy Grimm's current runtime class, not Actor 1's database
  # startup class.
  def self.grimm_actor
    $game_actors[PLAYER_ID] rescue nil
  end

  def self.grimm_playable_class
    p=grimm_actor
    p ? p.class : nil
  rescue
    nil
  end

  def self.grimm_base_param_at(level,param_id)
    cls=grimm_playable_class
    return 1 unless cls && cls.respond_to?(:params)

    lv=[[level.to_i,1].max,999].min
    if lv<=99
      v=cls.params[param_id,lv].to_i
    else
      p99=cls.params[param_id,99].to_i
      step=cls.params[param_id,99].to_i-cls.params[param_id,98].to_i
      # BLACK SOULS II's MLV_CHANGE::P_RATE is 105 by default.
      v=p99+(step*(lv-99)*1.05).truncate
    end
    [v,1].max
  rescue
    1
  end

  def self.companion_class_ids
    @companion_class_ids ||= {}
  end

  def self.copy_class_for_companion(base,key,cid=nil)
    return nil unless base
    cls=Marshal.load(Marshal.dump(base))
    cid ||= $data_classes.length
    cls.id=cid if cls.respond_to?(:id=)
    cls.name="#{name(key)}" if cls.respond_to?(:name=)
    if cls.respond_to?(:learnings)
      cls.learnings.clear
    else
      cls.instance_variable_set(:@learnings,[])
    end
    if cid < $data_classes.length
      $data_classes[cid]=cls
    else
      $data_classes << cls
    end
    cid
  end

  def self.create_companion_class(key)
    return companion_class_ids[key] if companion_class_ids[key]
    # Use a harmless normal class as the load-time placeholder. It is replaced
    # with Grimm's CURRENT playable class before the companion is configured.
    base=$data_classes[11] || $data_classes.compact.first
    cid=copy_class_for_companion(base,key)
    companion_class_ids[key]=cid
    cid
  end

  def self.refresh_companion_class(key)
    cid=companion_class_ids[key] || create_companion_class(key)
    base=grimm_playable_class
    return cid unless base
    copy_class_for_companion(base,key,cid)
    log("refreshed companion class key=#{key} cid=#{cid} grimm_class=#{base.id rescue '?'} #{base.name rescue ''} lv1=#{(0..7).map{|p| base.params[p,1] rescue nil}.inspect}")
    cid
  end

  def self.clone_actor_data(source_id,new_id,new_name,key)
    grimm=$data_actors[PLAYER_ID]
    src=$data_actors[source_id] || grimm
    obj=Marshal.load(Marshal.dump(grimm))
    obj.id=new_id if obj.respond_to?(:id=)
    obj.name=new_name if obj.respond_to?(:name=)
    obj.class_id=create_companion_class(key) if obj.respond_to?(:class_id=)
    obj.initial_level=1 if obj.respond_to?(:initial_level=)

    # Preserve only the NPC's presentation data. Combat data comes from Grimm.
    [:face_name,:face_index,:character_name,:character_index].each do |field|
      getter=field
      setter=(field.to_s+"=").to_sym
      if src.respond_to?(getter) && obj.respond_to?(setter)
        obj.send(setter,src.send(getter))
      end
    end
    if key.to_i==21
      obj.character_name="$ハンプティ２" if obj.respond_to?(:character_name=)
      obj.character_index=0 if obj.respond_to?(:character_index=)
      obj.face_name="ハン２" if obj.respond_to?(:face_name=)
      obj.face_index=0 if obj.respond_to?(:face_index=)
    end
    if key.to_i==3
      # Cheeky Oyster's actual Map140/Event21 walking graphic.
      obj.character_name="$カキ" if obj.respond_to?(:character_name=)
      obj.character_index=0 if obj.respond_to?(:character_index=)
      obj.face_name="カキ" if obj.respond_to?(:face_name=)
      obj.face_index=0 if obj.respond_to?(:face_index=)
    end

    if key.to_i==29
      # Pumpkin-O's actual Map116/Event13 walking graphic.
      obj.character_name="!$かぼちゃオー" if obj.respond_to?(:character_name=)
      obj.character_index=0 if obj.respond_to?(:character_index=)
    end
    # Starting equipment is assigned explicitly by START_EQUIPS.
    if obj.respond_to?(:equips)
      obj.equips.each_index{|i| obj.equips[i]=0} rescue nil
    else
      obj.instance_variable_set(:@equips,[0,0,0,0,0])
    end
    $data_actors[new_id]=obj
  end

  def self.make_custom_skill(name,mp,scope)
    return if skill(name)
    base=skill("Guard") || $data_skills.compact.first
    s=Marshal.load(Marshal.dump(base))
    s.id=$data_skills.length if s.respond_to?(:id=)
    s.name=name
    desc=CUSTOM_SKILL_DESCRIPTIONS[name]
    s.description=desc if desc && s.respond_to?(:description=)
    s.mp_cost=mp if s.respond_to?(:mp_cost=)
    s.scope=scope if s.respond_to?(:scope=)
    s.stype_id=1 if s.respond_to?(:stype_id=)
    if s.respond_to?(:damage) && s.damage
      s.damage.type=0 if s.damage.respond_to?(:type=)
      s.damage.formula="0" if s.damage.respond_to?(:formula=)
    end
    $data_skills << s
  end

  def self.setup_database
    companion_class_ids.clear
    ROSTER.each{|k,v| create_companion_class(k)}
    ROSTER.each{|k,v| clone_actor_data(v[2],v[1],v[0],k)}
    CUSTOM_SKILLS.each{|n,a| make_custom_skill(n,a[0],a[1])}
    make_custom_skill("Sing",2000,2)

    # Jabberwock's three unique base-game skills are stype 0 (hidden/enemy
    # skills). Her recruited version needs them in the normal Techniques menu.
    [464,465,466].each do |sid|
      sk=$data_skills[sid] rescue nil
      sk.stype_id=1 if sk && sk.respond_to?(:stype_id=)
    end

    # Prickette's Queenly Kick is also stored as hidden stype 0 in the base
    # game. Her recruited version needs it in the normal Techniques category.
    qk=$data_skills[452] rescue nil
    qk.stype_id=1 if qk && qk.respond_to?(:stype_id=)

    # Learn Skill tomes in BLACK SOULS II normally use Scope 11 (User).
    # That makes Scene_ItemBase silently choose the party member with the
    # highest PHA. Convert only items containing effect code 43 (Learn Skill)
    # to Scope 7 (One Ally), so the player can select any active member.
    $data_items.compact.each do |it|
      effects=(it.effects rescue [])
      if effects.any?{|e| (e.code rescue 0).to_i==43}
        it.scope=7 if it.respond_to?(:scope=)
      end
    end
  end

  def self.configure_actor(actor,key,reset_skills=false)
    return unless actor && key
    cid=refresh_companion_class(key)
    current_level=[actor.level.to_i,1].max rescue 1

    begin
      actor.change_class(cid,true) if actor.class_id.to_i != cid.to_i
    rescue
      actor.instance_variable_set(:@class_id,cid)
    end

    schema=actor.instance_variable_get(:@bs2pm_actor_schema).to_i
    if reset_skills || schema < ACTOR_SCHEMA_VERSION
      # Remove techniques inherited from older Party Mod versions / Grimm class.
      actor.instance_variable_set(:@skills,[])
      actor.instance_variable_set(:@skill_seal,[])
      actor.clear_param_plus rescue actor.instance_variable_set(:@param_plus,[0]*8)
      learn_setup(actor,key)
      actor.instance_variable_set(:@bs2pm_actor_schema,ACTOR_SCHEMA_VERSION)
      log("migrated #{name(key)} actor=#{runtime_actor_id(actor)} class=#{cid} level=#{current_level}")
    end
    actor.refresh rescue nil
    actor
  end

  def self.migrate_existing_actors
    return unless $game_actors
    ROSTER.each do |key,data|
      aid=data[1]
      a=$game_actors.instance_variable_get(:@data)[aid] rescue nil
      configure_actor(a,key,false) if a
    end
  end

  def self.covenant_level(key)
    ids=COVENANT_SPIRITS[key]
    return 0 unless ids && $game_party
    spirits=$game_party.instance_variable_get(:@spirits) rescue []
    spirits=spirits.to_a.map{|x| x.to_i}
    # Visible Covenant levels are 0,1,2,3. The four stored spirit forms map
    # directly to those values in order.
    level=0
    ids.each_with_index do |sid,i|
      level=i if spirits.include?(sid.to_i)
    end
    log("covenant key=#{key} spirits=#{spirits.inspect} ids=#{ids.inspect} level=#{level}")
    level
  end

  def self.learn_setup(actor,key)
    SKILL_IDS[key].to_a.each do |sid|
      if $data_skills[sid]
        actor.learn_skill(sid)
        log("learned #{name(key)} technique #{$data_skills[sid].name} id=#{sid}")
      end
    end
    # Custom techniques created by this mod are still resolved by name.
    SKILLS[key].to_a.each do |n|
      next unless CUSTOM_SKILLS.key?(n) || n=="Sing"
      s=skill(n); actor.learn_skill(s.id) if s
    end
    if key==10 && $game_actors[PLAYER_ID].level>=50
      s=skill("Serpent's Embrace"); actor.learn_skill(s.id) if s
    end
    START_EQUIPS[key].to_a.each do |n|
      eq=weapon(n)||armor(n); next unless eq
      slot=actor.equip_slots.index(eq.etype_id) rescue nil
      actor.force_change_equip(slot,eq) if slot
    end
  end

  # Temporarily remove recruited companions from their world NPC spots.
  # Node (key 11) is deliberately exempt.
  def self.refresh_world_party_npcs
    return unless $game_map && $game_map.respond_to?(:events)
    $game_map.events.each_value do |ev|
      ev.bs2pm_refresh_party_presence if ev.respond_to?(:bs2pm_refresh_party_presence)
    end
  rescue => e
    log("world NPC refresh failed: #{e.class}: #{e.message}")
  end

  def self.recruit(key)
    return if in_party?(key)
    a=actor(key); return unless a
    first_time = !cycle[[:ever_recruited,key]]
    configure_actor(a,key,first_time)
    if first_time
      # Non-Node companions begin at Lv1. Node keeps her Covenant-derived level.
      target = 1
      a.change_level(target,false) rescue nil
      configure_actor(a,key,false)
      cycle[[:ever_recruited,key]]=true
    end
    $game_party.add_actor(runtime_actor_id(a))
    refresh_map_followers
    refresh_world_party_npcs
    log("recruited #{key}:#{name(key)} actor=#{runtime_actor_id(a)} level=#{a.level}")
    cycle[[:recruited,key]]=true
    say(21,"Of course Papa!") if key==21
    show("#{name(key)} joined the party.")
  end

  def self.dismiss(key)
    return if key.nil? || key<=0
    $game_party.remove_actor(actor_id(key))
    refresh_map_followers
    refresh_world_party_npcs
    show("#{name(key)} left the active party.")
  end

  # Special Party-menu dismissal route for Leaf only.
  # This deliberately does not alter generic dismissal/removal behavior.
  def self.dismiss_leaf_to_endless_tea_party
    return unless in_party?(28)

    # Cycle-local home marker: this is only about where Leaf returns after
    # being dismissed from the Party menu, not her story/progression state.
    set_flag(:leaf_party_menu_home_endless)

    $game_party.remove_actor(actor_id(28))
    refresh_map_followers

    # If currently standing in Fairy Jail, remove the visible Mary/Leaf copies
    # immediately. Otherwise they will be removed the next time Map060 loads.
    if ($game_map.map_id rescue 0).to_i==60 &&
       $game_map.respond_to?(:bs2pm_remove_leaf_after_party_dismiss)
      $game_map.bs2pm_remove_leaf_after_party_dismiss
    end

    # If already in Endless Tea Party, create her return NPC immediately.
    if ($game_map.map_id rescue 0).to_i==156 &&
       $game_map.respond_to?(:bs2pm_add_relocated_leaf_event)
      $game_map.bs2pm_add_relocated_leaf_event
    end

    refresh_world_party_npcs
    show("#{name(28)} left the active party.")
  end

  # Endless Tea Party Leaf can be killed after being dismissed there.
  # She stays gone for the rest of the CURRENT cycle. Clearing the persistent
  # relocation flag means the NEXT cycle uses her normal Fairy Jail location.
  def self.kill_endless_tea_party_leaf
    return unless ($game_map.map_id rescue 0).to_i==156

    set_flag(:leaf_killed_this_cycle)
    set_flag(:leaf_party_menu_home_endless,false)

    # Undo the persistent relocation for future cycles.
    set_flag(:leaf_relocated,false,true)

    ev=$game_map.events[990] rescue nil
    ev.erase if ev
    $game_map.events.delete(990) rescue nil

    log("Leaf killed in Endless Tea Party; return to Fairy Jail next cycle")
  end

  def self.show(text)
    $game_message.add(text.to_s)
    Fiber.yield while $game_message.busy? if Fiber.current rescue nil
  end

  # Character dialogue using BLACK SOULS II's native face + Name Window
  # presentation. System/narration messages should continue using show().
  def self.say_face(face_name,face_index,speaker,text)
    old_name_window=($game_system.use_name_window rescue false)
    old_direct=($game_temp.direct_show_name rescue "")
    begin
      $game_system.use_name_window=true if $game_system.respond_to?(:use_name_window=)
      $game_temp.direct_show_name=speaker.to_s if $game_temp.respond_to?(:direct_show_name=)
      $game_message.face_name=face_name.to_s
      $game_message.face_index=face_index.to_i
      $game_message.add(text.to_s)
      Fiber.yield while $game_message.busy? if Fiber.current rescue nil
    ensure
      $game_system.use_name_window=old_name_window if $game_system.respond_to?(:use_name_window=)
      $game_temp.direct_show_name=old_direct if $game_temp.respond_to?(:direct_show_name=)
    end
  end

  def self.say(key,text,speaker=nil)
    data=$data_actors[actor_id(key)] rescue nil
    return show(text) unless data
    say_face(data.face_name,data.face_index,(speaker || name(key)),text)
  end

  def self.say_jubjub(text)
    # Use Jubjub's actual base-game dialogue portrait instead of the cloned
    # companion actor presentation.
    say_face("ジャブ",0,"Mad Bird Jubjub",text)
  end

  def self.say_kuti(text)
    # Use Kuti's configured actor portrait/name so the line renders like her
    # other character dialogue.
    say(17,text,"Secret Princess Kuti")
  end

  def self.say_oyster(text)
    say_face("カキ",0,"Cheeky Oyster",text)
  end

  def self.kuti_native_battle_tail(list)
    arr=Marshal.load(Marshal.dump(list))
    kill_idx=nil
    branch_end=nil

    arr.each_with_index do |cmd,i|
      if cmd.code.to_i==402 &&
         (cmd.parameters[1] rescue "").to_s.downcase.include?("kill")
        kill_idx=i
        ((i+1)...arr.length).each do |j|
          c=arr[j]
          if c.code.to_i==404 && c.indent.to_i==cmd.indent.to_i
            branch_end=j
            break
          end
        end
        break
      end
    end
    return nil unless kill_idx && branch_end

    battle_idx=nil
    ((kill_idx+1)...branch_end).each do |i|
      c=arr[i]
      if c.code.to_i==301 && (c.parameters[1] rescue 0).to_i==332
        battle_idx=i
        break
      end
    end
    return nil unless battle_idx

    # Copy from Kuti's native troop-332 battle through the rest of the Kill
    # branch, including normal victory/death cleanup, but skip her original
    # pre-battle Kill dialogue because this mod supplies its own scene.
    tail=[]
    base=arr[kill_idx].indent.to_i+1
    (battle_idx...branch_end).each do |i|
      c=arr[i]
      break if c.code.to_i==402 && c.indent.to_i==arr[kill_idx].indent.to_i
      x=Marshal.load(Marshal.dump(c))
      x.indent=[x.indent.to_i-base,0].max

      # Kuti/Oyster hostility must be lethal. Kuti's native event allows loss
      # (battle params [0,332,false,true]); force can_lose=false here so defeat
      # uses the engine's normal Game Over behavior.
      if x.code.to_i==301 && (x.parameters[1] rescue 0).to_i==332
        x.parameters[3]=false
      end

      tail << x
    end
    tail
  end

  def self.say_golden_chick(text)
    # Golden Chick's actual base-game dialogue portrait from Map146/Event9.
    say_face("ハン２",0,"Golden Chick",text)
  end

  def self.golden_chick_jubjub_talk
    return unless in_party?(22)
    return if flag(:jubjub_chick_talk)
    say_jubjub("Hey sweetie how are you doing?")
    say_golden_chick("I'm doing good Big sis!!")
    set_flag(:jubjub_chick_talk)
  end

  def self.say_hatta(text)
    say_face("帽子屋",0,"Hatter Hatta",text)
  end

  def self.say_haigha(text)
    say_face("三月兎",0,"March Hare Haigha",text)
  end

  def self.say_dormouse(text)
    say_face("眠り鼠",0,"Sleeping Rat Dormouse",text)
  end
  def self.choose(text,choices)
    result=nil; $game_message.add(text); choices.each{|c| $game_message.choices.push(c)}
    $game_message.choice_cancel_type=choices.length
    $game_message.choice_proc=Proc.new{|n| result=n}
    Fiber.yield while $game_message.choice?
    result
  end

  def self.node_level_candidates
    return [] unless $game_party
    ($game_party.battle_members rescue $game_party.members).select do |a|
      key=key_for_actor(a)
      key != 11  # Node herself cannot be trained through Node.
    end
  end

  def self.node_choose_level_actor
    actors=node_level_candidates
    return nil if actors.empty?
    labels=actors.map{|a| "#{a.name}  Lv#{a.level}"} + ["Cancel"]
    idx=choose("Whose souls should Node strengthen?",labels)
    return nil if idx.nil? || idx.to_i>=actors.length
    actors[idx.to_i]
  end

  def self.event_text(map_id,event_id)
    ev=$game_map.events[event_id] rescue nil; return "" unless ev
    list=ev.list rescue []
    parts=[(ev.event.name.to_s rescue "")]
    list.to_a.each do |c|
      # 101's first parameter is the speaker/face identifier in this build.
      if c.code==101 && c.parameters && c.parameters[0]
        parts << c.parameters[0].to_s
      elsif [401,405].include?(c.code) && c.parameters[0]
        parts << c.parameters[0].to_s
      end
    end
    parts.join(" ")
  end

  # Some BS2 conversations mention several named NPCs on one event page.
  # Prefer the actual event identity/name before scanning dialogue, otherwise
  # a Shisha/Dodo or multi-NPC scene becomes ambiguous and no recruit is found.
  DIRECT_EVENT_KEYS = {
    [59,7]=>1, [59,9]=>1, [166,14]=>1,        # Mary
    [62,76]=>10, [62,84]=>10,                  # Bill
    [74,6]=>4,                                  # Shisha - Covenant/talk menu
    [37,53]=>5, [74,13]=>5,                    # Dodo
    [80,14]=>6,                                 # Duchess Margaret - normal Covenant menu
    [320,21]=>7, [320,119]=>7,                 # Lingeriena
    [101,9]=>11,                                # Node (Dream Library)
    [334,11]=>12, [342,17]=>12, [348,22]=>12, # Unis
    [335,8]=>13, [335,16]=>13, [342,22]=>13,
    [348,23]=>13,                               # Leiden
    [125,10]=>14,                               # Wolris
    [169,8]=>15,                                # Prickett
    [197,4]=>17,                                # Kuti
    [137,7]=>18,                                # Lorina
    [140,21]=>3,                                # Cheeky Oyster
    [146,9]=>21,                                # Golden Chick
    [60,3]=>28,                                 # Fairy Leaf / Mary Ann / Mary Sue
    [104,8]=>25,                                # Griffy
    [27,3]=>26, [27,9]=>26,                    # Mock Turtle
    [133,5]=>24,                                # Bandersnatch
    [180,10]=>23,                               # Jabberwock normal menu
    [116,13]=>29,                              # Pumpkin-O - home/Pumpkin Base only
    [323,14]=>30,                               # Sackhead Girl
    [43,10]=>22,                               # Jubjub first post-battle menu
    [43,11]=>22                                # Jubjub normal menu
  }

  def self.event_name_for(event_id)
    ev=$game_map.events[event_id] rescue nil
    (ev && ev.event ? ev.event.name.to_s : "")
  rescue
    ""
  end

  def self.detect_key_for_event(map_id,event_id,text)
    # Hatta and Haigha are special non-party NPCs. Their dialogue can mention
    # roster characters (including Jubjub), so never identify them through
    # dialogue-keyword fallback.
    return nil if [[156,25],[156,26]].include?([map_id.to_i,event_id.to_i])

    direct=DIRECT_EVENT_KEYS[[map_id.to_i,event_id.to_i]]
    return direct if direct

    n=event_name_for(event_id).downcase

    # Pumpkin-O has several world copies. Recruitment belongs ONLY to his
    # home in Pumpkin Base: Map116/Event13.
    pumpkin_name=(n.include?("pumpkin") || n.include?("パンプキン") || n.include?("ぱんぷ"))
    return nil if pumpkin_name && [map_id.to_i,event_id.to_i] != [116,13]
    unless n.empty?
      hits=[]
      KEYWORDS.each{|k,words| hits<<k if words.any?{|w| n.include?(w.to_s.downcase)}}
      return hits[0] if hits.length==1
    end
    detect_key(text)
  end

  def self.capture_appearance(key,event_id)
    # Pumpkin-O and Cheeky Oyster use fixed real NPC walking graphics.
    # Do not let unrelated/alternate event pages overwrite them.
    return if [3,29].include?(key.to_i)
    ev=$game_map.events[event_id] rescue nil; return unless ev
    data=$data_actors[actor_id(key)] rescue nil; return unless data
    begin
      g=ev.page.graphic
      data.character_name=g.character_name if data.respond_to?(:character_name=) && g.character_name.to_s!=""
      data.character_index=g.character_index if data.respond_to?(:character_index=)
    rescue; end
    begin
      ev.list.to_a.each do |c|
        next unless c.code==101
        face=c.parameters[0].to_s; idx=c.parameters[1].to_i
        if face!=""
          data.face_name=face if data.respond_to?(:face_name=); data.face_index=idx if data.respond_to?(:face_index=); break
        end
      end
    rescue; end
  end

  def self.detect_key(text)
    down=text.to_s.downcase
    hits=[]
    KEYWORDS.each{|k,words| hits<<k if words.any?{|w| down.include?(w.to_s.downcase)}}
    hits.length==1 ? hits[0] : nil
  end

  def self.dead_or_dungeon_text?(txt)
    s=txt.downcase
    s.include?("corpse") || s.include?("conversation isn't happening") || s.include?("head exploded")
  end

  def self.item_owned?(name)
    x=item(name)||weapon(name)||armor(name); x && $game_party.has_item?(x,true)
  end

  def self.hatta_covenant_level
    return 0 unless $game_party
    spirits=($game_party.instance_variable_get(:@spirits) rescue []).to_a.map{|x| x.to_i}
    ids=[25,26,27,28]
    level=0
    ids.each_with_index{|sid,i| level=i if spirits.include?(sid)}
    level
  end

  def self.can_unlock_hatta?
    hatta_covenant_level==3 && !item_owned?("Hatta")
  end

  def self.unlock_hatta_item
    return unless can_unlock_hatta?
    say_hatta("Hmm ok")
    x=item("Hatta")
    $game_party.gain_item(x,1) if x
    set_flag(:hatta_met)
  end

  def self.can_unlock_haigha?
    item_owned?("Hatta") && !item_owned?("Haigha Voodoo Doll")
  end

  def self.endless_tea_party_haigha?(map_id,event_id)
    map_id.to_i==156 && event_id.to_i==26
  end

  # Haigha has several alternate native menus across her active event pages.
  # Patch every reachable menu that contains Leave so the Voodoo Doll option
  # is attached to the Endless Tea Party Haigha regardless of her current
  # relationship/page state.
  def self.patch_endless_haigha_choices(list)
    return list unless can_unlock_haigha?
    arr=Marshal.load(Marshal.dump(list))
    targets=[]

    arr.each_with_index do |cmd,i|
      next unless cmd && cmd.code.to_i==102
      choices=(cmd.parameters[0] rescue []).to_a
      next unless choices.any?{|x| x.to_s.downcase.include?("leave")}
      next if choices.any?{|x| x.to_s=="Ask Haigha to join"}

      indent=cmd.indent.to_i
      finish=nil
      depth=0
      ((i+1)...arr.length).each do |j|
        c=arr[j]
        next unless c
        if c.code.to_i==102 && c.indent.to_i==indent
          depth+=1
        elsif c.code.to_i==404 && c.indent.to_i==indent
          if depth==0
            finish=j
            break
          else
            depth-=1
          end
        end
      end
      targets << [i,finish] if finish
    end

    # Work backward so inserted commands do not invalidate earlier indexes.
    targets.reverse_each do |choice_index,finish|
      cmd=arr[choice_index]
      choices=cmd.parameters[0].clone
      idx=choices.length
      choices << "Ask Haigha to join"
      cmd.parameters[0]=choices
      indent=cmd.indent.to_i
      branch=[
        RPG::EventCommand.new(402,indent,[idx,"Ask Haigha to join"]),
        RPG::EventCommand.new(355,indent+1,["BS2PartyMod.unlock_haigha_item"])
      ]
      arr.insert(finish,*branch)
    end

    log("patched Endless Tea Party Haigha menus count=#{targets.length}")
    arr
  rescue => e
    log("Haigha menu patch error: #{e.class}: #{e.message}")
    list
  end

  def self.unlock_haigha_item
    return if item_owned?("Haigha Voodoo Doll")
    unless item_owned?("Hatta")
      say_haigha("Only if Hatta joins~")
      return
    end
    say_haigha("Oki")
    x=item("Haigha Voodoo Doll")
    $game_party.gain_item(x,1) if x
  end

  def self.can_carry_dormouse?
    item_owned?("Hatta") && !item_owned?("Eepy Rat") && !flag(:dormouse_carried)
  end

  def self.carry_dormouse
    return unless can_carry_dormouse?
    x=item("Eepy Rat")
    $game_party.gain_item(x,1) if x
    set_flag(:dormouse_carried)
    ev=$game_map.events[27] rescue nil
    ev.erase if ev
  end

  def self.jubjub_madness_blocked?
    # The lantern/progression route can fire before Jubjub is ever met.
    # Keep the mass-madness cascade disabled until the first Jubjub encounter
    # has completely finished, giving the player a fair chance to use the ring.
    # Once the ring has been given, suppression becomes permanent across cycles.
    flag(:jubjub_ring,true) || !flag(:jubjub_first_encounter_done)
  end

  def self.suppress_jubjub_madness
    return unless jubjub_madness_blocked?
    # Keep the NPC madness switches off while protection is active.
    JUBJUB_MADNESS_SWITCHES.each{|sid| $game_switches[sid]=false rescue nil}

    # Only the permanent ring route should suppress Jubjub's local madness
    # speech/page with self-switch D. Pre-encounter protection must not alter
    # her normal first meeting.
    if flag(:jubjub_ring,true)
      $game_self_switches[[43,11,"D"]]=true rescue nil
    end
  end

  def self.sync_jubjub_ring_state
    suppress_jubjub_madness
  end

  def self.can_give_jubjub_ring?
    return false if flag(:jubjub_ring,true)
    ring=armor("Butcher's Ring")
    !!(ring && $game_party && $game_party.has_item?(ring,true))
  end

  def self.give_jubjub_ring
    return unless can_give_jubjub_ring?
    ring=armor("Butcher's Ring")
    $game_party.lose_item(ring,1,true)

    # Set the permanent Party Mod route first, then suppress all madness state
    # before advancing Jubjub's base-game event page.
    set_flag(:jubjub_ring,true,true)
    suppress_jubjub_madness

    # BLACK SOULS II has no "spared but not covenant" Jubjub page. Switch 460
    # is the only page gate that moves Event10 out of the repeat-fight state
    # and exposes Event11's normal interaction menu. Set the switch directly
    # WITHOUT calling Common Event 90, so no Covenant spirit is granted here.
    # The player can still choose Event11's normal Covenant option afterward.
    $game_switches[460]=true
    suppress_jubjub_madness

    say_jubjub("I've been using madness as a means to cope,")
    say_jubjub("but for you I'll stop")
  end

  def self.wolris_killed?
    # BLACK SOULS II's own Cheeky Oyster event checks switch 549 to determine
    # whether the Walrus/Wolris has been killed. Use that as the source of
    # truth, with the Party Mod flag only as a fallback.
    base_dead=($game_switches[549] rescue false)
    set_flag(:wolris_dead) if base_dead && !flag(:wolris_dead)
    base_dead || flag(:wolris_dead)
  end

  def self.eligible?(key,map_id,text)
    return true if unlock_all_recruits?
    # Covenant recruits use ONE requirement only: current visible Covenant Lv3.
    if COVENANT_SPIRITS.key?(key)
      return covenant_level(key) == 3
    end
    return false if dead_or_dungeon_text?(text) && key!=12
    case key
    when 1 then flag(:jack_ripper_dead)
    when 2 then flag(:end_g,true)
    when 3 then wolris_killed?
    when 4 then flag(:shisha_chosen) || ($game_switches[587] rescue false)
    when 5 then flag(:dodo_shisha_event) || ($game_switches[584] rescue false)
    when 6 then flag(:train_ticket,true) || item_owned?("Train Ticket")
    when 7 then flag(:lingeriena_saved) && in_party?(20)
    when 8 then text.downcase.include?("church") || map_id.to_i==34
    when 9 then covenant_level(9)>=3 && flag(:sho_love_answer)
    when 10 then flag(:serpent_blood,true) || item_owned?("Serpent God\'s Blood") || ($game_switches[619] rescue false)
    when 11 then flag(:all_fairytales,true)
    when 12 then true
    when 13 then flag(:unis_dead)
    when 14 then flag(:deep_sea_knight_dead)
    when 15 then flag(:prickett_date)
    when 16 then flag(:end_g,true)
    when 17 then covenant_level(17)>=3 && flag(:kuti_romance)
    when 18 then flag(:lorina_cards) || ($game_switches[824] rescue false)
    when 19 then flag(:grand_guignol_end,true)
    when 20 then covenant_level(20)>=3
    when 21 then true
    when 22 then flag(:jubjub_ring,true) && !in_party?(23) && !in_party?(24)
    when 23 then flag(:jabber_20_souls,true)
    when 24 then covenant_level(24)>=3
    when 25 then map_id.to_i==27 && !in_party?(18)
    when 26 then in_party?(25)
    when 27 then flag(:mery_hidden_body)
    when 28 then flag(:leaf_relocated,true)
    when 29 then map_id.to_i==116
    when 30 then flag(:sackhead_viscera)
    else false end
  end

  def self.after_talk(map_id,event_id)
    return if event_id.to_i<=0 || map_id.to_i==100
    txt=event_text(map_id,event_id)

    # Event10 is Jubjub's first encounter. Do not lift the pre-encounter
    # madness shield until the entire event has completed.
    if map_id.to_i==43 && event_id.to_i==10
      set_flag(:jubjub_first_encounter_done)
      log("Jubjub first encounter completed; pre-encounter madness shield lifted")
    end
    # persistent progression detectors that have reliable post-event locations/text.
    set_flag(:end_g,true,true) if map_id.to_i==152 && txt.include?("Cheshire")
    set_flag(:all_fairytales,true,true) if txt.downcase.include?("return all fairy tales")
    set_flag(:sackhead_viscera) if txt.downcase.include?("sweet, sweet viscera") && txt.downcase.include?("thank you")
    set_flag(:prickett_date) if txt.downcase.include?("date") && txt.downcase.include?("prickett")

    # Hatta and Haigha unlock options are integrated directly into their
    # existing native menus by Game_Interpreter#setup below.
    low=txt.downcase
    key=detect_key_for_event(map_id,event_id,txt)
    unless key
      log("talk map=#{map_id} event=#{event_id} name=#{event_name_for(event_id).inspect} detected=none")
      return
    end
    log("talk map=#{map_id} event=#{event_id} detected=#{key}:#{name(key)} eligible=#{eligible?(key,map_id,txt)}")
    capture_appearance(key,event_id)
    # Sho covenant-3 question is supplied by the mod.
    if key==9 && covenant_level(9)>=3 && !flag(:sho_question_done)
      r=choose("Do you love me or Alice more?",["You","Alice"])
      set_flag(:sho_question_done)
      if r==0
        say(9,"*emits a slight red hue* Glorp.."); set_flag(:sho_love_answer)
      else
        say(9,"..."); set_flag(:sho_rejected)
      end
      return
    end
    return if flag(:sho_rejected) && key==9

    # Jubjub's Butcher's Ring option is injected directly into her
    # existing NPC menu by the event-list choice patch below.

    # Meryphillia book handoff.
    if key==27 && !flag(:mery_hidden_body)
      book=item("Sorcery Book [Hidden Body]")
      if book && $game_party.has_item?(book)
        if choose("Give Meryphillia the book?",["Give Meryphillia the book","No"])==0
          $game_party.lose_item(book,1); set_flag(:mery_hidden_body)
          say(27,"I can use this to hide and still be by your side..")
          say(27,"Thank you..")
        end
      end
    end


    # Generic recruitment is appended to the NPC's native Show Choices list
    # by Game_Interpreter#setup_choices below.  Do not open a second choice
    # window here; detached post-event choices can become non-interactive in BS2.

    # Jubjub leaves only when the player actually speaks to Jabberwock or
    # Bandersnatch. Do not use keyword-detected character keys here because
    # unrelated dialogue (such as Cheshire Cat in Carroll River) can mention
    # these characters.
    if in_party?(22) && [[180,10],[133,5]].include?([map_id.to_i,event_id.to_i])
      dismiss(22)
    end
  end

  def self.oyster_kill_branch(list)
    arr=Marshal.load(Marshal.dump(list))
    branch_i=nil
    finish_i=nil
    arr.each_with_index do |cmd,i|
      next unless cmd.code.to_i==402
      label=(cmd.parameters[1] rescue "").to_s
      if label.gsub(/\\c\[\d+\]/,"").downcase.include?("kill")
        branch_i=i
        ((i+1)...arr.length).each do |j|
          c=arr[j]
          if c.code.to_i==404 && c.indent.to_i==cmd.indent.to_i
            finish_i=j
            break
          end
        end
        break
      end
    end
    return nil unless branch_i && finish_i
    base=arr[branch_i].indent.to_i+1
    out=[]
    ((branch_i+1)...finish_i).each do |j|
      c=arr[j]
      break if c.code.to_i==402 && c.indent.to_i==arr[branch_i].indent.to_i
      x=Marshal.load(Marshal.dump(c))
      x.indent=[x.indent.to_i-base,0].max
      out << x
    end
    out << RPG::EventCommand.new(0,0,[])
    out
  end

  def self.wolris_eat_oyster
    return if flag(:oyster_dead)
    return unless in_party?(14)

    # Wolris speaks before Oyster's event is allowed to run.
    say(14,"NOM")

    w=actor(14)
    w.change_level(w.level+10,false) if w

    set_flag(:oyster_dead)

    # Remove Cheeky Oyster from the current map immediately.
    if ($game_map.map_id rescue 0).to_i==140
      ev=$game_map.events[21] rescue nil
      ev.erase if ev
    end

    log("Wolris ate Cheeky Oyster; Wolris +10 levels")
  end

  def self.leaf_event?(map_id,event_id)
    map_id.to_i==60 && event_id.to_i==3
  end

  def self.can_give_leaf_hatta?
    return false if flag(:leaf_relocated,true)
    return false unless flag(:leaf_saved)
    item_owned?("Hatta")
  end

  def self.leaf_hatta_ready_after_save?
    return false if flag(:leaf_relocated,true)
    return false unless flag(:leaf_saved)
    item_owned?("Hatta")
  end

  def self.give_leaf_hatta
    return unless flag(:leaf_saved)
    return if flag(:leaf_relocated,true)
    hatta=item("Hatta")
    return unless hatta && $game_party.has_item?(hatta,true)

    $game_party.lose_item(hatta,1,true)
    set_flag(:leaf_relocated,true,true)

    # Leaf is Mary Ann / Mary Sue in the underlying game files.
    say_face("メアリー",0,"Fairy Leaf","The hell is this Grimm?")
    say_face("メアリー",0,"Fairy Leaf","AAH")

    # Hide her original Map060/Event3 copy immediately.
    if ($game_map.map_id rescue 0).to_i==60
      ev=$game_map.events[3] rescue nil
      ev.erase if ev
    end
  end

  def self.leaf_jabberwock_line
    say_face("メアリー",0,"Fairy Leaf","You Bitch you locked me up!")
  end

  def self.leaf_jabberwock_finish_line
    say_face("メアリー",0,"Fairy Leaf","SHUT UP")
  end

  def self.monitor_choice(choices,index,text)
    chosen=choices[index].to_s.downcase
    all=choices.join(" ").downcase
    if all.include?("dodo") && all.include?("shisha")
      set_flag(:dodo_shisha_event); set_flag(:shisha_chosen, chosen.include?("shisha"))
    end
    set_flag(:lingeriena_saved) if chosen.include?("save") && text.to_s.downcase.include?("linger")
    set_flag(:kuti_romance) if chosen.include?("make love") && text.to_s.downcase.include?("kuti")
    set_flag(:lorina_cards) if all.include?("card") && (chosen.include?("win")||chosen.include?("victory"))
    if chosen=="save her"
      mid=($game_map.map_id rescue 0).to_i
      eid=($game_map.interpreter.event_id rescue 0).to_i
      set_flag(:leaf_saved) if leaf_event?(mid,eid)
    elsif chosen.include?("save") && text.to_s.downcase.include?("leaf")
      set_flag(:leaf_saved)
    end
  end

  def self.monitor_gain(item,amount)
    return unless item && amount.to_i>0
    n=item.name.to_s.downcase
    set_flag(:train_ticket,true,true) if n.include?("train ticket")
    set_flag(:serpent_blood,true,true) if n.include?("blood") && n.include?("serpent")
    set_flag(:mery_hidden_body) if n.include?("hidden body")
  end

  def self.monitor_battle_victory
    names=$game_troop.members.map{|e| e.enemy.name.to_s.downcase rescue ""}.join(" ")
    set_flag(:jack_ripper_dead) if names.include?("jack the ripper")
    if names.include?("wolris") ||
       names.include?("predator of the deep sea") ||
       names.include?("walrus") ||
       names.include?("シヴーチ")
      set_flag(:wolris_dead)
      log("Wolris defeat detected; Cheeky Oyster recruitment unlocked")
    end
    set_flag(:deep_sea_knight_dead) if names.include?("deep sea knight")
    set_flag(:unis_dead) if names.include?("unis") || names.include?("white unicorn")
    if names.include?("grand guignol"); set_flag(:grand_guignol_end,true,true); dismiss(11) if in_party?(11); end
  end

  def self.level_cost(actor)
    # same XP delta the player would need for a level, paid in Souls (gold in this game build).
    [actor.next_level_exp-actor.current_level_exp,1].max rescue [actor.level*100,1].max
  end

  def self.node_level_prompt
    eligible=$game_party.members.select{|a| runtime_actor_id(a)!=PLAYER_ID}
    return show("No active companion can be leveled.") if eligible.empty?
    names=eligible.map{|a| "#{a.name} Lv#{a.level}"}+ ["Cancel"]
    i=choose("Choose a party member to level.",names); return if i.nil? || i>=eligible.length
    a=eligible[i]; cost=level_cost($game_actors[PLAYER_ID])
    if $game_party.gold < cost
      show("Not enough Souls. Need #{cost}.")
    else
      $game_party.lose_gold(cost); a.change_level(a.level+1,false); show("#{a.name} reached Lv#{a.level}.")
    end
  end

  def self.create_special_items
    # Items are created dynamically so no copyrighted database file is distributed.
    [["Hatta",2],["Haigha Voodoo Doll",2],["Eepy Rat",1]].each do |name,itype|
      existing=item(name)
      if existing
        if ["Hatta","Haigha Voodoo Doll","Eepy Rat"].include?(name)
          existing.description="" if existing.respond_to?(:description=)
          existing.icon_index=0 if existing.respond_to?(:icon_index=)
        end
        next
      end
      base=$data_items.compact.find{|i| i.respond_to?(:itype_id) && i.itype_id==itype} || $data_items.compact.first
      x=Marshal.load(Marshal.dump(base)); x.id=$data_items.length if x.respond_to?(:id=); x.name=name
      x.itype_id=itype if x.respond_to?(:itype_id=)
      x.consumable=false if x.respond_to?(:consumable=)
      if ["Hatta","Haigha Voodoo Doll","Eepy Rat"].include?(name)
        x.description="" if x.respond_to?(:description=)
        x.icon_index=0 if x.respond_to?(:icon_index=)
      end
      $data_items<<x
    end
  end

  def self.use_special_item(user,item)
    case item.name
    when "Hatta"
      return false if winterbell_or_chaos?
      if flag(:hatta_dead); user.hp=0; return true; end
      # Dungeon fallback if Hatta is imprisoned; otherwise place the player
      # exactly two tiles above the Endless Tea Party bonfire (31,35).
      if flag(:hatta_dungeon)
        $game_player.reserve_transfer(26,0,0,2)
      else
        $game_player.reserve_transfer(156,31,33,2)
      end
      say_hatta("WOAH") unless flag(:hatta_met); true
    when "Haigha Voodoo Doll"
      if flag(:haigha_dead)
        adjust_sen(-10)
      else
        say_haigha("Kyaaaa"); x=item_by_fuzzy("Something white and sticky"); $game_party.gain_item(x,1) if x; adjust_sen(10)
      end; true
    when "Eepy Rat"
      if $game_party.in_battle
        st=state("Sleep"); user.add_state(st.id) if st; user.instance_variable_get(:@state_turns)[st.id]=5 rescue nil
      else
        show("Dormouse curls up sleepily.")
      end; true
    else false end
  end

  def self.item_by_fuzzy(s)
    $data_items.compact.find{|x| x.name.to_s.downcase.include?(s.downcase)}
  end
  def self.adjust_sen(n)
    # Game's Sen display uses a variable; locate the configured variable when available.
    if defined?(Menu_Variable) && Menu_Variable.const_defined?(:Var_ID)
      id=Menu_Variable::Var_ID; $game_variables[id]=[$game_variables[id]+n,0].max
    else
      $game_party.gain_gold(n)
    end
  rescue
    $game_party.gain_gold(n)
  end
  def self.winterbell_or_chaos?
    id=$game_map.map_id; nm=($data_mapinfos[id].name.to_s.downcase rescue "")
    (331..410).include?(id) || nm.include?("winterbell") || nm.include?("chaos dungeon")
  end
end

# Database setup ----------------------------------------------------------------
module DataManager
  class << self
    alias bs2pm_load_database load_database
    def load_database
      bs2pm_load_database
      BS2PartyMod.setup_database
      BS2PartyMod.create_special_items
    end

    alias bs2pm_extract_save_contents extract_save_contents
    def extract_save_contents(contents)
      bs2pm_extract_save_contents(contents)
      BS2PartyMod.migrate_existing_actors
      BS2PartyMod.refresh_map_followers(true)
      BS2PartyMod.refresh_world_party_npcs
    end
  end
end

# Persistent/cycle state --------------------------------------------------------
class Game_System
  alias bs2pm_initialize initialize
  def initialize
    bs2pm_initialize
    @bs2pm_cycle={}
  end
end

# Relocated Leaf in Endless Tea Party ------------------------------------------
class Game_Map
  alias bs2pm_leaf_setup_events setup_events
  def setup_events
    bs2pm_leaf_setup_events

    # Only the Party-menu Leaf dismissal uses this additional home rule.
    bs2pm_remove_leaf_after_party_dismiss
    bs2pm_add_relocated_leaf_event
  end

  def bs2pm_remove_leaf_after_party_dismiss
    return unless @map_id.to_i==60
    return unless BS2PartyMod.flag(:leaf_party_menu_home_endless) ||
                  BS2PartyMod.flag(:leaf_killed_this_cycle)

    # Fairy Jail's Leaf/Mary presentation is Event3 with supporting Mary
    # sequence events 9 and 17. Remove them only after the Party-menu dismissal.
    [3,9,17].each do |eid|
      ev=@events[eid] rescue nil
      next unless ev
      ev.erase rescue nil
      @events.delete(eid) rescue nil
    end
    BS2PartyMod.log("Party-menu dismissed Leaf suppressed in Fairy Jail")
  rescue => e
    BS2PartyMod.log("Party-menu Leaf Fairy Jail suppression failed: #{e.class}: #{e.message}")
  end

  def bs2pm_add_relocated_leaf_event
    return unless @map_id.to_i==156

    # Existing story relocation still works as before. In addition, a Leaf
    # dismissed specifically through the Party menu returns here.
    return if BS2PartyMod.flag(:leaf_killed_this_cycle)
    return unless BS2PartyMod.flag(:leaf_relocated,true) ||
                  BS2PartyMod.flag(:leaf_party_menu_home_endless)
    return if BS2PartyMod.in_party?(28)
    return if @events.values.any?{|e| (e.event.name rescue "").to_s=="BS2PM_LEAF"}

    # Map156 bonfire Event24 is at (31,35). Leaf returns four tiles above it.
    ev=RPG::Event.new(31,31)
    ev.id=990 if ev.respond_to?(:id=)
    ev.name="BS2PM_LEAF" if ev.respond_to?(:name=)
    page=RPG::Event::Page.new
    page.graphic.character_name="$メアリー"
    page.graphic.character_index=0
    page.graphic.direction=2
    page.graphic.pattern=1
    page.trigger=0
    page.priority_type=1
    page.list=[
      RPG::EventCommand.new(101,0,["メアリー",0,0,2]),
      RPG::EventCommand.new(401,0,["\"Hehe, you do love me Grimm.\""]),
      # BS2 uses \c[2] for its highlighted hostile/Kill choices.
      RPG::EventCommand.new(102,0,[["Recruit","\\c[2]Kill\\c[0]","Leave"],2]),
      RPG::EventCommand.new(402,0,[0,"Recruit"]),
      RPG::EventCommand.new(355,1,["BS2PartyMod.recruit(28)"]),
      RPG::EventCommand.new(402,0,[1,"\\c[2]Kill\\c[0]"]),
      RPG::EventCommand.new(355,1,["BS2PartyMod.kill_endless_tea_party_leaf"]),
      RPG::EventCommand.new(402,0,[2,"Leave"]),
      RPG::EventCommand.new(404,0,[]),
      RPG::EventCommand.new(0,0,[])
    ]
    ev.pages=[page]
    @events[990]=Game_Event.new(@map_id,ev)
    BS2PartyMod.log("spawned Leaf at Endless Tea Party x=31 y=31")
  rescue => e
    BS2PartyMod.log("relocated Leaf spawn failed: #{e.class}: #{e.message}")
  end
end

# Recruited companion world-event suppression ---------------------------------
class Game_Event < Game_Character
  # Determine whether this event is a world copy of a currently active
  # recruit. We require an actual character graphic somewhere in the event so
  # narration/utility events that merely mention a character are not hidden.
  def bs2pm_party_duplicate_key
    return nil unless $game_party
    return nil if @map_id.to_i==100   # Room of Reminiscence helper map

    # The relocated Endless Tea Party Leaf is generated by this mod, so it
    # does not have a normal DIRECT_EVENT_KEYS entry. Treat it explicitly as
    # Leaf so recruiting her hides this world copy just like every other NPC.
    if (@event.name rescue "").to_s=="BS2PM_LEAF"
      return BS2PartyMod.in_party?(28) ? 28 : nil
    end

    has_graphic=false
    text_parts=[]
    begin
      @event.pages.each do |pg|
        g=pg.graphic
        has_graphic=true if g && g.character_name.to_s!=""
        pg.list.to_a.each do |cmd|
          cmd.parameters.to_a.each{|p| text_parts << p.to_s}
        end
      end
    rescue
    end
    return nil unless has_graphic

    key=BS2PartyMod.detect_key_for_event(@map_id,@id,text_parts.join(" ")) rescue nil
    return nil unless key
    return nil if key.to_i==11       # Node stays in Dream Library/world.
    return nil unless BS2PartyMod.in_party?(key)
    key
  end

  def bs2pm_party_hidden?
    !!@bs2pm_party_hidden
  end

  def bs2pm_refresh_party_presence
    key=bs2pm_party_duplicate_key

    if key
      unless @bs2pm_party_hidden
        @bs2pm_party_hidden=true
        BS2PartyMod.log("hide world NPC map=#{@map_id} event=#{@id} key=#{key}:#{BS2PartyMod.name(key)}")
      end

      # Make the duplicate fully absent: invisible, nonblocking, and unable to
      # start/autorun/parallel-process while the companion is active.
      @transparent=true
      @through=true
      @trigger=nil
      @list=nil
      @interpreter=nil
      @starting=false
    elsif @bs2pm_party_hidden
      # Restore the event from its current legitimate page and original map
      # coordinates when the companion is dismissed.
      @bs2pm_party_hidden=false
      moveto(@event.x,@event.y)
      new_page=find_proper_page
      setup_page(new_page)
      BS2PartyMod.log("restore world NPC map=#{@map_id} event=#{@id}")
    end
  rescue => e
    BS2PartyMod.log("world NPC presence error map=#{@map_id} event=#{@id}: #{e.class}: #{e.message}") rescue nil
  end

  alias bs2pm_worldnpc_refresh refresh
  def refresh
    bs2pm_worldnpc_refresh
    bs2pm_refresh_party_presence
  end

  alias bs2pm_worldnpc_start start
  def start
    return if bs2pm_party_hidden?
    bs2pm_worldnpc_start
  end

  alias bs2pm_worldnpc_update update
  def update
    if bs2pm_party_hidden?
      # Keep the event frozen at its original position while absent.
      return
    end
    bs2pm_worldnpc_update
  end
end

# Active companion map followers ------------------------------------------------
module BS2PartyMod
  def self.refresh_map_followers(sync=false)
    return unless defined?($game_player) && $game_player
    return unless $game_player.respond_to?(:followers)
    followers=$game_player.followers
    return unless followers
    followers.visible=true if followers.respond_to?(:visible=)
    followers.refresh if followers.respond_to?(:refresh)
    if sync && followers.respond_to?(:synchronize)
      followers.synchronize($game_player.x,$game_player.y,$game_player.direction)
    end
  rescue => e
    log("follower refresh failed: #{e.class}: #{e.message}")
  end
end

class Game_Followers
  alias bs2pm_followers_initialize initialize
  def initialize(leader)
    bs2pm_followers_initialize(leader)
    @visible=true
  end

  alias bs2pm_followers_refresh refresh
  def refresh
    @visible=true
    bs2pm_followers_refresh
  end
end

class Game_Player
  alias bs2pm_player_refresh_followers refresh
  def refresh
    bs2pm_player_refresh_followers
    if @followers
      @followers.visible=true if @followers.respond_to?(:visible=)
      @followers.refresh if @followers.respond_to?(:refresh)
    end
  end
end

# Preserve protagonist leadership and four active battle members.
class Game_Party
  alias bs2pm_add_actor add_actor
  def add_actor(actor_id)
    bs2pm_add_actor(actor_id)
    if @actors.include?(BS2PartyMod::PLAYER_ID)
      @actors.delete(BS2PartyMod::PLAYER_ID); @actors.unshift(BS2PartyMod::PLAYER_ID)
    end
    BS2PartyMod.refresh_map_followers
  end

  def max_battle_members; BS2PartyMod::MAX_BATTLE_MEMBERS; end

  alias bs2pm_gain_item gain_item
  def gain_item(item,amount,include_equip=false)
    bs2pm_gain_item(item,amount,include_equip)
    BS2PartyMod.monitor_gain(item,amount)
  end

  alias bs2pm_rate_preemptive rate_preemptive
  def rate_preemptive(troop_agi)
    r=bs2pm_rate_preemptive(troop_agi)
    r*=4 if BS2PartyMod.in_party?(5)
    [r,1.0].min
  end
end

# Enemy difficulty --------------------------------------------------------------
class Game_Enemy < Game_Battler
  alias bs2pm_param_base param_base
  def param_base(param_id)
    v=bs2pm_param_base(param_id)
    param_id==0 ? v*2 : v
  end
end

class Game_Battler < Game_BattlerBase
  # Skill books ultimately use VX Ace's Learn Skill item effect. Block that
  # effect on the TARGET actor, regardless of which item scene/script invoked it.
  alias bs2pm_item_effect_learn_skill item_effect_learn_skill
  def item_effect_learn_skill(user,item,effect)
    # Never interfere with the target-selection menu. Any actor may be selected.
    # The Learn Skill effect itself only resolves for Sammy (Actor 2),
    # Golden Chick, or Fairy Leaf.
    if actor?
      aid=BS2PartyMod.runtime_actor_id(self).to_i
      key=BS2PartyMod.key_for_actor(self)
      allowed=(aid==BS2PartyMod::PLAYER_ID || key==21 || key==28)
      return unless allowed
    end
    bs2pm_item_effect_learn_skill(user,item,effect)
  end

  alias bs2pm_make_damage_value make_damage_value
  def make_damage_value(user,item)
    bs2pm_make_damage_value(user,item)
    if user.is_a?(Game_Enemy) && @result.hp_damage.to_i>0
      @result.hp_damage *= 2
    end
  end

  alias bs2pm_item_apply item_apply
  def item_apply(user,item)
    bs2pm_item_apply(user,item)
    return unless item && user.is_a?(Game_Actor)
    key=BS2PartyMod.key_for_actor(user)
    case item.name
    when "Puff of Smoke"
      [2,4].each{|p| add_buff(p,10)}; [3,5].each{|p| add_debuff(p,10)}
    when "Brutal Angel's Lullaby"
      st=BS2PartyMod.state("Power of Darkness"); if st; add_state(st.id); @state_turns[st.id]=10 rescue nil; end
    when "Produce Vial"
      vial=BS2PartyMod.item_by_fuzzy("Blackwell Vial"); $game_party.gain_item(vial,1) if vial
    when "Glorpy Purr"
      if actor? && BS2PartyMod.runtime_actor_id(self)==BS2PartyMod::PLAYER_ID
        @bs2pm_glorpy_turns=2
      end
    when "Sing"
      @result.hp_damage=90000 if enemy?
    end
    # Target-side companion traits.
    if actor?
      tk=BS2PartyMod.key_for_actor(self)
      if tk==12 && user.is_a?(Game_Enemy) && item.respond_to?(:hit_type) && item.hit_type==0
        @result.hp_damage=0; @result.missed=true rescue nil
      end
    end
  end

  alias bs2pm_on_turn_end on_turn_end
  def on_turn_end
    bs2pm_on_turn_end
    @bs2pm_glorpy_turns=[@bs2pm_glorpy_turns.to_i-1,0].max if @bs2pm_glorpy_turns
    if enemy? && BS2PartyMod.in_party?(13)
      @bs2pm_leiden_stacks=[@bs2pm_leiden_stacks.to_i+1,20].min
    end
  end

  alias bs2pm_param param
  def param(param_id)
    v=bs2pm_param(param_id)
    mult=@bs2pm_dice_mult.to_i; v=(v*mult).to_i if mult>1
    if actor? && BS2PartyMod.runtime_actor_id(self)==BS2PartyMod::PLAYER_ID && @bs2pm_glorpy_turns.to_i>0 && param_id==2
      v*=2
    end
    if enemy? && param_id==3 && @bs2pm_leiden_stacks.to_i>0
      v=[(v*(1.0-0.05*@bs2pm_leiden_stacks)).to_i,0].max
    end
    v
  end

  alias bs2pm_xparam xparam
  def xparam(xparam_id)
    v=bs2pm_xparam(xparam_id)
    if actor? && BS2PartyMod.runtime_actor_id(self)==BS2PartyMod::PLAYER_ID && @bs2pm_glorpy_turns.to_i>0 && xparam_id==2; v+=1.0; end
    if enemy? && xparam_id==1 && @bs2pm_leiden_stacks.to_i>0; v-=0.05*@bs2pm_leiden_stacks; end
    v
  end
end

# Companion stats, skills, passives --------------------------------------------
class Game_Actor < Game_Battler
  alias bs2pm_oyster_character_name character_name
  def character_name
    return "$カキ" if BS2PartyMod.key_for_actor(self)==3
    bs2pm_oyster_character_name
  end

  alias bs2pm_oyster_character_index character_index
  def character_index
    return 0 if BS2PartyMod.key_for_actor(self)==3
    bs2pm_oyster_character_index
  end

  alias bs2pm_prickette_visible_skills skills
  def skills
    result=bs2pm_prickette_visible_skills
    if BS2PartyMod.key_for_actor(self)==15
      extra=[452,12,13,454].map{|sid| $data_skills[sid] rescue nil}.compact
      result=(result+extra).uniq{|sk| sk.id}
    end
    result
  end

  alias bs2pm_prickette_added_skill_types added_skill_types
  def added_skill_types
    types=bs2pm_prickette_added_skill_types
    if BS2PartyMod.key_for_actor(self)==15
      types=(types+[1]).uniq
    end
    types
  end

  alias bs2pm_character_name_pumpkin character_name
  def character_name
    return "!$かぼちゃオー" if BS2PartyMod.key_for_actor(self)==29
    bs2pm_character_name_pumpkin
  end

  alias bs2pm_character_index_pumpkin character_index
  def character_index
    return 0 if BS2PartyMod.key_for_actor(self)==29
    bs2pm_character_index_pumpkin
  end

  alias bs2pm_setup setup
  def setup(actor_id)
    bs2pm_setup(actor_id)
    @bs2pm_cooldowns={}
  end

  alias bs2pm_param_base param_base
  def param_base(param_id)
    key=BS2PartyMod.key_for_actor(self)
    return bs2pm_param_base(param_id) unless key

    # Mirror BLACK SOULS II's actual player character (Actor 2).
    # Temporarily evaluate Actor 2 at this companion's level so we inherit the
    # game's own class, Lv100+ limit-break growth, and BLACK SOULS-specific
    # parameter logic without adding our own max-level implementation.
    player=BS2PartyMod.grimm_actor
    if player
      old_level=player.level
      begin
        player.instance_variable_set(:@level,level.to_i)
        base=player.param_base(param_id).to_f
      ensure
        player.instance_variable_set(:@level,old_level)
      end
    else
      base=bs2pm_param_base(param_id).to_f
    end

    # Node retains her special Covenant-derived parameters.
    if key==11
      cov_level=BS2PartyMod.covenant_level(11) rescue 0
      cov=[0.25,0.25,0.5,1.0][cov_level] || 0.25
      base*=cov
      base*=0.2 if [2,3,5].include?(param_id)
      base*=2.0 if param_id==6
      return [base.ceil,1].max
    end

    # Character-specific proportions requested on top of Grimm's growth curve.
    case key
    when 4
      base*=0.5 if [2,5,6].include?(param_id)       # Shisha
    when 5
      base*=0.5 if [1,4,5].include?(param_id)       # Dodo
    when 6
      base*=0.5 if [2,3,5].include?(param_id)       # Margaret
    when 7
      base*=0.7 unless [0,1].include?(param_id)     # equals Victoria
    when 8
      base*=0.5                                      # Blackwell
    when 14
      base*=0.5 if param_id==6                       # Wolris speed
    when 15
      base*=0.4                                      # Prickett
    when 17
      base*=0.4 if [3,5,6,7].include?(param_id)     # Kuti
    when 18
      base*=0.7                                      # Lorina
    when 20
      base*=0.7 unless [0,1].include?(param_id)     # Victoria
    end
    [base.ceil,1].max
  end

  alias bs2pm_skill_conditions_met? skill_conditions_met?
  def skill_conditions_met?(skill)
    return false unless bs2pm_skill_conditions_met?(skill)
    cd = (@bs2pm_cooldowns && @bs2pm_cooldowns[skill.name]).to_i
    return false if cd > 0
    key=BS2PartyMod.key_for_actor(self)
    return false if skill.name=="Sing" && !(key==15 && @bs2pm_prickett_roll.to_i==6)
    true
  end

  alias bs2pm_pay_skill_cost pay_skill_cost
  def pay_skill_cost(skill)
    bs2pm_pay_skill_cost(skill)
    @bs2pm_cooldowns ||= {}; c=BS2PartyMod::COOLDOWNS[skill.name]; @bs2pm_cooldowns[skill.name]=c if c
    self.hp -= [mhp/10,1].max if skill.name=="Execution Verdict"
  end

  alias bs2pm_actor_on_turn_end on_turn_end
  def on_turn_end
    bs2pm_actor_on_turn_end
    if @bs2pm_cooldowns
      @bs2pm_cooldowns.keys.each{|k| @bs2pm_cooldowns[k]=[@bs2pm_cooldowns[k]-1,0].max}
    end
  end

  alias bs2pm_equip_change_ok? equip_change_ok?
  def equip_change_ok?(slot_id)
    key=BS2PartyMod.key_for_actor(self)
    if key && BS2PartyMod::LOCKED_EQUIPS[key]
      eq=equips[slot_id]; return false if eq && BS2PartyMod::LOCKED_EQUIPS[key].include?(eq.name)
    end
    bs2pm_equip_change_ok?(slot_id)
  end

  # Companion skill-book restriction: only Golden Chick and Fairy Leaf.
  def bs2pm_skill_book_allowed?; k=BS2PartyMod.key_for_actor(self); k.nil? || [21,28].include?(k); end

  alias bs2pm_on_damage on_damage
  def on_damage(value)
    bs2pm_on_damage(value)
    if BS2PartyMod.key_for_actor(self)==26 && value.to_i>0
      st=BS2PartyMod.state("Fear"); if st; add_state(st.id); @state_turns[st.id]=3 rescue nil; end
    end
  end

  alias bs2pm_sparam sparam
  def sparam(id)
    v=bs2pm_sparam(id); k=BS2PartyMod.key_for_actor(self)
    return v*3 if k==25 && id==0 && BS2PartyMod.in_party?(26)
    return v*4 if k==30 && id==0
    return v*0.5 if k==9 && id==6
    return v*2 if k==4 && id==1
    if k==20 && [7,8].include?(id); return v+0.10; end
    v
  end

  alias bs2pm_actor_xparam xparam
  def xparam(id)
    v=bs2pm_actor_xparam(id); k=BS2PartyMod.key_for_actor(self)

    # Wolris can only be recruited at Covenant Lv3, so his ally passive
    # always uses the maximum 30% HP regeneration value.
    # VX Ace xparam(7) = HRG (HP Regeneration Rate).
    v += 0.30 if k==14 && id==7

    v+=0.30 if k==22 && id==1; v+=1.00 if k==22 && id==5
    v+=0.30 if k==23 && [0,2].include?(id); v+=0.30 if k==24 && id==6
    v+=1.00 if k==19 && id==0
    v
  end


  alias bs2pm_state_resist? state_resist?
  def state_resist?(state_id)
    st=$data_states[state_id] rescue nil; n=st ? st.name.to_s.downcase : ""; k=BS2PartyMod.key_for_actor(self)
    return true if k==10 && (n.include?("poison") || n.include?("deadly poison"))
    return true if [12,13,18,19,23].include?(k) && n.include?("death")
    return true if k==19 && n.include?("stun")
    bs2pm_state_resist?(state_id)
  end

  alias bs2pm_element_rate element_rate
  def element_rate(element_id)
    v=bs2pm_element_rate(element_id); k=BS2PartyMod.key_for_actor(self)
    en=($data_system.elements[element_id].to_s.downcase rescue "")
    return 0.0 if k==23 && en.include?("ice")
    return v*0.5 if k==18
    v
  end

  alias bs2pm_atk_states_rate atk_states_rate
  def atk_states_rate(state_id)
    v=bs2pm_atk_states_rate(state_id); k=BS2PartyMod.key_for_actor(self)
    st=$data_states[state_id] rescue nil
    if k==10 && st && st.name.to_s.downcase=="poison"; return [v,0.20].max; end
    v
  end

  alias bs2pm_action_plus_set action_plus_set
  def action_plus_set
    a=bs2pm_action_plus_set.clone; k=BS2PartyMod.key_for_actor(self)
    if k==19
      a << 1.0
    elsif k==6
      # Duchess is only recruitable at Covenant Lv3: +100% bonus action chance.
      a << 1.0
    elsif k==17
      # Secret Princess Kuti: 50% chance for one additional action.
      a << 0.50
    end
    a
  end

  alias bs2pm_atk_times_add atk_times_add
  def atk_times_add
    v=bs2pm_atk_times_add
    # Secret Princess Kuti: +1 hit whenever she uses the basic Attack command.
    BS2PartyMod.key_for_actor(self)==17 ? v+1 : v
  end

  alias bs2pm_auto_battle? auto_battle?
  def auto_battle?
    # Bandersnatch permanently behaves as though Puppet's Ring is equipped.
    return true if BS2PartyMod.key_for_actor(self)==24

    # BLACK SOULS II's Puppet's Ring is the engine Auto Battle special flag
    # (feature code 62, data_id 0). AI On reproduces that behavior for every
    # allied actor except the real player character, Actor 2.
    aid=BS2PartyMod.runtime_actor_id(self).to_i
    return true if aid!=BS2PartyMod::PLAYER_ID && BS2PartyMod.global_ai?

    bs2pm_auto_battle?
  end

  alias bs2pm_make_auto_battle_actions make_auto_battle_actions
  def make_auto_battle_actions
    if BS2PartyMod.key_for_actor(self)==24
      # Do NOT call make_actions here. Since Bandersnatch's auto_battle?
      # returns true, make_actions would call this method again recursively.
      # Game_Battler#make_actions has already created @actions before
      # Game_Actor dispatches to make_auto_battle_actions.
      usable=skills.select{|sk| usable?(sk)}
      @actions.each do |act|
        if usable.empty?
          act.set_attack
        else
          act.set_skill(usable[rand(usable.size)].id)
        end
      end
    else
      bs2pm_make_auto_battle_actions
    end
  end
end

# Leaf AP-turn takeover ----------------------------------------------------------
module BS2PartyMod
  def self.leaf_choose_random_action(actor)
    return false unless actor
    action=actor.current_action
    return false unless action

    choices=[]
    begin
      atk=$data_skills[actor.attack_skill_id]
      choices << [:attack,nil] if atk && actor.usable?(atk)
    rescue
    end
    begin
      grd=$data_skills[actor.guard_skill_id]
      choices << [:guard,nil] if grd && actor.usable?(grd)
    rescue
    end
    # BLACK SOULS II's "Skill Storage" is implemented by Game_Actor#skill_seal.
    # Window_SkillList explicitly hides every skill whose ID appears there.
    # Mirror that exact per-skill rule rather than inferring from skill type.
    stored=(actor.skill_seal rescue []).to_a.map{|x| x.to_i}
    actor.skills.to_a.each do |sk|
      next unless sk
      next if stored.include?(sk.id.to_i)

      # The battle UI also hides Menu Only / Never skills.
      next if sk.occasion.to_i==2 || sk.occasion.to_i==3

      next unless actor.usable?(sk)
      choices << [:skill,sk.id]
    end

    return false if choices.empty?

    kind,sid=choices[Kernel.rand(choices.length)]
    case kind
    when :attack then action.set_attack
    when :guard  then action.set_guard
    when :skill  then action.set_skill(sid)
    end

    # Let VX Ace pick a valid target for the newly chosen action.
    action.target_index=-1 if action.respond_to?(:target_index=)
    action.instance_variable_set(:@target_index,-1)

    log("Leaf takeover chose #{kind}#{sid ? " skill=#{sid}" : ""}")
    true
  end

  def self.leaf_takeover_speak
    say_face("メアリー",0,"Fairy Leaf","Let me pick!")
  end
end

class Scene_Battle < Scene_Base
  alias bs2pm_leaf_process_before_action process_before_action
  def process_before_action
    bs2pm_leaf_process_before_action

    battler=BattleManager.make_action_orders[0] rescue nil
    return unless battler.is_a?(Game_Actor)
    return unless BS2PartyMod.key_for_actor(battler)==28

    # Global AI already controls Leaf exactly like Puppet's Ring, so her
    # separate 20% "Let me pick!" takeover is disabled until AI Off.
    if BS2PartyMod.global_ai?
      battler.instance_variable_set(:@bs2pm_leaf_takeover_turn,false)
      return
    end

    return unless battler.ap.to_i >= ATB::MAX_AP.to_i

    # process_before_action is the point where the ATB system has selected the
    # battler whose AP has reached MAX_AP. Roll exactly once for this granted turn.
    battler.instance_variable_set(:@bs2pm_leaf_takeover_turn, Kernel.rand(100) < 20)
  end

  alias bs2pm_leaf_start_actor_command_selection start_actor_command_selection
  def start_actor_command_selection
    actor=BattleManager.actor rescue nil

    if actor && BS2PartyMod.key_for_actor(actor)==28 &&
       actor.instance_variable_get(:@bs2pm_leaf_takeover_turn)

      # Consume the per-turn flag before doing anything that could re-enter
      # command-selection code.
      actor.instance_variable_set(:@bs2pm_leaf_takeover_turn,false)

      # Leaf speaks with her normal portrait/name the instant her AP turn is
      # granted, then chooses a random currently usable move.
      BS2PartyMod.leaf_takeover_speak
      if BS2PartyMod.leaf_choose_random_action(actor)
        turn_start
        return
      end
      # If no usable action exists, fall through to normal player control.
    end

    bs2pm_leaf_start_actor_command_selection
  end
end

# Golden Chick lethal intercept ------------------------------------------------
class Game_Battler < Game_BattlerBase
  alias bs2pm_execute_damage execute_damage
  def execute_damage(user)
    if actor? && BS2PartyMod.key_for_actor(self)==21 && @result.hp_damage.to_i>=hp && BS2PartyMod.in_party?(22)
      j=BS2PartyMod.actor(22)
      if j && !j.dead?
        dmg=@result.hp_damage; @result.hp_damage=0; j.hp -= dmg
        SceneManager.scene.instance_variable_get(:@log_window).add_text("Jubjub protected Golden Chick!") rescue nil
      end
    end
    bs2pm_execute_damage(user)
  end
end

# Battle startup: Prickett die and victory progression -------------------------
module BattleManager
  class << self
    alias bs2pm_battle_start battle_start
    def battle_start
      bs2pm_battle_start
      if BS2PartyMod.in_party?(15)
        roll=1+rand(6); BS2PartyMod.actor(15).instance_variable_set(:@bs2pm_prickett_roll,roll)
        if roll>1
          ($game_party.battle_members+$game_troop.members).each{|b| b.instance_variable_set(:@bs2pm_dice_mult,roll)}
        end
        $game_message.add("Dice rolled #{roll}.") rescue nil
      end
    end
    alias bs2pm_process_victory process_victory
    def process_victory
      BS2PartyMod.monitor_battle_victory
      bs2pm_process_victory
    end
  end
end

# Choice/event monitoring and recruitment --------------------------------------

# Recruitment is only added to NPCs that already have a native choice menu.
# No standalone recruit window is created.

class Game_Interpreter
  # Patch an NPC's existing Show Choices event command into a real native
  # branch. This leaves BLACK SOULS II's ChoiceEX callbacks untouched.
  alias bs2pm_setup_integrated_recruit setup
  def setup(list,event_id=0)
    patched=list
    begin
      map_id=($game_map.map_id rescue 0).to_i

      # Cheeky Oyster + Secret Princess Kuti special interaction.
      # Kuti's real Deep Sea NPC is Map197/Event4.
      if map_id==197 && event_id.to_i==4 && BS2PartyMod.in_party?(3)
        kuti_oyster_peace=BS2PartyMod.flag(:kuti_oyster_reconciled)
        kuti_oyster_hostile=BS2PartyMod.flag(:kuti_oyster_hostile)

        if kuti_oyster_hostile
          # Stay-silent route is permanent for the rest of this cycle:
          # talking to Kuti skips all questions/dialogue and immediately starts
          # her native battle again.
          tail=BS2PartyMod.kuti_native_battle_tail(list)
          if tail
            list=tail+[RPG::EventCommand.new(0,0,[])]
          else
            list=[
              RPG::EventCommand.new(301,0,[0,332,false,false]),
              RPG::EventCommand.new(0,0,[])
            ]
          end
          patched=list

        elsif !kuti_oyster_peace
          # First unresolved interaction: exactly two choices.
          tail=BS2PartyMod.kuti_native_battle_tail(list)

          custom=[
            RPG::EventCommand.new(102,0,[
              ["Tell Zoa to apologize","Stay silent"],2
            ]),

            # -------------------------------------------------------------
            # Tell Zoa to apologize
            # -------------------------------------------------------------
            RPG::EventCommand.new(402,0,[0,"Tell Zoa to apologize"]),

            RPG::EventCommand.new(108,1,["NW名前指定:Cheeky Oyster"]),
            RPG::EventCommand.new(101,1,["カキ",0,0,2]),
            RPG::EventCommand.new(401,1,["Kuti I am sorry for leaving you alone..."]),

            RPG::EventCommand.new(108,1,["NW名前指定:Cheeky Oyster"]),
            RPG::EventCommand.new(101,1,["カキ",0,0,2]),
            RPG::EventCommand.new(401,1,["You wont be alone anymore kay,"]),
            RPG::EventCommand.new(401,1,["you could maybe come with us."]),

            RPG::EventCommand.new(108,1,["NW名前指定:Secret Princess Kuti"]),
            RPG::EventCommand.new(101,1,["クティ",0,0,2]),
            RPG::EventCommand.new(401,1,["..."]),

            RPG::EventCommand.new(108,1,["NW名前指定:Secret Princess Kuti"]),
            RPG::EventCommand.new(101,1,["クティ",0,0,2]),
            RPG::EventCommand.new(401,1,["Kuti is still angry.."]),
            RPG::EventCommand.new(401,1,["But I forgive you Zoa"]),
            # Resolve peacefully for the remainder of this cycle. The next
            # interaction uses Kuti's untouched normal event list.
            RPG::EventCommand.new(355,1,[
              "BS2PartyMod.set_flag(:kuti_oyster_reconciled)"
            ]),

            # -------------------------------------------------------------
            # Stay silent
            # -------------------------------------------------------------
            RPG::EventCommand.new(402,0,[1,"Stay silent"]),

            RPG::EventCommand.new(108,1,["NW名前指定:Cheeky Oyster"]),
            RPG::EventCommand.new(101,1,["カキ",0,0,2]),
            RPG::EventCommand.new(401,1,["Heeyyyy looseerr,"]),
            RPG::EventCommand.new(401,1,["bet it sucks bein down hereee."]),

            RPG::EventCommand.new(231,1,[1,"80",0,0,0,0,100,100,255,0]),

            RPG::EventCommand.new(108,1,["NW名前指定:Secret Princess Kuti"]),
            RPG::EventCommand.new(101,1,["クティ",0,0,2]),
            RPG::EventCommand.new(401,1,["YOU ARE HORRIBLE SISTER!"]),

            RPG::EventCommand.new(235,1,[1]),

            # Set hostility BEFORE the battle. If the player loses/escapes and
            # returns, the introductory questions will not appear again.
            RPG::EventCommand.new(355,1,[
              "BS2PartyMod.set_flag(:kuti_oyster_hostile)"
            ])
          ]

          if tail
            tail.each do |c|
              c.indent=c.indent.to_i+1
              custom << c
            end
          else
            custom << RPG::EventCommand.new(301,1,[0,332,false,false])
          end

          custom << RPG::EventCommand.new(404,0,[])
          custom << RPG::EventCommand.new(0,0,[])
          list=custom
          patched=list
        end
        # If reconciled, do nothing here: Kuti's original event list remains
        # intact and normal interaction proceeds.
      end

      # Wolris + Cheeky Oyster special interaction.
      # Map140/Event21 is Cheeky Oyster. If Wolris is active, replace the
      # ENTIRE event command list before Oyster can display any dialogue.
      if map_id==140 && event_id.to_i==21
        if BS2PartyMod.in_party?(17) && !BS2PartyMod.flag(:oyster_dead)
          # Secret Princess Kuti immediately starts Oyster's own native Kill
          # route. Reusing the event's real branch preserves troop 361 and all
          # normal victory/death switches, rewards, cleanup, and aftermath.
          kuti_branch=BS2PartyMod.oyster_kill_branch(list)
          if kuti_branch
            # Kuti speaks before Oyster gets any opportunity to display her
            # normal text, then the already-working native Kill route begins.
            list=[
              RPG::EventCommand.new(355,0,[
                'BS2PartyMod.say_kuti("You betrayed me Zoa, you left Kuti to Rot!!")'
              ])
            ] + kuti_branch
            patched=list
          end
        elsif BS2PartyMod.in_party?(14) && !BS2PartyMod.flag(:oyster_dead)
          list=[
            RPG::EventCommand.new(355,0,["BS2PartyMod.wolris_eat_oyster"]),
            RPG::EventCommand.new(0,0,[])
          ]
          patched=list
        elsif BS2PartyMod.flag(:oyster_dead)
          # Oyster stays dead for the remainder of the cycle even if Wolris
          # is later dismissed or the player leaves and returns to the map.
          list=[
            RPG::EventCommand.new(355,0,["ev=$game_map.events[21] rescue nil; ev.erase if ev"]),
            RPG::EventCommand.new(0,0,[])
          ]
          patched=list
        end
      end

      # Special Haigha handling is hard-locked to the Endless Tea Party copy
      # at Map156/Event26. No Haigha event elsewhere is modified.
      if BS2PartyMod.endless_tea_party_haigha?(map_id,event_id)
        list=BS2PartyMod.patch_endless_haigha_choices(list)
        patched=list
      end

      txt=BS2PartyMod.event_text(map_id,event_id) rescue ""
      key=BS2PartyMod.detect_key_for_event(map_id,event_id,txt) rescue nil

      # Fairy Leaf is stored as Mary/Mary Sue at Map060/Event3.
      if BS2PartyMod.leaf_event?(map_id,event_id)
        arr=Marshal.load(Marshal.dump(list))

        # Record Leaf as saved only when the player actually chooses Save her.
        # No Hatta option is added anywhere on this initial rescue page.
        save_branch=nil
        arr.each_with_index do |cmd,i|
          if cmd.code.to_i==402 && (cmd.parameters[1] rescue "").to_s=="Save her"
            save_branch=i
            break
          end
        end
        if save_branch
          arr.insert(save_branch+1,
            RPG::EventCommand.new(355,1,["BS2PartyMod.set_flag(:leaf_saved)"]))
        end

        # The Hatta handoff belongs ONLY to Leaf's later normal interaction
        # menu after she has been saved. Find the menu containing Make love,
        # Kill, and Rape and append the option there. Do not touch the rescue
        # menu or the immediate post-save Leave menu.
        if BS2PartyMod.leaf_hatta_ready_after_save?
          choices_idx=nil
          arr.each_with_index do |cmd,i|
            next unless cmd.code.to_i==102
            opts=(cmd.parameters[0] rescue []).to_a
            low=opts.map{|x| x.to_s.downcase}

            # Later Leaf/Mary interaction menu:
            # Make love / Punch / Kill / Rape in the raw event.
            # Other installed scripts may merge Kiss/Leave around it, so match
            # the stable identifying choices rather than exact option count.
            if low.any?{|x| x.include?("make love")} &&
               low.any?{|x| x.include?("kill")} &&
               low.any?{|x| x.include?("rape")}
              choices_idx=i
              break
            end
          end

          if choices_idx
            cmd=arr[choices_idx]
            opts=cmd.parameters[0].clone
            unless opts.include?("Give Leaf the Hatta")
              idx=opts.length
              opts << "Give Leaf the Hatta"
              cmd.parameters[0]=opts

              finish=nil
              ((choices_idx+1)...arr.length).each do |j|
                c=arr[j]
                if c.code.to_i==404 && c.indent.to_i==cmd.indent.to_i
                  finish=j
                  break
                end
              end

              if finish
                arr.insert(finish,
                  RPG::EventCommand.new(402,cmd.indent.to_i,[idx,"Give Leaf the Hatta"]),
                  RPG::EventCommand.new(355,cmd.indent.to_i+1,["BS2PartyMod.give_leaf_hatta"]))
              end
            end
          end
        end

        list=arr
        patched=arr
      end

      # Leaf + Jabberwock special interaction.
      # Only patch Jabberwock's REAL event list when its native Kill branch is
      # actually present. Never fall back to starting a battle from nested
      # common-event/interpreter setup, which caused the old second fight.
      if map_id==180 && event_id.to_i==10 && BS2PartyMod.in_party?(28)
        arr=Marshal.load(Marshal.dump(list))

        kill_branch=nil
        kill_finish=nil
        arr.each_with_index do |cmd,i|
          if cmd.code.to_i==402 &&
             (cmd.parameters[1] rescue "").to_s.downcase.include?("kill")
            kill_branch=i
            ((i+1)...arr.length).each do |j|
              c=arr[j]
              if c.code.to_i==404 && c.indent.to_i==cmd.indent.to_i
                kill_finish=j
                break
              end
            end
            break
          end
        end

        if kill_branch && kill_finish
          raw=[]
          ((kill_branch+1)...kill_finish).each do |j|
            c=arr[j]
            break if c.code.to_i==402 && c.indent.to_i==arr[kill_branch].indent.to_i
            raw << Marshal.load(Marshal.dump(c))
          end

          # Normalize branch indentation to top-level.
          base_indent=arr[kill_branch].indent.to_i+1
          raw.each{|c| c.indent=[c.indent.to_i-base_indent,0].max}

          # In Jabberwock's victory section, the normal death dialogue occurs
          # between Common Event 55 and the fade/removal move route. Remove that
          # dialogue and insert Leaf's "SHUT UP" immediately before the fade.
          victory=raw.index{|c| c.code.to_i==601}
          if victory
            common55=nil
            fade_route=nil

            ((victory+1)...raw.length).each do |i|
              c=raw[i]
              if c.code.to_i==117 && (c.parameters[0] rescue 0).to_i==55
                common55=i
                break
              end
            end

            if common55
              ((common55+1)...raw.length).each do |i|
                c=raw[i]
                if c.code.to_i==205
                  route=(c.parameters[1] rescue nil)
                  cmds=(route.list rescue [])
                  # Jabberwock death fade route changes opacity repeatedly.
                  if cmds.any?{|mc| mc.code.to_i==42}
                    fade_route=i
                    break
                  end
                end
              end
            end

            if common55 && fade_route && fade_route>common55
              # Preserve Common Event 55, then Leaf cuts off all Jabberwock
              # death text before the base-game fade/death cleanup.
              raw[(common55+1)...fade_route]=[
                RPG::EventCommand.new(355,raw[common55].indent.to_i,
                  ["BS2PartyMod.leaf_jabberwock_finish_line"])
              ]
            end
          end

          prefix=[
            RPG::EventCommand.new(355,0,["BS2PartyMod.leaf_jabberwock_line"])
          ]
          arr=prefix+raw+[RPG::EventCommand.new(0,0,[])]
          list=arr
          patched=arr
        end
      end

            # Node + Leaf special interaction. Trigger once per cycle at the START
      # of talking to Node in the Dream Library while Leaf is active.
      if map_id==101 && event_id.to_i==9 &&
         BS2PartyMod.in_party?(28) && !BS2PartyMod.flag(:node_leaf_talk)
        arr=Marshal.load(Marshal.dump(list))
        prefix=[
          RPG::EventCommand.new(108,0,["NW名前指定:White Rabbit Node"]),
          RPG::EventCommand.new(101,0,["ノーデ",0,0,2]),
          RPG::EventCommand.new(401,0,["How did the pest get out Lord Grimm?"]),
          RPG::EventCommand.new(108,0,["NW名前指定:Fairy Leaf"]),
          RPG::EventCommand.new(101,0,["メアリー",0,0,2]),
          RPG::EventCommand.new(401,0,["You are just jealous Grimm loves me more!"]),
          RPG::EventCommand.new(355,0,["BS2PartyMod.set_flag(:node_leaf_talk)"])
        ]
        arr=prefix+arr
        list=arr
        patched=arr
      end

      # Golden Chick + Jubjub exchange belongs at the START of interaction.
      # Use real Show Text commands rather than $game_message helper calls so
      # BLACK SOULS II switches portraits exactly like native dialogue.
      if map_id==146 && event_id.to_i==9 && BS2PartyMod.in_party?(22) &&
         !BS2PartyMod.flag(:jubjub_chick_talk)
        arr=Marshal.load(Marshal.dump(list))
        prefix=[
          RPG::EventCommand.new(108,0,["NW名前指定:Mad Bird Jubjub"]),
          RPG::EventCommand.new(101,0,["ジャブ",0,0,2]),
          RPG::EventCommand.new(401,0,["Hey sweetie how are you doing?"]),
          RPG::EventCommand.new(108,0,["NW名前指定:Golden Chick"]),
          RPG::EventCommand.new(101,0,["ハン２",0,0,2]),
          RPG::EventCommand.new(401,0,["I'm doing good Big sis!!"]),
          RPG::EventCommand.new(355,0,["BS2PartyMod.set_flag(:jubjub_chick_talk)"])
        ]
        arr=prefix+arr
        patched=arr
        list=arr
      end

      additions=[]

      # Special non-party unlocks. These are native branches in the NPC's
      # existing menu, never separate message-choice windows.
      if map_id==156 && event_id.to_i==25 && BS2PartyMod.can_unlock_hatta?
        additions << ["Ask Hatta to join","BS2PartyMod.unlock_hatta_item"]

      elsif map_id==156 && event_id.to_i==27 && BS2PartyMod.can_carry_dormouse?
        additions << ["Carry Dormouse","BS2PartyMod.carry_dormouse"]
      end

      if key && key.to_i.between?(1,30)
        add_recruit=(!BS2PartyMod.in_party?(key) &&
          BS2PartyMod.eligible?(key,map_id,txt))

        # Never append Recruit to the unresolved two-choice Kuti/Oyster
        # scene or the hostile immediate-battle route. After reconciliation,
        # Kuti returns to her ordinary menu and normal recruitment rules apply.
        if map_id==197 && event_id.to_i==4 && BS2PartyMod.in_party?(3) &&
           !BS2PartyMod.flag(:kuti_oyster_reconciled)
          add_recruit=false
        end

        # Knight Pumpkin-O may only be recruited from his home.
        if key==29 && [map_id.to_i,event_id.to_i] != [116,13]
          add_recruit=false
        end

        if key==28 && (BS2PartyMod.in_party?(27)||BS2PartyMod.in_party?(16))
          add_recruit=false
        elsif key==27 && BS2PartyMod.in_party?(28)
          add_recruit=false
        elsif key==16 && BS2PartyMod.in_party?(28)
          add_recruit=false
        elsif key==22 && (BS2PartyMod.in_party?(23)||BS2PartyMod.in_party?(24))
          add_recruit=false
        end

        add_ring=(key.to_i==22 && map_id==43 && [10,11].include?(event_id.to_i) &&
          BS2PartyMod.can_give_jubjub_ring?)

        additions << ["Give her the ring","BS2PartyMod.give_jubjub_ring"] if add_ring
        additions << ["Recruit","BS2PartyMod.recruit(#{key.to_i})"] if add_recruit
      end

      unless additions.empty?
        arr=Marshal.load(Marshal.dump(list))

        # Prefer the NPC's main menu: Covenant/Leave menus rank highest.
        candidates=[]
        arr.each_with_index do |c,i|
          next unless c && c.code.to_i==102
          choices=(c.parameters[0] rescue []).to_a
          score=0
          score+=10 if choices.any?{|x| x.to_s.downcase.include?("covenant")}
          score+=8  if choices.any?{|x| x.to_s.downcase.include?("leave")}
          score+=4  if choices.any?{|x| x.to_s.downcase.include?("kill")}
          candidates << [score,i]
        end

        unless candidates.empty?
          # Hatta, Haigha, and Dormouse have several nested choice blocks.
          # Their mod option belongs on the first/main menu, never a later
          # nested Leave/Kiss/etc. menu.
          if map_id==43 && event_id.to_i==10 && additions.any?{|x| x[0]=="Give her the ring"}
            postfight=candidates.map{|x| x[1]}.find do |idx|
              opts=(arr[idx].parameters[0] rescue []).to_a
              opts.any?{|o| o.to_s.downcase.include?("enter a covenant")}
            end
            target_index=postfight || candidates.max_by{|x| [x[0],x[1]]}[1]
          elsif map_id==156 && [25,26,27].include?(event_id.to_i)
            top=candidates.map{|x| x[1]}.select{|idx| arr[idx].indent.to_i==0}
            target_index=(top.empty? ? candidates.map{|x| x[1]}.min : top.min)
          else
            target_index=candidates.max_by{|x| [x[0],x[1]]}[1]
          end
          choice_cmd=arr[target_index]
          indent=choice_cmd.indent.to_i
          choices=choice_cmd.parameters[0].clone

          # Locate this Show Choices block's matching 404.
          finish=nil
          depth=0
          ((target_index+1)...arr.length).each do |j|
            c=arr[j]
            next unless c
            if c.code.to_i==102 && c.indent.to_i==indent
              depth+=1
            elsif c.code.to_i==404 && c.indent.to_i==indent
              if depth==0
                finish=j
                break
              else
                depth-=1
              end
            end
          end

          if finish
            inserted=[]
            additions.each do |label,script|
              idx=choices.length
              choices << label
              inserted << RPG::EventCommand.new(402,indent,[idx,label])
              inserted << RPG::EventCommand.new(355,indent+1,[script])
            end
            choice_cmd.parameters[0]=choices
            arr.insert(finish,*inserted)
            patched=arr
            BS2PartyMod.log("integrated menu patch map=#{map_id} event=#{event_id} additions=#{additions.map{|x|x[0]}.inspect}")
          end
        end
      end
    rescue => e
      BS2PartyMod.log("integrated recruitment patch error: #{e.class}: #{e.message}")
      patched=list
    end
    bs2pm_setup_integrated_recruit(patched,event_id)
  end

  # Node's native Level up branch calls Common Event 35.  Instead of
  # creating a second custom choice window (which this game does not resume
  # correctly), prepend a normal RPG Maker Show Choices block to the child
  # common event. The original CE35 then runs completely unchanged.
  alias bs2pm_command_117_party_level command_117
  def command_117
    # CE34 contains BLACK SOULS II's heroine-progression update. Its first
    # 201 commands are the Jubjub madness cascade: it enables the individual
    # madness switches and removes several Covenant spirits once progression
    # reaches 10. When Jubjub has received the Butcher's Ring, skip only that
    # first block and continue the unrelated heroine progression at command 201.
    if @params && @params[0].to_i==34 && BS2PartyMod.jubjub_madness_blocked?
      common_event=$data_common_events[34]
      if common_event
        # Commands 0-200 are the Jubjub mass-madness cascade. Continue only
        # with the unrelated heroine-progression section from command 201.
        BS2PartyMod.suppress_jubjub_madness
        safe_list=(common_event.list[201..-1] || [])
        child=Game_Interpreter.new(@depth+1)
        child.setup(safe_list, same_map? ? @event_id : 0)
        child.run
        BS2PartyMod.suppress_jubjub_madness
        return
      end
    end

    if @params && @params[0].to_i==35 && @map_id.to_i==101
      common_event=$data_common_events[35]
      if common_event
        actors=BS2PartyMod.node_level_candidates
        labels=actors.map{|a| a.name.to_s}
        labels << "Cancel"
        prefix=[]
        prefix << RPG::EventCommand.new(102,0,[labels,labels.length-1])
        actors.each_with_index do |a,i|
          prefix << RPG::EventCommand.new(402,0,[i,labels[i]])
          aid=BS2PartyMod.runtime_actor_id(a).to_i
          prefix << RPG::EventCommand.new(355,1,["$game_variables[14]=#{aid}"])
        end
        prefix << RPG::EventCommand.new(402,0,[labels.length-1,"Cancel"])
        prefix << RPG::EventCommand.new(115,1,[])
        prefix << RPG::EventCommand.new(404,0,[])
        # ChoiceEX chains consecutive Show Choices across command_404 and assumes
        # a numeric branch value. Separate our actor picker from vanilla CE35.
        prefix << RPG::EventCommand.new(108,0,["BS2PartyMod level target selected"])
        node=BS2PartyMod.actor(11) rescue nil
        node_level_before=node ? node.level.to_i : nil

        child=Game_Interpreter.new(@depth+1)
        child.setup(prefix + common_event.list, same_map? ? @event_id : 0)
        child.run

        # If Node was the selected target and genuinely gained a level, she
        # thanks the real playable character (Actor 2) by their chosen name.
        if node && node_level_before && node.level.to_i > node_level_before
          player=BS2PartyMod.grimm_actor
          pname=player ? player.name.to_s : "Grimm"
          BS2PartyMod.say(11,"Thank you Lord #{pname}")
        end
        return
      end
    end
    bs2pm_command_117_party_level
  end

  # Keep the recruitment prompt inside the interpreter fiber.  The stock
  # Game_Interpreter#run clears @fiber at the very end; calling after_talk
  # after aliasing run leaves a visible choice window that can never resume.
  def run
    wait_for_message
    while @list[@index] do
      execute_command
      @index += 1
    end
    BS2PartyMod.after_talk(@map_id,@event_id) if @event_id.to_i > 0
    BS2PartyMod.suppress_jubjub_madness rescue nil
    Fiber.yield
    @fiber = nil
  end
end


# Room of Reminiscence recruit helper ------------------------------------------
module BS2PartyMod
  def self.build_reminiscence_helper_event
    ev=RPG::Event.new(REMINISCENCE_HELPER_X,REMINISCENCE_HELPER_Y)
    ev.id=REMINISCENCE_HELPER_EVENT_ID
    ev.name="BS2 Party Mod Node Helper"
    page=RPG::Event::Page.new
    page.trigger=0
    page.priority_type=1
    page.through=false

    # Use Node's existing sprite data. Prefer the original Node actor (17);
    # fall back to the mod clone if needed.
    src=$data_actors[17] || $data_actors[actor_id(11)]
    if src
      page.graphic.character_name=src.character_name.to_s
      page.graphic.character_index=src.character_index.to_i
      page.graphic.direction=2
      page.graphic.pattern=1
    end

    page.list=[
      RPG::EventCommand.new(101,0,["",0,0,2]),
      RPG::EventCommand.new(401,0,["Party Mod recruitment tools."]),
      RPG::EventCommand.new(102,0,[["Unlock all recruits","Undo Progression","AI On","AI Off","Neither"],4]),
      RPG::EventCommand.new(402,0,[0,"Unlock all recruits"]),
      RPG::EventCommand.new(355,1,["BS2PartyMod.unlock_all_recruits"]),
      RPG::EventCommand.new(402,0,[1,"Undo Progression"]),
      RPG::EventCommand.new(355,1,["BS2PartyMod.undo_recruit_progression"]),
      RPG::EventCommand.new(402,0,[2,"AI On"]),
      RPG::EventCommand.new(355,1,["BS2PartyMod.set_global_ai(true)"]),
      RPG::EventCommand.new(402,0,[3,"AI Off"]),
      RPG::EventCommand.new(355,1,["BS2PartyMod.set_global_ai(false)"]),
      RPG::EventCommand.new(402,0,[4,"Neither"]),
      RPG::EventCommand.new(404,0,[]),
      RPG::EventCommand.new(0,0,[])
    ]
    ev.pages=[page]
    ev
  end
end

class Game_Map
  alias bs2pm_setup_reminiscence_helper setup
  def setup(map_id)
    bs2pm_setup_reminiscence_helper(map_id)
    BS2PartyMod.sync_jubjub_ring_state rescue nil
    if map_id.to_i==BS2PartyMod::REMINISCENCE_MAP_ID
      begin
        ev=BS2PartyMod.build_reminiscence_helper_event
        @events[BS2PartyMod::REMINISCENCE_HELPER_EVENT_ID]=Game_Event.new(map_id,ev)
        BS2PartyMod.log("spawned Reminiscence Node helper at #{BS2PartyMod::REMINISCENCE_HELPER_X},#{BS2PartyMod::REMINISCENCE_HELPER_Y}")
      rescue => e
        BS2PartyMod.log("failed spawning Reminiscence helper: #{e.class}: #{e.message}")
      end
    end
  end
end

# Mabel regional departure rules ------------------------------------------------
class Game_Player < Game_Character
  alias bs2pm_reserve_transfer reserve_transfer
  def reserve_transfer(map_id,x,y,d=2)
    if BS2PartyMod.in_party?(19)
      nm=($data_mapinfos[map_id].name.to_s.downcase rescue "")
      if nm.include?("winterbell") || (331..410).include?(map_id.to_i)
        $game_party.members.clone.each do |a|
          k=BS2PartyMod.key_for_actor(a); next unless k && ![11,19].include?(k)
          $game_party.remove_actor(BS2PartyMod.runtime_actor_id(a))
        end
      elsif nm.include?("chaos dungeon") || nm.include?("time space") || nm.include?("time-space") || nm.include?("ashes reignited")
        $game_party.remove_actor(BS2PartyMod.actor_id(19))
      end
    end
    bs2pm_reserve_transfer(map_id,x,y,d)
  end
end

# Menu Party command ------------------------------------------------------------
class Window_MenuCommand < Window_Command
  alias bs2pm_add_original_commands add_original_commands
  def add_original_commands
    bs2pm_add_original_commands
    add_command("Party",:bs2pm_party,true)
  end
end
class Scene_Menu < Scene_MenuBase
  alias bs2pm_create_command_window create_command_window
  def create_command_window
    bs2pm_create_command_window
    @command_window.set_handler(:bs2pm_party,method(:bs2pm_party))
  end
  def bs2pm_party; SceneManager.call(Scene_BS2PMParty); end
end
class Window_BS2PMParty < Window_Command
  def initialize
    super(0, 0)
  end
  def window_width; 420; end
  def make_command_list
    $game_party.members.each do |a|
      k=BS2PartyMod.key_for_actor(a); next unless k
      add_command("Dismiss #{a.name}",:dismiss,true,k)
    end
    add_command("Cancel",:cancel,true)
  end
end
class Scene_BS2PMParty < Scene_MenuBase
  def start
    super; @w=Window_BS2PMParty.new; @w.x=(Graphics.width-@w.width)/2; @w.y=(Graphics.height-@w.height)/2
    @w.set_handler(:cancel,method(:return_scene))
    @w.set_handler(:dismiss,method(:do_dismiss))
  end
  def do_dismiss
    key=@w.current_ext
    if key.to_i==28
      BS2PartyMod.dismiss_leaf_to_endless_tea_party
    else
      BS2PartyMod.dismiss(key)
    end
    return_scene
  end
end

# Item-use hooks for special reusable items and skill books ---------------------

# Hatta key-item inventory sprite ------------------------------------------------
# The database item icon is intentionally blank. Draw Hatta's actual front-facing
# character sprite in item lists instead of inheriting an unrelated icon.
class Window_Base < Window
  alias bs2pm_draw_item_name_hatta draw_item_name
  def draw_item_name(item,x,y,enabled=true,width=172)
    if item && ["Hatta","Haigha Voodoo Doll","Eepy Rat"].include?(item.name.to_s)
      begin
        sheet=case item.name.to_s
        when "Hatta" then "$帽子屋"
        when "Haigha Voodoo Doll" then "$三月ウサギ"
        when "Eepy Rat" then "眠りネズミ"
        end

        bitmap=Cache.character(sheet)

        if sheet.start_with?("$")
          # Single-character sheet: 3 columns x 4 rows.
          cw=bitmap.width / 3
          ch=bitmap.height / 4
          sx=cw                 # middle walking frame
          sy=0                  # front/down-facing row
        else
          # Standard VX Ace character sheet: 4x2 characters, each 3x4 frames.
          # Dormouse is character index 0.
          cw=bitmap.width / 12
          ch=bitmap.height / 8
          sx=cw                 # char 0, middle walking frame
          sy=0                  # char 0, front/down-facing row
        end

        src=Rect.new(sx,sy,cw,ch)
        dst=Rect.new(x,y,24,24)
        contents.stretch_blt(dst,bitmap,src,enabled ? 255 : translucent_alpha)
        change_color(normal_color,enabled)
        draw_text(x+28,y,width-28,line_height,item.name)
        return
      rescue => e
        BS2PartyMod.log("special item sprite draw failed #{item.name}: #{e.class}: #{e.message}") rescue nil
      end
    end
    bs2pm_draw_item_name_hatta(item,x,y,enabled,width)
  end
end


class Scene_Item < Scene_ItemBase
  alias bs2pm_use_item use_item
  def use_item
    it=item
    if it && ["Hatta","Haigha Voodoo Doll","Eepy Rat"].include?(it.name)
      BS2PartyMod.use_special_item(user,it); @item_window.refresh rescue nil; return
    end
    bs2pm_use_item
  end
end


# Skill-book restrictions are enforced only by the actual
# item_effect_learn_skill target hook. The item/actor selection windows are
# left completely vanilla so the player can move the cursor freely.

# Node leveling is integrated into Node's native choices.


# Keep Dormouse removed from the Endless Tea Party after being carried.
class Game_Map
  alias bs2pm_setup_dormouse_carried setup
  def setup(map_id)
    bs2pm_setup_dormouse_carried(map_id)
    if map_id.to_i==156 && BS2PartyMod.flag(:dormouse_carried)
      ev=@events[27] rescue nil
      ev.erase if ev
    end
  end
end

@echo off
cd /d "%~dp0"
py -3 BS2PartyModPatcher.py
if errorlevel 1 python BS2PartyModPatcher.py
pause

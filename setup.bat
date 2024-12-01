@echo off

cl 2>nul
if errorlevel 1 call vcvarsall.bat x64

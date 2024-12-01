@echo off

cl main.c
if errorlevel 1 call vcvarsall.bat x64

main.exe

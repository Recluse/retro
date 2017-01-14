@echo off
..\c8080\c8080.exe apogeybiostest.c
if errorlevel 1 goto err
..\c8080\tasm -gb -b -85 apogeybiostest.asm apogeybiostest.bin >errors.txt
-make-rka.js
if errorlevel 1 goto err
goto end
:err
type errors.txt
pause
:end
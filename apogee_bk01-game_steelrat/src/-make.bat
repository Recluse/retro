@echo off
cls
del game.bin >nul
tasm -gb -b -85 game.asm game.bin >errors.txt
if errorlevel 1 goto err
rka.js
goto end
:err
type errors.txt 
pause
:end
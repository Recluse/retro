..\c8080\c8080.exe apogeyvideotest.c gprint.c giga.c
if errorlevel 1 goto err
..\c8080\tasm -gb -b -85 apogeyvideotest.asm apogeyvideotest.bin >errors.txt
if errorlevel 1 goto err
-make-rka.js
goto end
:err
type errors.txt
pause
:end
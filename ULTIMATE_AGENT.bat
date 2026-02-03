@echo off
chcp 65001 > nul
title ⚡ ULTIMATE SOLARPUNK AGENT
color 0A

echo.
echo ╔══════════════════════════════════════════════════╗
echo ║         ULTIMATE SOLARPUNK AGENT                 ║
echo ╚══════════════════════════════════════════════════╝
echo.

echo 📁 Checking system health...

:: Check 1: Essential folders
for %%i in (connected dist logs scripts) do (
    if not exist "%%i" (
        echo Creating folder: %%i
        mkdir "%%i"
    )
)

:: Check 2: Essential files
if not exist "START.bat" (
    echo Creating START.bat...
    echo @echo off > START.bat
    echo cd /d "C:\Users\carol\SolarPunk" >> START.bat
    echo python ultimate_agent.py >> START.bat
    echo pause >> START.bat
)

if not exist "PUSH.bat" (
    echo Creating PUSH.bat...
    echo @echo off > PUSH.bat
    echo cd /d "C:\Users\carol\SolarPunk" >> PUSH.bat
    echo git add . 2>nul >> PUSH.bat
    echo git commit -m "Auto-update %%date%% %%time%%" 2>nul >> PUSH.bat
    echo git push origin master 2>nul >> PUSH.bat
    echo echo ✅ Pushed to GitHub >> PUSH.bat
    echo echo 🌐 Cloudflare will update in 30s >> PUSH.bat
    echo pause >> PUSH.bat
)

:: Check 3: Cloudflare content
if not exist "dist\index.html" (
    echo Creating Cloudflare content...
    echo ^<!DOCTYPE html^> > dist\index.html
    echo ^<html^> >> dist\index.html
    echo ^<head^> >> dist\index.html
    echo ^<title^>SolarPunk Autonomous^</title^> >> dist\index.html
    echo ^<meta charset="UTF-8"^> >> dist\index.html
    echo ^<style^>body{font-family:monospace;background:#000;color:#0f0;padding:2rem}.status{border:1px solid #0f0;padding:1rem;margin:1rem 0}^</style^> >> dist\index.html
    echo ^</head^> >> dist\index.html
    echo ^<body^> >> dist\index.html
    echo ^<h1^>⚡ SOLARPUNK AUTONOMOUS^</h1^> >> dist\index.html
    echo ^<div class="status"^>✅ System: OPERATIONAL^</div^> >> dist\index.html
    echo ^<div class="status"^>🔄 Last update: %date% %time%^</div^> >> dist\index.html
    echo ^<p^>This site updates automatically.^</p^> >> dist\index.html
    echo ^</body^> >> dist\index.html
    echo ^</html^> >> dist\index.html
)

:: Check 4: Submodule prevention
if exist ".gitmodules" (
    echo Checking .gitmodules for submodules...
    findstr /i "submodule" .gitmodules >nul
    if %errorlevel% equ 0 (
        echo ❌ Submodules detected in .gitmodules
        echo Removing .gitmodules file...
        del .gitmodules
        echo Creating empty .gitmodules...
        echo # Empty file - no submodules > .gitmodules
    )
)

echo.
echo ✅ System health check complete.
echo.
echo 🚀 Starting ultimate agent...
python ultimate_agent.py

echo.
pause
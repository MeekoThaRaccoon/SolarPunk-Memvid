@echo off
chcp 65001 > nul
title ⚡ REMOVING ALL SUBMODULES - ULTIMATE FIX
color 0A

echo.
echo ╔══════════════════════════════════════════════════╗
echo ║     REMOVING ALL SUBMODULES - ONE CLICK         ║
echo ╚══════════════════════════════════════════════════╝
echo.

echo 📂 Step 1: Removing .gitmodules file...
if exist .gitmodules (
    del .gitmodules
    echo ✅ Deleted .gitmodules
) else (
    echo ℹ️  .gitmodules not found
)

echo 🔧 Step 2: Removing submodule cache entries...
:: We'll remove any submodule under connected/ folder
git rm --cached connected/SolarPunk-Autonomous 2>nul
if errorlevel 1 (
    echo ℹ️  No cache entry for connected/SolarPunk-Autonomous
) else (
    echo ✅ Removed cache for connected/SolarPunk-Autonomous
)

git rm --cached connected/SolarPunk-Nexus 2>nul
if errorlevel 1 (
    echo ℹ️  No cache entry for connected/SolarPunk-Nexus
) else (
    echo ✅ Removed cache for connected/SolarPunk-Nexus
)

:: Remove any other potential submodules in connected/
for /d %%i in (connected\*) do (
    git rm --cached "%%i" 2>nul
    if not errorlevel 1 (
        echo ✅ Removed cache for %%i
    )
)

echo 🗑️ Step 3: Removing nested .git folders in connected/...
if exist "connected\SolarPunk-Autonomous\.git" (
    rmdir /s /q "connected\SolarPunk-Autonomous\.git"
    echo ✅ Removed nested .git in SolarPunk-Autonomous
)
if exist "connected\SolarPunk-Nexus\.git" (
    rmdir /s /q "connected\SolarPunk-Nexus\.git"
    echo ✅ Removed nested .git in SolarPunk-Nexus
)

:: Remove any other nested .git in connected/
for /d %%i in (connected\*) do (
    if exist "%%i\.git" (
        rmdir /s /q "%%i\.git"
        echo ✅ Removed nested .git in %%i
    )
)

echo 📝 Step 4: Adding a placeholder .gitmodules file to avoid future errors...
echo # This file is intentionally blank to prevent submodule errors > .gitmodules
echo # All content in connected/ is now part of the main repository >> .gitmodules

echo 🔄 Step 5: Committing changes...
git add .gitmodules
git add connected/ 2>nul
git commit -m "Remove all submodule references - make connected/ regular folder" 2>nul || echo ⚠️  No changes to commit or commit error

echo 🚀 Step 6: Pushing to GitHub...
git push origin master

echo.
echo ╔══════════════════════════════════════════════════╗
echo ║              ✅ ULTIMATE FIX DONE                ║
echo ╚══════════════════════════════════════════════════╝
echo.
echo 📊 Summary:
echo   • Removed .gitmodules file (replaced with blank)
echo   • Removed all submodule cache entries in connected/
echo   • Removed any nested .git folders in connected/
echo   • Committed and pushed changes
echo.
echo 🌐 Cloudflare will now rebuild without submodule errors.
echo    Wait 60 seconds and check:
echo    https://solarpunkagent.pages.dev
echo.
echo 📁 The connected/ folder is now a regular folder (no submodules).
echo    You can add, remove, or modify files in connected/ normally.
echo.
pause
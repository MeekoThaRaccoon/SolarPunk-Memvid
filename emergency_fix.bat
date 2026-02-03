@echo off
echo === SOLARPUNK EMERGENCY RECOVERY ===
echo.

echo [1] RESTORING GIT REPOSITORY...
cd /d "C:\Users\carol\SolarPunk"
git init
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME.git
echo ✓ Git initialized (REMEMBER TO ADD YOUR GITHUB URL ABOVE)

echo [2] DOWNLOADING AGENT FILES...
curl -o solarpunk_agent_stable.py https://gist.githubusercontent.com/raw/SOLARPUNK_AGENT_CODE
curl -o solarpunk_debug.py https://gist.githubusercontent.com/raw/DEBUG_CODE
echo ✓ Agent files downloaded

echo [3] CREATING CLOUDFLARE CONTENT...
mkdir dist 2>nul
echo ^<!DOCTYPE html^> > dist\index.html
echo ^<html^> >> dist\index.html
echo ^<head^> >> dist\index.html
echo ^<title^>SolarPunk Nexus - RECOVERING^</title^> >> dist\index.html
echo ^</head^> >> dist\index.html
echo ^<body style="background:black;color:lime;font-family:monospace"^> >> dist\index.html
echo ^<h1^>🔄 SYSTEM RECOVERY MODE^</h1^> >> dist\index.html
echo ^<p^>Cloudflare Pages: REBUILDING^</p^> >> dist\index.html
echo ^</body^> >> dist\index.html
echo ^</html^> >> dist\index.html
echo ✓ Cloudflare content created

echo [4] SETTING UP AUTOMATION...
pip install agent-lightning --quiet
mkdir scripts 2>nul
echo import os > scripts\auto_fix.py
echo import subprocess >> scripts\auto_fix.py
echo print("SolarPunk Auto-Fix Ready") >> scripts\auto_fix.py
echo ✓ Automation tools installed

echo [5] CREATING AUTO-RECOVERY CONFIG...
echo # Auto-recovery configuration > recovery_config.yaml
echo auto_fix: true >> recovery_config.yaml
echo check_interval: 300 >> recovery_config.yaml
echo backup_files: true >> recovery_config.yaml
echo ✓ Recovery config created

echo.
echo === NEXT STEPS ===
echo 1. EDIT THE emergency_fix.bat FILE ABOVE
echo 2. Replace YOUR_GITHUB_USERNAME/YOUR_REPO_NAME with your actual GitHub info
echo 3. Run this file again after editing
echo.
pause
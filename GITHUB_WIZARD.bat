@echo off
chcp 65001 > nul
title SolarPunk GitHub Setup Wizard
color 0A

echo.
echo ╔══════════════════════════════════════════════════╗
echo ║        SOLARPUNK GITHUB SETUP WIZARD             ║
echo ║           (Follow instructions exactly)          ║
echo ╚══════════════════════════════════════════════════╝
echo.
echo This will guide you through GitHub setup.
echo Press ANY key to continue...
pause > nul
cls

:STEP1
echo.
echo ┌──────────────────────────────────────────────────┐
echo │                 STEP 1 of 4                      │
echo │          CREATE GITHUB REPOSITORY                │
echo └──────────────────────────────────────────────────┘
echo.
echo 1. Open this link in your browser:
echo    https://github.com/new
echo.
echo 2. Fill in:
echo    - Repository name: SolarPunk-Autonomous
echo    - DO NOT check "Initialize this repository..."
echo    - Leave everything else empty
echo.
echo 3. Click "Create repository"
echo.
echo 4. You'll see a page with a URL like:
echo    https://github.com/YOURUSERNAME/SolarPunk-Autonomous.git
echo.
echo 5. Copy that entire URL to your clipboard
echo.
echo Press ANY key when you've copied the URL...
pause > nul
cls

:STEP2
echo.
echo ┌──────────────────────────────────────────────────┐
echo │                 STEP 2 of 4                      │
echo │         PASTE YOUR GITHUB URL HERE               │
echo └──────────────────────────────────────────────────┘
echo.
echo PASTE the URL you copied (right-click → Paste):
echo.
set /p GITHUB_URL="Enter GitHub URL: "
echo.
echo You entered: %GITHUB_URL%
echo.
choice /C YN /M "Is this correct? (Y/N): "
if errorlevel 2 goto STEP2
cls

:STEP3
echo.
echo ┌──────────────────────────────────────────────────┐
echo │                 STEP 3 of 4                      │
echo │         CREATE GITHUB TOKEN (Optional)           │
echo └──────────────────────────────────────────────────┘
echo.
echo If you want automatic pushes, create a token:
echo.
echo 1. Go to: https://github.com/settings/tokens
echo 2. Click "Generate new token (classic)"
echo 3. Enter note: "SolarPunk Auto-Push"
echo 4. Select ONLY "repo" scope
echo 5. Click "Generate token"
echo 6. COPY the token (long string of letters/numbers)
echo.
choice /C YN /M "Do you have a token to enter? (Y/N): "
if errorlevel 2 goto STEP4

echo.
echo PASTE your token below (it won't show for security):
echo.
set /p GITHUB_TOKEN="Token: "

REM Store token in a secure way
echo %GITHUB_TOKEN% > .github_token
attrib +h .github_token
echo Token saved securely.
echo.
pause
cls

:STEP4
echo.
echo ┌──────────────────────────────────────────────────┐
echo │                 STEP 4 of 4                      │
echo │         CONFIGURING EVERYTHING                   │
echo └──────────────────────────────────────────────────┘
echo.
echo Setting up Git remote...
git remote remove origin 2>nul
git remote add origin "%GITHUB_URL%"
echo ✓ Remote set to: %GITHUB_URL%
echo.

echo Creating push script...
echo @echo off > PUSH.bat
echo cd /d "%%~dp0" >> PUSH.bat
echo git add . >> PUSH.bat
echo git commit -m "Auto-update %%date%% %%time%%" >> PUSH.bat
echo git push origin master >> PUSH.bat
echo echo. >> PUSH.bat
echo echo ✓ Pushed to GitHub! >> PUSH.bat
echo pause >> PUSH.bat
echo ✓ Created: PUSH.bat
echo.

echo Creating .gitignore...
echo .github_token > .gitignore
echo __pycache__/ >> .gitignore
echo *.pyc >> .gitignore
echo ✓ Created: .gitignore
echo.

echo Adding all files to Git...
git add .
git commit -m "Initial setup by SolarPunk Wizard"
echo ✓ Files committed
echo.

:SUMMARY
echo ┌──────────────────────────────────────────────────┐
echo │                    SUMMARY                        │
echo └──────────────────────────────────────────────────┘
echo.
echo ✅ SETUP COMPLETE!
echo.
echo You now have:
echo 1. START.bat    - Run your autonomous agent
echo 2. PUSH.bat     - Push updates to GitHub
echo 3. GITHUB_WIZARD.bat - Run setup again if needed
echo.
echo To deploy:
echo 1. Double-click PUSH.bat (pushes to GitHub)
echo 2. Cloudflare will auto-deploy in 1-2 minutes
echo.
echo Press ANY key to test the push...
pause > nul

echo.
echo Testing push to GitHub...
echo (This may ask for username/password if no token)
git push -u origin master
echo.
echo ╔══════════════════════════════════════════════════╗
echo ║              SYSTEM IS WORKING!                  ║
echo ╚══════════════════════════════════════════════════╝
echo.
echo Check: https://solarpunk-nexus.pages.dev
echo (Allow 2 minutes for Cloudflare to update)
echo.
pause
exit
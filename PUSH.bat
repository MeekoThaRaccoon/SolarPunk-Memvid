@echo off 
cd /d "%~dp0" 
git add . 
git commit -m "Auto-update %date% %time%" 
git push origin master 
echo. 
echo ✓ Pushed to GitHub! 
pause 

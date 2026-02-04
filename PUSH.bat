@echo off 
cd /d "C:\Users\carol\SolarPunk" 
git add . 
git commit -m "Auto-update %date% %time%" 
git push origin master 
echo ✅ Pushed to GitHub 
echo 🌐 Cloudflare will update in 30s 
pause 

@echo off
cd /d "C:\Users\carol\SolarPunk"
echo Updating agent dashboard...
echo ^<!DOCTYPE html^> > dist\index.html
echo ^<html^> >> dist\index.html
echo ^<head^> >> dist\index.html
echo ^<title^>⚡ SolarPunk AGENT Dashboard^</title^> >> dist\index.html
echo ^<style^>body{font-family:monospace;background:#0a0a0a;color:#0f0;padding:2rem} .status{border:1px solid #0f0;padding:1rem;margin:1rem 0}^</style^> >> dist\index.html
echo ^</head^> >> dist\index.html
echo ^<body^> >> dist\index.html
echo ^<h1^>🤖 SOLARPUNK AUTONOMOUS AGENT^</h1^> >> dist\index.html
echo ^<div class="status"^>🟢 AGENT MODE: ACTIVE^</div^> >> dist\index.html
echo ^<div class="status"^>🌐 Site updated at: %date% %time%^</div^> >> dist\index.html
echo ^</body^> >> dist\index.html
echo ^</html^> >> dist\index.html

echo Pushing to GitHub...
git add .
git commit -m "Agent dashboard update %date% %time%"
git push origin master

echo.
echo ✅ Update pushed!
echo 📦 Cloudflare will deploy in 30-60 seconds.
echo 🌐 Check: https://solarpunkagent.pages.dev
echo.
pause
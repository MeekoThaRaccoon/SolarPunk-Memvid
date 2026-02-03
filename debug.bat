@echo off
echo SOLARPUNK SYSTEM DIAGNOSTIC - %DATE% %TIME% > debug_report.txt
echo =========================================== >> debug_report.txt
echo.
echo [1] PYTHON ENVIRONMENT >> debug_report.txt
echo ----------------------- >> debug_report.txt
python --version >> debug_report.txt 2>&1
pip list >> debug_report.txt 2>&1
echo. >> debug_report.txt

echo [2] DIRECTORY STRUCTURE >> debug_report.txt
echo ----------------------- >> debug_report.txt
dir /s /b >> debug_report.txt 2>&1
echo. >> debug_report.txt

echo [3] GIT STATUS >> debug_report.txt
echo ------------- >> debug_report.txt
git status >> debug_report.txt 2>&1
git remote -v >> debug_report.txt 2>&1
echo. >> debug_report.txt

echo [4] CLOUDFLARE CHECK >> debug_report.txt
echo -------------------- >> debug_report.txt
curl -s -o nul -w "%%{http_code}" https://solarpunk-nexus.pages.dev >> debug_report.txt
echo. >> debug_report.txt

echo [5] PYTHON MODULE CHECK >> debug_report.txt
echo ----------------------- >> debug_report.txt
python -c "try: import flask; print('flask: OK'); except: print('flask: MISSING')" >> debug_report.txt 2>&1
python -c "try: import cv2; print('opencv: OK'); except: print('opencv: MISSING')" >> debug_report.txt 2>&1
python -c "try: import numpy; print('numpy: OK'); except: print('numpy: MISSING')" >> debug_report.txt 2>&1
python -c "try: import qrcode; print('qrcode: OK'); except: print('qrcode: MISSING')" >> debug_report.txt 2>&1
echo. >> debug_report.txt

echo [6] AGENT FILES CHECK >> debug_report.txt
echo --------------------- >> debug_report.txt
for %%f in (solarpunk_agent*.py) do (
    if exist "%%f" (
        echo %%f: EXISTS - %%z bytes
    ) else (
        echo %%f: MISSING
    )
) >> debug_report.txt 2>&1
echo. >> debug_report.txt

echo [7] KEY DIRECTORIES >> debug_report.txt
echo ------------------- >> debug_report.txt
if exist "web_dashboard\" echo web_dashboard: EXISTS >> debug_report.txt
if exist "memvid_repo\" echo memvid_repo: EXISTS >> debug_report.txt
if exist "dist\" echo dist: EXISTS >> debug_report.txt
if exist "data\" echo data: EXISTS >> debug_report.txt
echo. >> debug_report.txt

echo [8] WINDOWS SPECIFICS >> debug_report.txt
echo --------------------- >> debug_report.txt
ver >> debug_report.txt
echo PowerShell version: >> debug_report.txt
powershell -command "$PSVersionTable.PSVersion" >> debug_report.txt 2>&1
echo. >> debug_report.txt

echo Diagnostic complete. Report saved to debug_report.txt
pause
@echo off
chcp 65001 > nul
title ⚡ SolarPunk Ultimate Agent
color 0A

echo.
echo ╔══════════════════════════════════════════════════╗
echo ║        ULTIMATE AGENT - NEVER BREAKS            ║
echo ╚══════════════════════════════════════════════════╝
echo.

cd /d "C:\Users\carol\SolarPunk"

echo 📋 Running ultimate agent...
python ultimate_agent.py

echo.
echo ✅ Agent is running and self-healing.
echo 🌐 Cloudflare site: https://solarpunkagent.pages.dev
echo.
pause

@echo off
cd /d %~dp0
set "URL=http://localhost:8116/index.html"
start "" /B python -m http.server 8116
timeout /t 2 >nul
where chrome >nul 2>nul && (
  start "" chrome --incognito "%URL%"
) || (
  start "" msedge --inprivate "%URL%"
)

@echo off
chcp 65001 >nul
cd /d "D:\repos\Gu-Heping.github.io"

echo ========================================
echo   Gu's Home Blog - One Click Deploy
echo ========================================
echo.

echo [1/4] Cleaning and generating...
call hexo clean
call hexo generate
if errorlevel 1 (
    echo [ERROR] hexo generate failed!
    pause
    exit /b 1
)
echo [1/4] Done!
echo.

echo [2/4] Adding files to git...
git add .
echo [2/4] Done!
echo.

echo [3/4] Committing source code...
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "update blog %date% %time:~0,8%"
    git push origin source
    echo [3/4] Source code pushed!
) else (
    echo [3/4] No new changes to commit, skipping...
)
echo.

echo [4/4] Deploying to GitHub Pages...
call hexo deploy
if errorlevel 1 (
    echo [ERROR] hexo deploy failed!
    pause
    exit /b 1
)
echo [4/4] Done!
echo.

echo ========================================
echo   Blog deployed successfully!
echo   https://gu-heping.github.io
echo ========================================
pause
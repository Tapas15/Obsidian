@echo off
cd /d "C:\path\to\your\git\repository"
git diff-index --quiet HEAD --
if %errorlevel% equ 0 (
    echo No changes detected. Exiting.
    exit /b 0
) else (
    echo Changes detected. Proceeding with commit and push.
)
git add --all
git commit -m "Auto-commit on %date% %time%"
git push origin main
echo Changes pushed successfully.
exit /b 0

@echo off
echo ================================
echo  Updating Howling Void from NovaSector
echo ================================
cd /d %~dp0

:: Забираем свежие изменения из оригинала
git fetch upstream

:: Переходим на основную ветку
git checkout main

:: Сливаем обновления NovaSector
git merge upstream/main

:: Проверяем, есть ли конфликты
git diff --check > conflicts.txt
set /p result=<conflicts.txt

if not "%result%"=="" (
    echo !!!
    echo  Conflicts detected! Opening VS Code...
    code .
    echo  Resolve conflicts, then run:
    echo    git add .
    echo    git commit
    echo    git push origin main
) else (
    :: Отправляем изменения в твой форк (origin)
    git push origin main
    echo.
    echo ================================
    echo   Update complete!
    echo ================================
)

pause

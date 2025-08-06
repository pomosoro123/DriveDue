@echo off
echo Building DriveDue APK...
echo.

echo Step 1: Building React app...
call npm run build
if %errorlevel% neq 0 (
    echo Failed to build React app
    exit /b 1
)

echo Step 2: Syncing to Android...
call npx cap sync android
if %errorlevel% neq 0 (
    echo Failed to sync to Android
    exit /b 1
)

echo Step 3: Building APK...
cd android
call gradlew.bat assembleDebug
if %errorlevel% neq 0 (
    echo Failed to build APK
    exit /b 1
)

echo.
echo ✅ APK built successfully!
echo Location: android\app\build\outputs\apk\debug\app-debug.apk
echo.
pause

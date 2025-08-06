@echo off
echo Setting up minimal Android SDK for APK building...
echo This is much smaller than Android Studio (200MB vs 3GB)
echo.

echo Step 1: Creating Android SDK directory...
mkdir C:\android-sdk 2>nul
mkdir C:\android-sdk\cmdline-tools 2>nul

echo.
echo Step 2: Download Android Command Line Tools
echo Please download from: https://developer.android.com/studio#command-tools
echo Extract to: C:\android-sdk\cmdline-tools\latest\
echo.
echo Step 3: After extraction, run this script again to continue setup
echo.

if not exist "C:\android-sdk\cmdline-tools\latest\bin\sdkmanager.bat" (
    echo Command line tools not found. Please download and extract first.
    echo Download: https://developer.android.com/studio#command-tools
    echo Extract to: C:\android-sdk\cmdline-tools\latest\
    pause
    exit /b 1
)

echo Step 4: Setting up environment...
setx ANDROID_HOME "C:\android-sdk" /M
setx PATH "%PATH%;C:\android-sdk\cmdline-tools\latest\bin;C:\android-sdk\platform-tools" /M

echo Step 5: Installing required Android packages...
cd /d C:\android-sdk\cmdline-tools\latest\bin
call sdkmanager.bat "platforms;android-33" "build-tools;33.0.0" "platform-tools"

echo.
echo ✅ Setup complete! You can now build APKs locally.
echo Run build-apk.bat to create your APK.
echo.
pause

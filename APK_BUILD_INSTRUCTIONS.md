# DriveDue APK Build Instructions

## Your app is ready! Here's how to build the APK:

### Option 1: Using Android Studio (Easiest)

1. **Download Android Studio**: https://developer.android.com/studio
2. **Install with default settings** (includes Android SDK)
3. **Run the build script**: Double-click `build-apk.bat` in this folder
4. **Find your APK**: `android\app\build\outputs\apk\debug\app-debug.apk`

### Option 2: Command Line Tools Only (Smaller download)

1. **Download Command Line Tools**: https://developer.android.com/studio#command-tools
2. **Extract to**: `C:\Android\cmdline-tools`
3. **Set environment variables**:
   ```
   ANDROID_HOME=C:\Android
   PATH=%PATH%;%ANDROID_HOME%\cmdline-tools\bin;%ANDROID_HOME%\platform-tools
   ```
4. **Install required packages**:
   ```
   sdkmanager "platforms;android-33" "build-tools;33.0.0"
   ```
5. **Run**: `build-apk.bat`

### Option 3: Online APK Builder (No installation needed)

1. **Zip your project folder**
2. **Upload to**: https://appetize.io or similar online builders
3. **Download the generated APK**

## What's Been Set Up

✅ **Capacitor configured** - Your React app is wrapped for mobile
✅ **Android project created** - Native Android wrapper ready
✅ **Push notifications supported** - Your existing Firebase setup will work
✅ **Build script created** - `build-apk.bat` automates the process

## App Details

- **App Name**: DriveDue
- **Package ID**: com.drivedueapp.drivedueapp
- **Type**: Hybrid (React + Capacitor)
- **Features**: Vehicle document reminders, push notifications

## Testing Your APK

1. **Enable Developer Options** on your Android device
2. **Enable USB Debugging**
3. **Install APK**: `adb install app-debug.apk`
4. **Or transfer APK to device** and install manually

## Troubleshooting

- **Build fails**: Make sure Android SDK is installed
- **APK won't install**: Enable "Install from unknown sources"
- **App crashes**: Check if all environment variables are set in Capacitor config

## Next Steps

After building, you can:
- Test all features including push notifications
- Build a release APK for distribution
- Publish to Google Play Store

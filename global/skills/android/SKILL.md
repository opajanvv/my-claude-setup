---
name: android
description: >
  Build and deploy native Android apps. Use when creating an Android project,
  building APKs, deploying to a device, or troubleshooting Android build issues.
  Triggers: Android app, APK, Gradle Android, Jetpack Compose, adb install,
  deploy to phone, Android build.
---

# Android development

Build native Android apps on Jan's Arch Linux workstation.

## Environment

- **JDK 17** required for Android builds (AGP 8.x is incompatible with JDK 26)
- **Android SDK**: `~/Android/Sdk`
- **adb**: `~/Android/Sdk/platform-tools/adb`
- Both are installed but not on PATH

## Build commands

```bash
export ANDROID_HOME=~/Android/Sdk
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
./gradlew assembleDebug    # debug APK
./gradlew assembleRelease  # signed release APK
```

## Deploy to connected device

```bash
~/Android/Sdk/platform-tools/adb devices  # check connection
~/Android/Sdk/platform-tools/adb install -r app/build/outputs/apk/debug/app-debug.apk
```

If device shows "unauthorized", tell Jan to accept the USB debugging prompt on the phone.

## Compose UI pitfalls

- When combining images with buttons/inputs in a Column, use `Modifier.weight(1f)` on the image. Without it, a large image (especially with `aspectRatio`) pushes interactive elements off screen.
- Adaptive icons need both XML and PNG variants, or just use PNG. Don't reference `ic_launcher_round` unless a round variant exists.

## Gradle notes

- Use `dependencyResolutionManagement` (not `dependencyResolution`) in settings.gradle.kts with Gradle 8.x
- Custom asset-copy tasks need broad `dependsOn` declarations -- lint tasks also read assets, not just `merge*Assets`
- Exclude the task itself from `configureEach` dependency loops

## Preferred stack

- Kotlin + Jetpack Compose + Material 3
- Room for local persistence
- Coil for image loading
- kotlinx.serialization for JSON
- Manual DI for small apps (no Hilt/Koin)
- Single-module, MVVM with repository pattern

## Version catalog

Use `gradle/libs.versions.toml` for dependency management. Tested working versions:
- AGP 8.7.3, Kotlin 2.1.0, KSP 2.1.0-1.0.29
- Compose BOM 2024.12.01, Navigation 2.8.5
- Room 2.6.1, Coil 2.7.0, kotlinx.serialization 1.7.3

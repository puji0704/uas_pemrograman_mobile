plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.safecontact"
    compileSdk = 34

    // 🔥 PAKSA NDK STABIL
    ndkVersion = "25.2.9519653"

    defaultConfig {
        applicationId = "com.example.safecontact"
        minSdk = flutter.minSdkVersion
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
     release {
        isMinifyEnabled = false
        isShrinkResources = false   // 🔥 WAJIB false

       signingConfig = signingConfigs.getByName("debug")
         }
     }


    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }
}

flutter {
    source = "../.."
}

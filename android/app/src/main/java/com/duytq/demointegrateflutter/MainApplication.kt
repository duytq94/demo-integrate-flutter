package com.duytq.demointegrateflutter

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.view.FlutterMain

// Use the same engine will cause some wrong behavior like can't interact, wrong size flutter view
const val PARTIAL_SCREEN_ENGINE_ID = "partialScreenEngineId"
const val FULL_SCREEN_ENGINE_ID = "fullScreenEngineId"

class MainApplication : Application() {

  override fun onCreate() {
    super.onCreate()

    // Instantiate a FlutterEngine
    val flutterEnginePartialScreen = FlutterEngine(this)
    val flutterEngineFullScreen = FlutterEngine(this)

    // Pre-warm flutter
    flutterEnginePartialScreen
        .dartExecutor
        .executeDartEntrypoint(
            DartExecutor.DartEntrypoint(FlutterMain.findAppBundlePath(), "partialScreenEntryPoint")
        )
    flutterEngineFullScreen
        .dartExecutor
        .executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

    // Cache to faster when you re-navigate to flutter
    FlutterEngineCache
        .getInstance()
        .put(PARTIAL_SCREEN_ENGINE_ID, flutterEnginePartialScreen)
    FlutterEngineCache
        .getInstance()
        .put(FULL_SCREEN_ENGINE_ID, flutterEngineFullScreen)

  }
}
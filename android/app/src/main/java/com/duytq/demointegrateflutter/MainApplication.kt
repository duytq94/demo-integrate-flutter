package com.duytq.demointegrateflutter

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

const val ENGINE_ID = "demointegrateflutter"

class MainApplication : Application() {

  override fun onCreate() {
    super.onCreate()

    // Instantiate a FlutterEngine
    val flutterEngine = FlutterEngine(this)

    // Pre-warm flutter
    flutterEngine
        .dartExecutor
        .executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

    // Cache to faster when you re-navigate to flutter
    FlutterEngineCache
        .getInstance()
        .put(ENGINE_ID, flutterEngine)
  }
}
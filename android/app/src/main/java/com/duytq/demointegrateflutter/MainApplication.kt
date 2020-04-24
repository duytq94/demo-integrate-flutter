package com.duytq.demointegrateflutter

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class MainApplication : Application() {

  override fun onCreate() {
    super.onCreate()
    val flutterEngine = FlutterEngine(this)
    // Pre-warm flutter
    flutterEngine
        .dartExecutor
        .executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
    // Cache to faster when you re-navigate flutter
    FlutterEngineCache
        .getInstance()
        .put("my_engine_id", flutterEngine)
  }
}
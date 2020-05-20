package com.duytq.demointegrateflutter

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import androidx.appcompat.app.AppCompatActivity
import com.example.myflutter.MyFlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
  private val CHANNEL = "com.duytq.demointegrateflutter"
  private var flutterEngine: FlutterEngine? = null
  private val PARTIAL_SCREEN_ENGINE_ID = "partialScreenEngineId"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)
    setUpFlutter()
    var screenChose = ""

    val screens = resources.getStringArray(R.array.screens)
    val adapter = ArrayAdapter(this, android.R.layout.simple_spinner_item, screens)
    spinner.adapter = adapter

    spinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
      override fun onNothingSelected(parent: AdapterView<*>?) {
      }

      override fun onItemSelected(parent: AdapterView<*>, view: View, position: Int, id: Long) {
        screenChose = screens[position]
      }
    }
    btnSend.setOnClickListener {
      sendDataToFlutterModule(edt.text.toString(), screenChose)
    }
  }

  private fun setUpFlutter() {
    if (flutterEngine == null) {
      flutterEngine = FlutterEngineCache.getInstance().get(PARTIAL_SCREEN_ENGINE_ID)
      flutterEngine!!
          .dartExecutor
          .executeDartEntrypoint(
              DartExecutor.DartEntrypoint.createDefault()
          )
    }
    flutter_view!!.attachToFlutterEngine(flutterEngine!!)

    MethodChannel(flutterEngine!!.getDartExecutor().getBinaryMessenger(), CHANNEL)
        .invokeMethod("notifyNavToFlutter", "DEFAULT")

    MethodChannel(flutterEngine!!.getDartExecutor().getBinaryMessenger(), CHANNEL)
        .setMethodCallHandler { call, result ->
          run {
            when (call.method) {
              "exitFlutter" -> finish()
              else -> result.notImplemented()
            }
          }
        }
  }

  private fun sendDataToFlutterModule(param: String, screen: String) {
    val intent = Intent(this, MyFlutterActivity::class.java)
    intent.putExtra("param", param)
    intent.putExtra("screen", screen)
    startActivity(intent)
  }

  override fun onResume() {
    super.onResume()
    flutterEngine!!.lifecycleChannel.appIsResumed()
  }

  override fun onPause() {
    super.onPause()
    flutterEngine!!.lifecycleChannel.appIsInactive()
  }

  override fun onStop() {
    super.onStop()
    flutterEngine!!.lifecycleChannel.appIsPaused()
  }

  override fun onDestroy() {
    flutter_view!!.detachFromFlutterEngine()
    super.onDestroy()
  }
}
package com.example.myflutter;

import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;


public class MyFlutterActivity extends FlutterActivity {
  private static final String CHANNEL = "com.duytq.demointegrateflutter";
  private static final String FULL_SCREEN_ENGINE_ID = "fullScreenEngineId";

  @Override
  protected void onResume() {
    super.onResume();
    new MethodChannel(FlutterEngineCache.getInstance().get(FULL_SCREEN_ENGINE_ID).getDartExecutor().getBinaryMessenger(), CHANNEL)
        .invokeMethod("notifyNavToFlutter", getIntent().getStringExtra("screen"));
  }

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
        .setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                switch (call.method) {
                  case "getBatteryLevel":
                    int batteryLevel = MyFlutterActivity.this.getBatteryLevel();
                    if (batteryLevel != -1) {
                      result.success(batteryLevel);
                    } else {
                      result.error("UNAVAILABLE", "Battery level not available.", null);
                    }
                    break;
                  case "getParam":
                    result.success(MyFlutterActivity.this.getIntent().getStringExtra("param"));
                    break;
                  case "exitFlutter":
                    MyFlutterActivity.this.finish();
                    break;
                  default:
                    result.notImplemented();
                }
              }
            }
        );
  }

  @Nullable
  @Override
  public FlutterEngine provideFlutterEngine(@NonNull Context context) {
    return FlutterEngineCache.getInstance().get(FULL_SCREEN_ENGINE_ID);
  }

  private int getBatteryLevel() {
    int batteryLevel = -1;
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
    } else {
      Intent intent = new ContextWrapper(getApplicationContext()).registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
      batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
    }

    return batteryLevel;
  }
}
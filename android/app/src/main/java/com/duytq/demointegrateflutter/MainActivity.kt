package com.duytq.demointegrateflutter

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.AdapterView
import android.widget.ArrayAdapter
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)

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

  private fun sendDataToFlutterModule(param: String, screen: String) {
    val intent = Intent(this, FlutterViewActivity::class.java)
    intent.putExtra("param", param)
    intent.putExtra("screen", screen)
    startActivity(intent)
  }

}


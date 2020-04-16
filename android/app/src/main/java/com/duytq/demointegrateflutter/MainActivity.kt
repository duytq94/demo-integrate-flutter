package com.duytq.demointegrateflutter

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        btnSend.setOnClickListener {
            sendDataToFlutterModule(edt.text.toString())
        }
    }

    private fun sendDataToFlutterModule(param: String) {
        val intent = Intent(this, FlutterViewActivity::class.java)
        intent.putExtra("param", param)
        startActivity(intent)
    }

}


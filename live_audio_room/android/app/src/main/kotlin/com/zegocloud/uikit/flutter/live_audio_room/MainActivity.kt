package com.zegocloud.uikit.flutter.live_audio_room

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import org.jetbrains.annotations.Nullable
import im.zego.zegoexpress.ZegoExpressEngine

class MainActivity: FlutterActivity() {
    override fun onCreate(@Nullable savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // In pages where audio and video need to be kept active, start foreground services.
        startForegroundNotificationService()
    }

    // start foreground services.
    private fun startForegroundNotificationService() {
        startService(Intent(this, ForegroundService::class.java))
    }

    override fun onDestroy() {
        super.onDestroy()

        ZegoExpressEngine.destroyEngine {}

        // when no longer needed, end the foreground service.
//        stopService(Intent(this, ForegroundService::class.java))
    }
}

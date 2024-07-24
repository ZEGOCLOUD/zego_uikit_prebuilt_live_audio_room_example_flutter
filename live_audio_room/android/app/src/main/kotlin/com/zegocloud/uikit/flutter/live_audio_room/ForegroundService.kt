package com.zegocloud.uikit.flutter.live_audio_room

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.content.pm.PackageManager
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import com.zegocloud.uikit.flutter.live_audio_room.R

/**
 * foreground service, only used to keep process foreground to receive messages
 */
class ForegroundService : Service() {
    private val CHANNEL_ID = "channel"
    private val CHANNEL_NAME = "channel name"
    private val CHANNEL_DESC = "channel desc"

    override fun onCreate() {
        super.onCreate()
    }

    override fun onBind(intent: Intent): IBinder? {
        return null
    }

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        createNotificationChannel()
        var appIntent = Intent()
        try {
            appIntent = Intent(this, Class.forName(launcherActivity))
        } catch (e: ClassNotFoundException) {
            e.printStackTrace()
        }
        appIntent.action = Intent.ACTION_MAIN
        appIntent.addCategory(Intent.CATEGORY_LAUNCHER)
        val pendingIntent: PendingIntent
        pendingIntent = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            PendingIntent.getActivity(
                this, 0, appIntent,
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
            )
        } else {
            PendingIntent.getActivity(this, 0, appIntent, PendingIntent.FLAG_UPDATE_CURRENT)
        }
        val context = applicationContext

        val appInfo = context.packageManager.getApplicationInfo(context.packageName, PackageManager.GET_META_DATA)
        val applicationName = appInfo.labelRes
        val appName = if (applicationName != 0) {
            context.getString(applicationName)
        } else {
            appInfo.nonLocalizedLabel.toString()
        }

        //  R.mipmap.launcher_icon是自定义icon
        val builder: NotificationCompat.Builder = NotificationCompat.Builder(context, CHANNEL_ID).setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle(appName).setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setContentIntent(pendingIntent).setOngoing(false).setAutoCancel(true)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            startForeground(NOTIFICATION_ID, builder.build(), ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE)
        } else {
            startForeground(NOTIFICATION_ID, builder.build(),)
        }
        return super.onStartCommand(intent, flags, startId)
    }

    val launcherActivity: String
        get() {
            val intent = Intent(Intent.ACTION_MAIN, null)
            intent.addCategory(Intent.CATEGORY_LAUNCHER)
            intent.setPackage(application.packageName)
            val pm = application.packageManager
            val info = pm.queryIntentActivities(intent, 0)
            return if (info == null || info.size == 0) {
                ""
            } else info[0].activityInfo.name
        }

    override fun onDestroy() {

        stopForeground(true)
        stopSelf()

        super.onDestroy()
    }

    private fun createNotificationChannel() {
        // Create the NotificationChannel, but only on API 26+ because
        // the NotificationChannel class is new and not in the support library
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name: CharSequence = CHANNEL_NAME
            val description = CHANNEL_DESC
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(CHANNEL_ID, name, importance)
            channel.description = description
            channel.setSound(null, null)
            channel.enableVibration(false)
            // Register the channel with the system; you can't change the importance
            // or other notification behaviors after this
            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
        }
    }

    companion object {
        private const val NOTIFICATION_ID = 65532
    }
}
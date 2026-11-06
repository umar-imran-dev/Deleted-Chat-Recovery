package recover.me.message.recover

import android.content.ActivityNotFoundException
import android.content.ComponentName
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.PowerManager
import android.provider.Settings
import android.service.notification.NotificationListenerService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.Executors

class MainActivity : FlutterActivity() {

    companion object {
        private const val REQUEST_PICK_STATUS = 7001
    }

    // Status folder chunne ka jawab yahan ruka rehta hai, jab tak user picker band na kare
    private var pendingPick: MethodChannel.Result? = null
    private var pendingKind: String? = null

    // Bari files parhne ka kaam UI thread par nahi hona chahiye
    private val ioExecutor = Executors.newFixedThreadPool(2)

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val messenger = flutterEngine.dartExecutor.binaryMessenger

        MethodChannel(messenger, "native_log").setMethodCallHandler { call, result ->
            when (call.method) {
                "isEnabled" -> result.success(isListenerEnabled())
                "openSettings" -> {
                    // FIX: kuch phones par ye screen nahi hoti, to crash nahi
                    result.success(
                        try {
                            startActivity(Intent(Settings.ACTION_NOTIFICATION_LISTENER_SETTINGS))
                            true
                        } catch (e: Exception) {
                            NativeLog.add("OPEN SETTINGS ERROR: $e")
                            false
                        }
                    )
                }
                "isBatteryUnrestricted" -> result.success(isBatteryUnrestricted())
                "openBatterySettings" -> {
                    result.success(openBatterySettings())
                }
                "openAutoStartSettings" -> {
                    result.success(openAutoStartSettings())
                }
                "registerBackgroundHandle" -> {
                    val handle = (call.argument<Number>("handle"))?.toLong()
                    if (handle != null) {
                        getSharedPreferences("headless_prefs", MODE_PRIVATE)
                            .edit()
                            .putLong("callback_handle", handle)
                            .apply()
                        result.success(true)
                    } else {
                        result.success(false)
                    }
                }
                "getAvatarPath" -> {
                    val app = call.argument<String>("app") ?: ""
                    val sender = call.argument<String>("sender") ?: ""
                    result.success(AvatarStore.getPath(applicationContext, app, sender))
                }
                "restartService" -> result.success(restartService())
                "isServiceConnected" -> result.success(ServiceState.connected)
                "clearAvatars" -> result.success(AvatarStore.clearAll(applicationContext))
                "setSaveAvatars" -> {
                    val value = call.argument<Boolean>("value") ?: true
                    getSharedPreferences("app_prefs", MODE_PRIVATE)
                        .edit()
                        .putBoolean("save_avatars", value)
                        .apply()
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }

        EventChannel(messenger, "native_events").setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    EventBridge.sink = events
                }

                override fun onCancel(arguments: Any?) {
                    EventBridge.sink = null
                }
            }
        )

        MethodChannel(messenger, "background_channel").setMethodCallHandler { call, result ->
            if (call.method == "log") {
                val line = call.argument<String>("line") ?: ""
                NativeLog.add(line)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }

        // ---------------- STATUS SAVER ----------------
        MethodChannel(messenger, "status_channel").setMethodCallHandler { call, result ->
            val kind = call.argument<String>("kind") ?: "whatsapp"
            when (call.method) {
                "pickFolder" -> pickStatusFolder(kind, result)
                "list" -> runInBackground(result) { StatusStore.list(this, kind) }
                "bytes" -> {
                    val uri = call.argument<String>("uri") ?: ""
                    val mime = call.argument<String>("mime") ?: ""
                    val maxPx = call.argument<Int>("maxPx") ?: 360
                    runInBackground(result) { StatusStore.bytes(this, uri, mime, maxPx) }
                }
                "save" -> {
                    val uri = call.argument<String>("uri") ?: ""
                    val name = call.argument<String>("name") ?: "status"
                    val mime = call.argument<String>("mime") ?: ""
                    runInBackground(result) { StatusStore.save(this, uri, name, mime) }
                }
                else -> result.notImplemented()
            }
        }

        // App khulte hi: permission mili hui hai magar service juri nahi,
        // to system se dobara jorne ko kaho
        rebindListenerIfNeeded()
    }

    // ---------------- STATUS: helpers ----------------

    private fun runInBackground(result: MethodChannel.Result, work: () -> Any?) {
        try {
            ioExecutor.execute {
                val value = try {
                    work()
                } catch (e: Exception) {
                    NativeLog.add("STATUS ERROR: $e")
                    null
                }
                runOnUiThread {
                    // FIX: activity band hone ke baad result bhejna crash na kare
                    try {
                        result.success(value)
                    } catch (e: Exception) {
                        NativeLog.add("STATUS RESULT ERROR: $e")
                    }
                }
            }
        } catch (e: Exception) {
            // Executor band ho chuka ho (activity khatam ho rahi hai)
            try {
                result.success(null)
            } catch (e2: Exception) {
                // koi masla nahi
            }
        }
    }

    private fun pickStatusFolder(kind: String, result: MethodChannel.Result) {
        if (pendingPick != null) {
            result.success("cancelled")
            return
        }
        pendingPick = result
        pendingKind = kind
        try {
            startActivityForResult(StatusStore.pickerIntent(kind), REQUEST_PICK_STATUS)
        } catch (e: Exception) {
            NativeLog.add("STATUS PICKER ERROR: $e")
            pendingPick = null
            pendingKind = null
            result.success("cancelled")
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode != REQUEST_PICK_STATUS) return

        val result = pendingPick
        val kind = pendingKind ?: "whatsapp"
        pendingPick = null
        pendingKind = null
        if (result == null) return

        val uri = data?.data
        if (resultCode != RESULT_OK || uri == null) {
            result.success("cancelled")
            return
        }
        result.success(
            try {
                StatusStore.saveFolder(this, kind, uri)
            } catch (e: Exception) {
                NativeLog.add("STATUS SAVE FOLDER ERROR: $e")
                "cancelled"
            }
        )
    }

    // ---------------- Notification listener ----------------

    // Permission on hai magar service abhi juri nahi (jaise phone ne usay band kar diya tha)
    private fun rebindListenerIfNeeded() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.N) return
        if (!isListenerEnabled() || ServiceState.connected) return

        try {
            NotificationListenerService.requestRebind(
                ComponentName(this, MessagesListenerService::class.java)
            )
            NativeLog.add("APP OPEN: service juri nahi thi, rebind ki request bheji")
        } catch (e: Exception) {
            NativeLog.add("APP OPEN REBIND ERROR: $e")
        }
    }

    private fun isListenerEnabled(): Boolean {
        val enabled = Settings.Secure.getString(
            contentResolver,
            "enabled_notification_listeners"
        ) ?: ""
        return enabled.split(":").any { it.startsWith("$packageName/") }
    }

    private fun isBatteryUnrestricted(): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) return true
        val pm = getSystemService(POWER_SERVICE) as PowerManager
        return pm.isIgnoringBatteryOptimizations(packageName)
    }

    // FIX: sirf battery settings ki list wali screen kholte hain.
    // ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS wali permission Play Store par restricted
    // hai, is liye wo intent istemal nahi karte.
    private fun openBatterySettings(): Boolean {
        return try {
            startActivity(Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS))
            true
        } catch (e: Exception) {
            try {
                startActivity(
                    Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS).apply {
                        data = android.net.Uri.parse("package:$packageName")
                    }
                )
                true
            } catch (e2: Exception) {
                false
            }
        }
    }

    private fun openAutoStartSettings(): Boolean {
        val attempts = listOf(
            Intent().setComponent(
                ComponentName(
                    "com.coloros.safecenter",
                    "com.coloros.safecenter.permission.startup.StartupAppListActivity"
                )
            ),
            Intent().setComponent(
                ComponentName(
                    "com.coloros.safecenter",
                    "com.coloros.safecenter.startupapp.StartupAppListActivity"
                )
            ),
            Intent().setComponent(
                ComponentName(
                    "com.oppo.safe",
                    "com.oppo.safe.permission.startup.StartupAppListActivity"
                )
            ),
            Intent("android.settings.APPLICATION_DETAILS_SETTINGS").apply {
                data = android.net.Uri.parse("package:$packageName")
            }
        )

        for (intent in attempts) {
            try {
                startActivity(intent)
                return true
            } catch (e: ActivityNotFoundException) {
                // agla try karo
            } catch (e: Exception) {
                // agla try karo
            }
        }
        return false
    }

    // Service ko band karke dobara chalu karo aur system se dobara jorne ko kaho
    private fun restartService(): Boolean {
        return try {
            val component = ComponentName(this, MessagesListenerService::class.java)
            ServiceState.connected = false

            packageManager.setComponentEnabledSetting(
                component,
                PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                PackageManager.DONT_KILL_APP
            )
            packageManager.setComponentEnabledSetting(
                component,
                PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                PackageManager.DONT_KILL_APP
            )

            HeadlessEngine.reset()

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                NotificationListenerService.requestRebind(component)
            }
            NativeLog.add("RESTART: service restart ki request bhej di")
            true
        } catch (e: Exception) {
            NativeLog.add("RESTART ERROR: $e")
            false
        }
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        EventBridge.sink = null
    }

    // FIX: activity band hone par thread pool band karo aur atka hua picker ka jawab do
    override fun onDestroy() {
        try {
            pendingPick?.success("cancelled")
        } catch (e: Exception) {
            // koi masla nahi
        }
        pendingPick = null
        pendingKind = null
        ioExecutor.shutdown()
        super.onDestroy()
    }
}
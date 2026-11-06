package recover.me.message.recover

import android.app.KeyguardManager
import android.app.Notification
import android.content.Context
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.Parcelable
import android.os.PowerManager
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import io.flutter.plugin.common.EventChannel

// Sirf app ki halat ke chhote logs (message ka text ya sender ka naam yahan nahi likhte)
object NativeLog {
    private val lines = java.util.concurrent.CopyOnWriteArrayList<String>()

    fun add(line: String) {
        lines.add(0, line)
        while (lines.size > 200) {
            lines.removeAt(lines.size - 1)
        }
    }

    fun snapshot(): List<String> = lines.toList()
}

object EventBridge {
    @Volatile
    var sink: EventChannel.EventSink? = null
    private val handler = Handler(Looper.getMainLooper())

    fun send(event: Map<String, Any?>) {
        handler.post {
            // FIX: sink band ho chuka ho to bhi crash nahi
            try {
                sink?.success(event)
            } catch (e: Exception) {
                NativeLog.add("EVENT SEND ERROR: $e")
            }
        }
    }
}

// Jin apps ko hum sunte hain, unka package naam -> dikhane wala naam
val SUPPORTED_APPS: Map<String, String> = mapOf(
    "com.whatsapp" to "WhatsApp",
    "com.whatsapp.w4b" to "WhatsApp",
    "org.telegram.messenger" to "Telegram",
    "com.facebook.orca" to "Messenger",
    "com.facebook.katana" to "Facebook",
    "com.instagram.android" to "Instagram",
    "com.twitter.android" to "X",
    "com.snapchat.android" to "Snapchat",
    "com.zhiliaoapp.musically" to "TikTok",
    "com.ss.android.ugc.trill" to "TikTok"
)

class MessagesListenerService : NotificationListenerService() {

    private fun now(): String =
        java.text.SimpleDateFormat("HH:mm:ss", java.util.Locale.getDefault())
            .format(java.util.Date())

    private fun appNameFor(sbn: StatusBarNotification): String? =
        SUPPORTED_APPS[sbn.packageName]

    private fun isSummary(sbn: StatusBarNotification): Boolean =
        (sbn.notification.flags and Notification.FLAG_GROUP_SUMMARY) != 0

    override fun onListenerConnected() {
        super.onListenerConnected()
        ServiceState.connected = true
        NativeLog.add("${now()} | SERVICE CONNECTED")
        startForegroundWithNotification()
    }

    private fun startForegroundWithNotification() {
        try {
            val channelId = "recovery_service_channel"
            val manager = getSystemService(Context.NOTIFICATION_SERVICE)
                as android.app.NotificationManager

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                val channel = android.app.NotificationChannel(
                    channelId,
                    "Message watching",
                    android.app.NotificationManager.IMPORTANCE_MIN
                )
                manager.createNotificationChannel(channel)
            }

            // FIX: Notification.Builder(context, channelId) sirf API 26+ par hota hai.
            // Purane phones (API 24-25) par pehle yahan crash hota tha.
            val builder =
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    Notification.Builder(this, channelId)
                } else {
                    @Suppress("DEPRECATION")
                    Notification.Builder(this)
                }

            val notification = builder
                .setContentTitle("Deleted Chat Recovery")
                // FIX: Roman Urdu ki jagah English (user ko dikhta hai)
                .setContentText("Saving incoming messages on this device")
                // TODO: apna ic_stat_notify drawable bana kar yahan lagayein
                .setSmallIcon(android.R.drawable.ic_dialog_info)
                .setOngoing(true)
                .build()

            startForeground(1, notification)
            NativeLog.add("${now()} | FOREGROUND STARTED")
        } catch (e: Exception) {
            NativeLog.add("${now()} | FOREGROUND ERROR: $e")
        }
    }

    override fun onListenerDisconnected() {
        super.onListenerDisconnected()
        ServiceState.connected = false
        NativeLog.add("${now()} | SERVICE DISCONNECTED")

        // System ne service ko hata diya ho to dobara jorne ko kaho
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            try {
                NotificationListenerService.requestRebind(
                    android.content.ComponentName(this, MessagesListenerService::class.java)
                )
                NativeLog.add("${now()} | REBIND requested")
            } catch (e: Exception) {
                NativeLog.add("${now()} | REBIND ERROR: $e")
            }
        }
    }

    override fun onNotificationPosted(sbn: StatusBarNotification) {
        // FIX: koi bhi ajeeb notification service ko crash na kare. Service crash hui
        // to poori app ka process band ho jata hai aur messages miss ho jate hain.
        try {
            handlePosted(sbn)
        } catch (e: Exception) {
            NativeLog.add("${now()} | POSTED ERROR: ${e.javaClass.simpleName}")
        }
    }

    private fun handlePosted(sbn: StatusBarNotification) {
        val appName = appNameFor(sbn) ?: return

        // Call ki notification (incoming/missed/ongoing call) kisi bhi app
        // se ho, use hamesha chhor do, chahe WhatsApp ho ya koi aur
        if (sbn.notification.category == Notification.CATEGORY_CALL) {
            NativeLog.add("${now()} | [$appName] SKIPPED (call notification)")
            return
        }

        // Sirf "message" category wali notifications lo: likes, comments,
        // follow requests waghera chhor do. WhatsApp, TikTok aur Messenger
        // apni category set nahi karte, isliye unhe is check se chhoot di jati hai.
        if (appName != "WhatsApp" && appName != "TikTok" && appName != "Messenger") {
            val category = sbn.notification.category
            if (category != Notification.CATEGORY_MESSAGE) {
                NativeLog.add(
                    "${now()} | [$appName] SKIPPED (category=$category, msg nahi)"
                )
                return
            }
        }

        // TikTok category se kuch farq nahi karta, isliye activity
        // notifications (view, like, comment, follow) ko text se pakarte hain
        if (appName == "TikTok") {
            val quickText = sbn.notification.extras
                .getCharSequence(Notification.EXTRA_TEXT)?.toString() ?: ""
            val lower = quickText.lowercase()
            val activityWords = listOf(
                "viewed your profile",
                "liked your",
                "commented",
                "started following you",
                "mentioned you",
                "posted a new video",
                "shared your"
            )
            if (activityWords.any { lower.contains(it) }) {
                NativeLog.add("${now()} | [TikTok] SKIPPED (activity notification)")
                return
            }
        }

        val extras = sbn.notification.extras
        val title = extras.getCharSequence(Notification.EXTRA_TITLE)?.toString() ?: ""
        val text = extras.getCharSequence(Notification.EXTRA_TEXT)?.toString() ?: ""
        val summary = isSummary(sbn)

        @Suppress("DEPRECATION")
        var items = (extras.getParcelableArray(Notification.EXTRA_MESSAGES)
            ?: emptyArray<Parcelable>())
            .mapNotNull { it as? Bundle }
            .map { b ->
                mapOf(
                    "text" to (b.getCharSequence("text")?.toString() ?: ""),
                    "time" to b.getLong("time")
                )
            }

        // TikTok jaisi apps poori list nahi bhejtin, sirf ek text deti hain.
        // Us soorat mein khud ek-item wali list bana lete hain, taake
        // ye bhi WhatsApp jaisa hi "messages list" raaste se guzar sake.
        if (items.isEmpty() && text.isNotEmpty() && text != "This message was deleted") {
            items = listOf(mapOf("text" to text, "time" to sbn.postTime))
        }

        // Log mein sirf ginti aur halat, message ka text ya sender ka naam nahi
        NativeLog.add("${now()} | [$appName] POSTED summary=$summary count=${items.size}")

        val saveAvatars = applicationContext
            .getSharedPreferences("app_prefs", Context.MODE_PRIVATE)
            .getBoolean("save_avatars", true)
        if (!summary && saveAvatars) {
            AvatarStore.saveIfPresent(applicationContext, sbn, appName, title)
        }

        val isDeletedNotice = text == "This message was deleted"
        if (summary && !isDeletedNotice) return

        val payload = mapOf(
            "app" to appName,
            "sender" to title,
            "text" to text,
            "messages" to items
        )

        if (EventBridge.sink != null) {
            EventBridge.send(mapOf("type" to "posted") + payload)
        } else {
            NativeLog.add("${now()} | UI nahi juri, headless ko bhej rahe hain")
            HeadlessEngine.sendEvent(applicationContext, "posted", payload)
        }
    }

    override fun onNotificationRemoved(
        sbn: StatusBarNotification,
        rankingMap: NotificationListenerService.RankingMap,
        reason: Int
    ) {
        // FIX: yahan bhi koi masla service ko na giraye
        try {
            handleRemoved(sbn, reason)
        } catch (e: Exception) {
            NativeLog.add("${now()} | REMOVED ERROR: ${e.javaClass.simpleName}")
        }
    }

    private fun handleRemoved(sbn: StatusBarNotification, reason: Int) {
        val appName = appNameFor(sbn) ?: return
        if (isSummary(sbn)) return

        val title = sbn.notification.extras
            .getCharSequence(Notification.EXTRA_TITLE)?.toString() ?: ""

        val pm = getSystemService(Context.POWER_SERVICE) as PowerManager
        val km = getSystemService(Context.KEYGUARD_SERVICE) as KeyguardManager
        val idle = !pm.isInteractive || km.isKeyguardLocked

        NativeLog.add("${now()} | [$appName] REMOVED reason=$reason idle=$idle")

        val payload = mapOf(
            "app" to appName,
            "sender" to title,
            "reason" to reason,
            "idle" to idle
        )

        if (EventBridge.sink != null) {
            EventBridge.send(mapOf("type" to "removed") + payload)
        } else {
            HeadlessEngine.sendEvent(applicationContext, "removed", payload)
        }
    }
}
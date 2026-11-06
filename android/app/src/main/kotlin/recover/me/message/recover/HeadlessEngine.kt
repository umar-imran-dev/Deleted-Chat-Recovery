package recover.me.message.recover

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.loader.FlutterLoader
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.FlutterCallbackInformation

// Ye chhota isolate ek dafa shuru hota hai aur process zinda rehne tak
// dobara istemal hota rehta hai (har notification par naya engine nahi banate).
object HeadlessEngine {
    private var engine: FlutterEngine? = null
    private var channel: MethodChannel? = null
    private var starting = false
    private var isReady = false
    private val pendingEvents = mutableListOf<Pair<String, Map<String, Any?>>>()

    private fun now(): String =
        java.text.SimpleDateFormat("HH:mm:ss", java.util.Locale.getDefault())
            .format(java.util.Date())

    fun ensureStarted(context: Context) {
        if (engine != null || starting) return
        starting = true

        val prefs = context.getSharedPreferences("headless_prefs", Context.MODE_PRIVATE)
        val handle = prefs.getLong("callback_handle", -1L)
        if (handle == -1L) {
            NativeLog.add("${now()} | HEADLESS: koi handle save nahi (app ek dafa kholna zaroori)")
            starting = false
            return
        }

        val callbackInfo = FlutterCallbackInformation.lookupCallbackInformation(handle)
        if (callbackInfo == null) {
            NativeLog.add("${now()} | HEADLESS: callback lookup fail")
            starting = false
            return
        }

        val appContext = context.applicationContext
        val loader = FlutterLoader()
        loader.startInitialization(appContext)
        loader.ensureInitializationComplete(appContext, null)

        val newEngine = FlutterEngine(appContext)
        val ch = MethodChannel(newEngine.dartExecutor.binaryMessenger, "background_channel")
                ch.setMethodCallHandler { call, result ->
            when (call.method) {
                "ready" -> {
                    isReady = true
                    NativeLog.add("${now()} | HEADLESS: dart isolate ready")
                    result.success(null)
                    val toSend = pendingEvents.toList()
                    pendingEvents.clear()
                    toSend.forEach { (m, a) -> invokeNow(m, a) }
                }
                "log" -> {
                    val line = call.argument<String>("line") ?: ""
                    NativeLog.add("${now()} | $line")
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }

        val args = DartExecutor.DartCallback(
            appContext.assets,
            loader.findAppBundlePath(),
            callbackInfo
        )
        newEngine.dartExecutor.executeDartCallback(args)

        engine = newEngine
        channel = ch
        starting = false
        NativeLog.add("${now()} | HEADLESS: engine start ho gaya")
    }

        // Restart Service par background wala Dart engine bhi saaf kar do,
    // agle event par ye khud naya shuru ho jayega
    fun reset() {
        try {
            engine?.destroy()
        } catch (e: Exception) {
            NativeLog.add("${now()} | HEADLESS: reset error $e")
        }
        engine = null
        channel = null
        starting = false
        isReady = false
        pendingEvents.clear()
        NativeLog.add("${now()} | HEADLESS: reset ho gaya")
    }

    fun sendEvent(context: Context, method: String, args: Map<String, Any?>) {
        ensureStarted(context)
        if (!isReady) {
            pendingEvents.add(method to args)
            return
        }
        invokeNow(method, args)
    }

    private fun invokeNow(method: String, args: Map<String, Any?>) {
        channel?.invokeMethod(method, args, object : MethodChannel.Result {
            override fun success(result: Any?) {
                NativeLog.add("${now()} | HEADLESS: $method done")
            }

            override fun error(code: String, msg: String?, details: Any?) {
                NativeLog.add("${now()} | HEADLESS: $method error $code $msg")
            }

            override fun notImplemented() {
                NativeLog.add("${now()} | HEADLESS: $method not implemented")
            }
        })
    }
}
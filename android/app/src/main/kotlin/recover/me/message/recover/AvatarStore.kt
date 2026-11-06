package recover.me.message.recover

import android.app.Notification
import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.os.Build
import android.service.notification.StatusBarNotification
import java.io.File
import java.io.FileOutputStream

private fun sanitize(value: String): String =
    value.trim().lowercase().replace(Regex("[^a-z0-9]"), "_")

object AvatarStore {

    fun saveIfPresent(context: Context, sbn: StatusBarNotification, app: String, sender: String) {
        try {
            val bitmap = extractLargeIcon(context, sbn.notification)
            if (bitmap == null) {
                NativeLog.add("AVATAR: [$app] koi icon nahi mila")
                return
            }
            val dir = File(context.filesDir, "avatars")
            if (!dir.exists()) dir.mkdirs()
            val file = File(dir, "${sanitize(app)}_${sanitize(sender)}.png")
            FileOutputStream(file).use { out ->
                bitmap.compress(Bitmap.CompressFormat.PNG, 90, out)
            }
            NativeLog.add("AVATAR: [$app] save hua")
        } catch (e: Exception) {
            NativeLog.add("AVATAR ERROR: [$app] -> $e")
        }
    }

    fun getPath(context: Context, app: String, sender: String): String? {
        val file = File(File(context.filesDir, "avatars"), "${sanitize(app)}_${sanitize(sender)}.png")
        return if (file.exists()) file.absolutePath else null
    }

    // Saari save ki hui profile tasveeren hata do
    fun clearAll(context: Context): Boolean {
        val dir = File(context.filesDir, "avatars")
        if (!dir.exists()) return true
        return dir.listFiles()?.all { it.delete() } ?: true
    }

    private fun extractLargeIcon(context: Context, notification: Notification): Bitmap? {
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                val icon = notification.getLargeIcon() ?: return null
                val drawable = icon.loadDrawable(context) ?: return null
                drawableToBitmap(drawable)
            } else {
                @Suppress("DEPRECATION")
                notification.largeIcon
            }
        } catch (e: Exception) {
            null
        }
    }

    private fun drawableToBitmap(drawable: Drawable): Bitmap {
        if (drawable is BitmapDrawable && drawable.bitmap != null) return drawable.bitmap
        val width = if (drawable.intrinsicWidth > 0) drawable.intrinsicWidth else 96
        val height = if (drawable.intrinsicHeight > 0) drawable.intrinsicHeight else 96
        val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)
        return bitmap
    }
}
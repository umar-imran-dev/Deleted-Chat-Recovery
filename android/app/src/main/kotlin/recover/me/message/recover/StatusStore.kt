package recover.me.message.recover

import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.media.MediaMetadataRetriever
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.DocumentsContract
import android.provider.MediaStore
import java.io.ByteArrayOutputStream

// WhatsApp ke Status folder ko parhta hai (user ke chune hue folder ke zariye) aur
// status ko gallery mein save karta hai. Koi bari storage permission nahi chahiye.
object StatusStore {
    private const val PREFS = "status_prefs"
    private const val AUTHORITY = "com.android.externalstorage.documents"

    private fun prefs(context: Context) =
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)

    private fun treeKey(kind: String) = "tree_uri_$kind"

    // Chuna hua folder .Statuses ke andar ka document id (user ne upar wala folder chuna ho to bhi)
    private fun docKey(kind: String) = "statuses_doc_$kind"

    // kind: "whatsapp" ya "business"
    private fun statusPath(kind: String): String {
        val business = kind == "business"
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            if (business) "Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses"
            else "Android/media/com.whatsapp/WhatsApp/Media/.Statuses"
        } else {
            if (business) "WhatsApp Business/Media/.Statuses"
            else "WhatsApp/Media/.Statuses"
        }
    }

    // Folder picker seedha Status folder par khule
    fun pickerIntent(kind: String): Intent {
        val initial = DocumentsContract.buildDocumentUri(AUTHORITY, "primary:" + statusPath(kind))
        return Intent(Intent.ACTION_OPEN_DOCUMENT_TREE).apply {
            putExtra(DocumentsContract.EXTRA_INITIAL_URI, initial)
            addFlags(
                Intent.FLAG_GRANT_READ_URI_PERMISSION or
                    Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION
            )
        }
    }

    // "ok", "wrong_folder" ya "cancelled"
    fun saveFolder(context: Context, kind: String, uri: Uri): String {
        val treeDocId = try {
            DocumentsContract.getTreeDocumentId(uri)
        } catch (e: Exception) {
            return "wrong_folder"
        }

        // User ne seedha .Statuses chuna, ya uske upar wala WhatsApp / Media folder:
        // dono soorat mein .Statuses khud dhoond lete hain
        val statusesDocId = when {
            treeDocId.endsWith(".Statuses") -> treeDocId
            treeDocId.endsWith("/Media") -> "$treeDocId/.Statuses"
            treeDocId.endsWith("/WhatsApp") -> "$treeDocId/Media/.Statuses"
            treeDocId.endsWith("/WhatsApp Business") -> "$treeDocId/Media/.Statuses"
            else -> return "wrong_folder"
        }

        if (!folderReadable(context, uri, statusesDocId)) return "wrong_folder"

        try {
            context.contentResolver.takePersistableUriPermission(
                uri,
                Intent.FLAG_GRANT_READ_URI_PERMISSION
            )
        } catch (e: Exception) {
            NativeLog.add("STATUS: permission save nahi hui: $e")
            return "cancelled"
        }

        prefs(context).edit()
            .putString(treeKey(kind), uri.toString())
            .putString(docKey(kind), statusesDocId)
            .apply()
        return "ok"
    }

    // Kya ye folder sach mein maujood hai aur parha ja sakta hai?
    private fun folderReadable(context: Context, tree: Uri, docId: String): Boolean {
        return try {
            val children = DocumentsContract.buildChildDocumentsUriUsingTree(tree, docId)
            context.contentResolver.query(
                children,
                arrayOf(DocumentsContract.Document.COLUMN_DOCUMENT_ID),
                null,
                null,
                null
            )?.use { true } ?: false
        } catch (e: Exception) {
            false
        }
    }

    // File ka type: mime sahi ho to wahi, warna extension se. Kaam ki file na ho to null
    private fun resolveMime(name: String, mime: String): String? {
        if (mime.startsWith("image/") || mime.startsWith("video/") || mime.startsWith("audio/")) {
            return mime
        }
        val lower = name.lowercase()
        return when {
            lower.endsWith(".mp4") -> "video/mp4"
            lower.endsWith(".3gp") -> "video/3gpp"
            lower.endsWith(".jpg") || lower.endsWith(".jpeg") -> "image/jpeg"
            lower.endsWith(".png") -> "image/png"
            lower.endsWith(".webp") -> "image/webp"
            lower.endsWith(".opus") || lower.endsWith(".ogg") -> "audio/ogg"
            lower.endsWith(".mp3") -> "audio/mpeg"
            lower.endsWith(".m4a") || lower.endsWith(".aac") -> "audio/mp4"
            lower.endsWith(".amr") -> "audio/amr"
            lower.endsWith(".wav") -> "audio/x-wav"
            else -> null
        }
    }

    // null = folder abhi chuna nahi gaya (ya permission chali gayi)
    fun list(context: Context, kind: String): List<Map<String, Any?>>? {
        val saved = prefs(context).getString(treeKey(kind), null) ?: return null
        val tree = Uri.parse(saved)

        val hasPermission = context.contentResolver.persistedUriPermissions
            .any { it.uri == tree && it.isReadPermission }
        if (!hasPermission) return null

        val items = mutableListOf<Map<String, Any?>>()
        try {
            val docId = prefs(context).getString(docKey(kind), null)
                ?: DocumentsContract.getTreeDocumentId(tree)
            val children = DocumentsContract.buildChildDocumentsUriUsingTree(tree, docId)
            val columns = arrayOf(
                DocumentsContract.Document.COLUMN_DOCUMENT_ID,
                DocumentsContract.Document.COLUMN_DISPLAY_NAME,
                DocumentsContract.Document.COLUMN_MIME_TYPE,
                DocumentsContract.Document.COLUMN_LAST_MODIFIED
            )
            context.contentResolver.query(children, columns, null, null, null)?.use { c ->
                while (c.moveToNext()) {
                    val childId = c.getString(0) ?: continue
                    val name = c.getString(1) ?: continue
                    val mime = c.getString(2) ?: continue
                    val modified = c.getLong(3)

                    val resolvedMime = resolveMime(name, mime) ?: continue

                    val docUri = DocumentsContract.buildDocumentUriUsingTree(tree, childId)
                    items.add(
                        mapOf(
                            "uri" to docUri.toString(),
                            "name" to name,
                            "mime" to resolvedMime,
                            "modified" to modified
                        )
                    )
                }
            }
        } catch (e: Exception) {
            NativeLog.add("STATUS LIST ERROR: $e")
            return null
        }

        items.sortByDescending { it["modified"] as Long }
        return items
    }

    // Thumbnail ya bara preview (JPEG bytes). Audio ka koi picture nahi hota, to null
    fun bytes(context: Context, uriStr: String, mime: String, maxPx: Int): ByteArray? {
        if (mime.startsWith("audio/")) return null

        val uri = Uri.parse(uriStr)
        val bitmap = if (mime.startsWith("video/")) {
            videoFrame(context, uri)
        } else {
            decodeSampled(context, uri, maxPx)
        } ?: return null

        val scaled = scaleDown(bitmap, maxPx)
        val out = ByteArrayOutputStream()
        scaled.compress(Bitmap.CompressFormat.JPEG, 85, out)
        return out.toByteArray()
    }

    private fun decodeSampled(context: Context, uri: Uri, maxPx: Int): Bitmap? {
        val bounds = BitmapFactory.Options().apply { inJustDecodeBounds = true }
        context.contentResolver.openInputStream(uri)?.use {
            BitmapFactory.decodeStream(it, null, bounds)
        }

        var sample = 1
        while (bounds.outWidth / sample > maxPx * 2 || bounds.outHeight / sample > maxPx * 2) {
            sample *= 2
        }

        val options = BitmapFactory.Options().apply { inSampleSize = sample }
        return context.contentResolver.openInputStream(uri)?.use {
            BitmapFactory.decodeStream(it, null, options)
        }
    }

    private fun videoFrame(context: Context, uri: Uri): Bitmap? {
        val retriever = MediaMetadataRetriever()
        return try {
            retriever.setDataSource(context, uri)
            retriever.getFrameAtTime(0, MediaMetadataRetriever.OPTION_CLOSEST_SYNC)
        } catch (e: Exception) {
            null
        } finally {
            try {
                retriever.release()
            } catch (e: Exception) {
                // koi masla nahi
            }
        }
    }

    private fun scaleDown(bitmap: Bitmap, maxPx: Int): Bitmap {
        val longest = maxOf(bitmap.width, bitmap.height)
        if (longest <= maxPx) return bitmap
        val ratio = maxPx.toFloat() / longest
        return Bitmap.createScaledBitmap(
            bitmap,
            (bitmap.width * ratio).toInt().coerceAtLeast(1),
            (bitmap.height * ratio).toInt().coerceAtLeast(1),
            true
        )
    }

    // Gallery mein save: Pictures / Movies / Music ke andar DeletedChatBack folder
    fun save(context: Context, uriStr: String, name: String, mime: String): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) return false

        val isVideo = mime.startsWith("video/")
        val isAudio = mime.startsWith("audio/")

        val collection = when {
            isVideo -> MediaStore.Video.Media.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
            isAudio -> MediaStore.Audio.Media.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
            else -> MediaStore.Images.Media.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
        }
        val folder = when {
            isVideo -> Environment.DIRECTORY_MOVIES
            isAudio -> Environment.DIRECTORY_MUSIC
            else -> Environment.DIRECTORY_PICTURES
        }

        val values = ContentValues().apply {
            put(MediaStore.MediaColumns.DISPLAY_NAME, name)
            put(MediaStore.MediaColumns.MIME_TYPE, mime)
            put(MediaStore.MediaColumns.RELATIVE_PATH, "$folder/DeletedChatBack")
            put(MediaStore.MediaColumns.IS_PENDING, 1)
        }

        val resolver = context.contentResolver
        val destination = resolver.insert(collection, values) ?: return false

        return try {
            val input = resolver.openInputStream(Uri.parse(uriStr))
                ?: throw IllegalStateException("source nahi khuli")
            val output = resolver.openOutputStream(destination)
                ?: throw IllegalStateException("destination nahi khuli")
            input.use { i -> output.use { o -> i.copyTo(o) } }

            values.clear()
            values.put(MediaStore.MediaColumns.IS_PENDING, 0)
            resolver.update(destination, values, null, null)
            true
        } catch (e: Exception) {
            NativeLog.add("STATUS SAVE ERROR: $e")
            resolver.delete(destination, null, null)
            false
        }
    }
}
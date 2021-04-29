package com.reactnativedocumentopener

import android.content.Intent
import androidx.core.content.FileProvider
import com.facebook.react.bridge.*
import java.io.File

class DocumentOpenerModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
  override fun getName(): String {
    return "DocumentOpener"
  }

  @ReactMethod
  fun openAsync(filePath: String, mimeType: String?, promise: Promise) {
    try {
      val uri = FileProvider.getUriForFile(reactApplicationContext, reactApplicationContext.packageName + ".RnDocumentOpenerProvider", File(filePath))
      val resolvedType = mimeType ?: reactApplicationContext.contentResolver.getType(uri)

      val intent = Intent(Intent.ACTION_VIEW).apply {
        setDataAndType(uri, resolvedType)
        addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      }

      reactApplicationContext.startActivity(intent)
      promise.resolve(null)
    } catch (exception: Exception) {
      promise.reject(exception)
    }
  }
}

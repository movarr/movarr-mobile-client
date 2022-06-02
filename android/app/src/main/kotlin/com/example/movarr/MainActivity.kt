package com.example.movarr

import android.app.role.RoleManager
import android.content.Context
import android.content.Intent
import android.os.Build
import android.provider.Telephony
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "movarr.channel"
    private val MAKE_DEFAULT_APP_REQUEST = 1
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call,
                result ->
            when {
                call.method.equals("isDefaultMessagingApp") -> {
                    val isDefault: Boolean = isDefaultMessagingApp()
                    result.success(isDefault)
                }
                call.method.equals("requestForDefaultMessagingApp") -> {
                    requestForDefaultMessagingApp()
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun requestForDefaultMessagingApp()  {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
              
                val roleManager = getSystemService(Context.ROLE_SERVICE) as RoleManager

                val intent = roleManager.createRequestRoleIntent(RoleManager.ROLE_SMS)

                startActivityForResult(intent, MAKE_DEFAULT_APP_REQUEST)
             }

        else {
                val intent = Intent(Telephony.Sms.Intents.ACTION_CHANGE_DEFAULT)

                intent.putExtra(Telephony.Sms.Intents.EXTRA_PACKAGE_NAME, packageName)

                startActivityForResult(intent, MAKE_DEFAULT_APP_REQUEST)       
            }
    }
    
    private fun isDefaultMessagingApp(): Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val roleManager = getSystemService(Context.ROLE_SERVICE) as RoleManager
            if (roleManager.isRoleHeld(RoleManager.ROLE_SMS)) {
                return true
            } else {
                return false
            }
        } else {
            if (Telephony.Sms.getDefaultSmsPackage(this) == packageName) {
                return true
            } else {
                return false
            }
        }
    }
}

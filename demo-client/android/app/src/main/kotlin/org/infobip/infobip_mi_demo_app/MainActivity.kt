package org.infobip.infobip_mi_demo_app

import android.os.Build.VERSION_CODES
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// Required 26 > Android version for low level methods from ConnectivityManager
@RequiresApi(VERSION_CODES.O)
class MainActivity : FlutterActivity() {

    private val networkManager: NetworkManager = NetworkManager()
    private val CHANNEL = "infobip.mi.demo/network"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "switchToCellular" -> networkManager.switchToCellularNetwork(context, result)
                "resetToDefaultNetwork" -> networkManager.resetToDefaultNetwork(context, result)
                else -> result.notImplemented()
            }
        }
    }
}

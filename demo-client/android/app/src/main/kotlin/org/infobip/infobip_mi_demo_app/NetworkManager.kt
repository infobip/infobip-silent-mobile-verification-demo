package org.infobip.infobip_mi_demo_app

import android.content.Context
import android.net.ConnectivityManager
import android.net.ConnectivityManager.NetworkCallback
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.plugin.common.MethodChannel

@RequiresApi(Build.VERSION_CODES.O)
class NetworkManager {

    private val TAG = "MainActivity"

    fun switchToCellularNetwork(context: Context, result: MethodChannel.Result) {
        val connectivityManager =
            context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val cellularNetworkCallBack = createNetworkCallback(connectivityManager, result)
        val request = NetworkRequest.Builder().run {
            addTransportType(NetworkCapabilities.TRANSPORT_CELLULAR)
            addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            build()
        }

        connectivityManager.requestNetwork(
            request,
            cellularNetworkCallBack,
            5000
        )
    }

    fun resetToDefaultNetwork(context: Context, result: MethodChannel.Result) {
        val connectivityManager =
            context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val isSuccessful = connectivityManager.bindProcessToNetwork(null)
        result.success(isSuccessful)
    }

    private fun createNetworkCallback(
        connectivityManager: ConnectivityManager,
        result: MethodChannel.Result
    ): NetworkCallback {
        return object : NetworkCallback() {
            override fun onAvailable(network: Network) {
                val isSuccessful = connectivityManager.bindProcessToNetwork(network)
                if (isSuccessful) result.success("SUCCESS")
                else result.success("ERROR")
            }

            override fun onUnavailable() {
                super.onUnavailable()
                result.success("CELLULAR_UNAVAILABLE")
            }
        }
    }
}
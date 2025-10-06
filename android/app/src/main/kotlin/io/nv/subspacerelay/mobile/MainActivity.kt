package io.nv.subspacerelay.mobile

import android.content.ComponentName
import android.content.Intent
import android.content.ServiceConnection
import android.content.pm.PackageManager
import android.nfc.NfcAdapter
import android.nfc.cardemulation.CardEmulation
import android.os.Bundle
import android.os.IBinder
import android.os.Message
import android.os.Messenger
import android.os.RemoteException
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

var eventSink: EventChannel.EventSink? = null

class MainActivity : FlutterActivity() {
    private val HCE_CHANNEL = "io.nv.subspacerelay.mobile/hce"

    private var apduServiceMessenger: Messenger? = null

    private val cardEmulation by lazy {
        if (packageManager.hasSystemFeature(PackageManager.FEATURE_NFC_HOST_CARD_EMULATION)) {
            NfcAdapter.getDefaultAdapter(this)?.let {
                CardEmulation.getInstance(it)
            }
        } else {
            null
        }
    }

    private val connection = object : ServiceConnection {
        override fun onServiceConnected(componentName: ComponentName, service: IBinder) {
            val messenger = Messenger(service)
            apduServiceMessenger = messenger
        }

        override fun onServiceDisconnected(componentName: ComponentName) {
            apduServiceMessenger = null
        }
    }

    override fun onStart() {
        super.onStart()

        Intent(this, ApduService::class.java).also { intent ->
            bindService(intent, connection, BIND_AUTO_CREATE)
        }
    }

    override fun onStop() {
        super.onStop()
        unbindService(connection)
        apduServiceMessenger = null
    }

    override fun onResume() {
        super.onResume()
        cardEmulation?.setPreferredService(this, ComponentName(this, ApduService::class.java));
    }

    override fun onPause() {
        super.onPause()
        cardEmulation?.unsetPreferredService(this)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messageChannel = EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "io.nv.subspacerelay.mobile/hce/capdu"
        )
        messageChannel.setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                }
            }
        )

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            HCE_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "sendResponseApdu" -> {
                    // 1 is MSG_RESPONSE_APDU
                    val responseApdu: ByteArray? = call.argument("responseApdu")
                    val dataBundle = Bundle()
                    dataBundle.putByteArray("data", responseApdu)

                    val responseMsg: Message = Message.obtain(null, 1)
                    responseMsg.data = dataBundle
                    try {
                        apduServiceMessenger?.also {
                            it.send(responseMsg)
                            result.success(true)
                        } ?: result.success(false)
                    } catch (e: RemoteException) {
                        // Do something with the failed message
                        result.error("hce_exception", e.message, "")
                    }
                }

                "removeAidsForService" -> {
                    val component = ComponentName(this@MainActivity, ApduService::class.java)
                    val res =
                        cardEmulation?.removeAidsForService(component, CardEmulation.CATEGORY_OTHER)
                    result.success(res)
                }

                "registerAidsForService" -> {
                    val component = ComponentName(this@MainActivity, ApduService::class.java)
                    val res = cardEmulation?.registerAidsForService(
                        component,
                        CardEmulation.CATEGORY_OTHER,
                        call.argument("aids")
                    )
                    result.success(res)
                }

                "supportsAidPrefixRegistration" -> {
                    val res = cardEmulation?.supportsAidPrefixRegistration()
                    result.success(res)
                }
            }
        }
    }
}

package io.nv.subspacerelay.mobile

import android.nfc.cardemulation.HostApduService
import android.os.Binder
import android.os.Bundle
import io.flutter.plugin.common.EventChannel

class ApduService : HostApduService() {
    override fun processCommandApdu(cApdu: ByteArray, extras: Bundle?): ByteArray? {
        eventSink?.also { it.success(cApdu) } ?: notifyUnhandled()

        return null
    }

    override fun onDeactivated(reason: Int) {
        // send null to signal deactivation
        eventSink?.success(null)
    }
}

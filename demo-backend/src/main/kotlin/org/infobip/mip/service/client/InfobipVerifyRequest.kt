package org.infobip.mip.service.client

data class InfobipVerifyRequest(
    val consentGranted: Boolean,
    val phoneNumber: String,
    val callbackUrl: String,
    val deviceIp: String? = null,
    val devicePort: Int? = null,
    val returnUrl: String? = null
)

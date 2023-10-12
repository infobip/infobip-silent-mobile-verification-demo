package org.infobip.mip.api.models

data class ClientVerifyResponse(
    val token: String,
    val deviceRedirectUrl: String?
)

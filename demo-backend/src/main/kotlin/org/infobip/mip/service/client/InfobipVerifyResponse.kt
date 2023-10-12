package org.infobip.mip.service.client

import org.infobip.mip.service.client.error.MobileIdentityError

class InfobipVerifyResponse(
    val status: Status,
    val token: String,
    val deviceRedirectUrl: String?,
    val error: MobileIdentityError?,
) {
    enum class Status {
        OK, REDIRECT, ERROR
    }
}

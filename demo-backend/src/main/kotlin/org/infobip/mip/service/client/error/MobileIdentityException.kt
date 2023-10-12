package org.infobip.mip.service.client.error

import org.infobip.mip.service.client.InfobipVerifyResponse

sealed class MobileIdentityException : RuntimeException() {
    class Unauthorized : MobileIdentityException()
    data class BadRequest(val errorResponse: InfobipVerifyResponse) : MobileIdentityException()
}

package org.infobip.mip.service

import org.infobip.mip.api.models.VerifyStatus
import org.infobip.mip.service.client.error.MobileIdentityError

data class VerifyResult(
    val result: VerifyStatus?,
    val token: String,
    val error: MobileIdentityError?,
)

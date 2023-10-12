package org.infobip.mip.api.models

import jakarta.validation.constraints.NotBlank
import org.infobip.mip.service.client.error.MobileIdentityError

data class CallbackRequest(
    val result: VerifyStatus?,
    @field:NotBlank val token: String,
    val error: MobileIdentityError?,
)

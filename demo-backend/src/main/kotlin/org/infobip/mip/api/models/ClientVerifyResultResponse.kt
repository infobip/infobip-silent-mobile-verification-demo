package org.infobip.mip.api.models

data class ClientVerifyResultResponse(
    val errorDescription: String? = null,
    val token: String? = null,
    val result: VerifyStatus? = null,
)

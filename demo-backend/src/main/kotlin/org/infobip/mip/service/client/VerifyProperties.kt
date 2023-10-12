package org.infobip.mip.service.client

import org.springframework.boot.context.properties.ConfigurationProperties

@ConfigurationProperties(prefix = "verify")
data class VerifyProperties(
    val zombieRequestsCheckRate: String,
    val callbackEndpoint: String,
    val usingProxy: Boolean
)

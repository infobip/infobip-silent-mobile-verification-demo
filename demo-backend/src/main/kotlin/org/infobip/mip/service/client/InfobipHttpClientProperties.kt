package org.infobip.mip.service.client

import org.springframework.boot.context.properties.ConfigurationProperties
import java.time.Duration

@ConfigurationProperties(prefix = "infobip-http-client")
data class InfobipHttpClientProperties(
    val timeout: Duration,
    val infobipBaseUrl: String,
    val authorization: String,
)

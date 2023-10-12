package org.infobip.mip.service.client

import org.springframework.http.HttpHeaders
import org.springframework.http.HttpMethod
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Service
import org.springframework.web.reactive.function.client.WebClient
import java.nio.charset.StandardCharsets
import java.time.ZonedDateTime

@Service
class InfobipHttpClient(
    val infobipHttpClientProperties: InfobipHttpClientProperties
) {
    final inline fun <reified T : Any> sendRequest(httpMethod: HttpMethod, endpoint: String, body: Any): T {
        val client: WebClient = WebClient.create()

        val response: ResponseEntity<T> = client.method(httpMethod)
            .uri(infobipHttpClientProperties.infobipBaseUrl + endpoint)
            .bodyValue(body)
            .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
            .header(HttpHeaders.AUTHORIZATION, infobipHttpClientProperties.authorization)
            .accept(MediaType.APPLICATION_JSON)
            .acceptCharset(StandardCharsets.UTF_8)
            .ifNoneMatch("*")
            .ifModifiedSince(ZonedDateTime.now())
            .retrieve()
            .toEntity(T::class.java)
            .timeout(infobipHttpClientProperties.timeout)
            .block()!!

        return response.body!!
    }
}

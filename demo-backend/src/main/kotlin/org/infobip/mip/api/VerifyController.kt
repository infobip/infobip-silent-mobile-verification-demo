package org.infobip.mip.api

import jakarta.servlet.http.HttpServletRequest
import jakarta.validation.Valid
import org.infobip.mip.api.models.CallbackRequest
import org.infobip.mip.api.models.ClientVerifyResponse
import org.infobip.mip.api.models.ClientVerifyResultResponse
import org.infobip.mip.service.VerifyService
import org.infobip.mip.service.client.VerifyProperties
import org.infobip.mip.utils.resolveIpAddress
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType.APPLICATION_JSON_VALUE
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

private val log = LoggerFactory.getLogger(VerifyController::class.java)

@RestController
@RequestMapping("/verify")
class VerifyController(
    private val verifyService: VerifyService,
    private val verifyProperties: VerifyProperties
) {
    @GetMapping("/{msisdn}")
    fun verify(@PathVariable msisdn: String, request: HttpServletRequest): ResponseEntity<Any> {
        log.trace(
            "Got verify request:\n" +
                    "X-Forwarded-For: ${request.getHeader("X-Forwarded-For")}\n" +
                    "X-Forwarded-Port: ${request.getHeader("X-Forwarded-Port")}\n" +
                    "RemoteAddr: ${request.remoteAddr}\n" +
                    "RemotePort: ${request.remotePort}\n"
        )

        val deviceIpAddress = resolveIpAddress(request, verifyProperties.usingProxy)

        val response = verifyService.sendVerifyRequest(msisdn, deviceIpAddress.address, deviceIpAddress.port)

        log.trace("Got verify response: \n {}", response)

        return ResponseEntity.ok(ClientVerifyResponse(response.token, response.deviceRedirectUrl))
    }

    @GetMapping("/result/{token}")
    fun checkToken(@PathVariable token: String): ResponseEntity<ClientVerifyResultResponse?> {
        log.trace("Checking verify result by token: $token\n")

        val verifyResult = verifyService.checkForVerifyResult(token) ?: return ResponseEntity.status(HttpStatus.NO_CONTENT).build()

        return ResponseEntity.ok(
            ClientVerifyResultResponse(
                verifyResult.error?.description,
                verifyResult.token,
                verifyResult.result
            )
        )
    }

    @PostMapping("/callback", consumes = [APPLICATION_JSON_VALUE])
    fun callback(
        @Valid @RequestBody callbackRequest: CallbackRequest,
    ): ResponseEntity<Void> {
        log.trace("Got verify result on callback: {}\n", callbackRequest)

        verifyService.resolveVerifyCallback(
            callbackRequest.token,
            callbackRequest.result,
            callbackRequest.error
        )
        return ResponseEntity.ok().build()
    }
}

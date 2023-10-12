package org.infobip.mip.api

import jakarta.servlet.http.HttpServletRequest
import org.infobip.mip.service.client.VerifyProperties
import org.infobip.mip.utils.IpAddress
import org.infobip.mip.utils.resolveIpAddress
import org.slf4j.LoggerFactory
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

private val log = LoggerFactory.getLogger(InfoController::class.java)

@RestController
class InfoController(
    private val verifyProperties: VerifyProperties
) {
    @GetMapping("/device-address")
    fun deviceAddress(request: HttpServletRequest): ResponseEntity<IpAddress> {
        log.trace(
            "Fetching device address:\n" +
                    "X-Forwarded-For: ${request.getHeader("X-Forwarded-For")}\n" +
                    "X-Forwarded-Port: ${request.getHeader("X-Forwarded-Port")}\n" +
                    "RemoteAddr: ${request.remoteAddr}\n" +
                    "RemotePort: ${request.remotePort}\n"
        )
        return ResponseEntity.ok(resolveIpAddress(request, verifyProperties.usingProxy))
    }
}
package org.infobip.mip.api

import org.infobip.mip.api.models.ClientVerifyResultResponse
import org.infobip.mip.service.client.error.MobileIdentityException
import org.springframework.core.Ordered
import org.springframework.core.annotation.Order
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.RestControllerAdvice

@RestControllerAdvice
@Order(Ordered.HIGHEST_PRECEDENCE)
class VerifyExceptionHandler {
    @ExceptionHandler
    fun invalidApiKey(exception: MobileIdentityException.Unauthorized): ResponseEntity<ClientVerifyResultResponse> {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(ClientVerifyResultResponse("Something went wrong"))
    }

    @ExceptionHandler
    fun badRequest(exception: MobileIdentityException.BadRequest): ResponseEntity<ClientVerifyResultResponse> {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
            ClientVerifyResultResponse(
                "Something went wrong",
                exception.errorResponse.token
            )
        )
    }
}

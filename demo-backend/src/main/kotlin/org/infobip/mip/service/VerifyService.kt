package org.infobip.mip.service

import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import com.fasterxml.jackson.module.kotlin.readValue
import org.infobip.mip.api.models.VerifyStatus
import org.infobip.mip.service.client.InfobipHttpClient
import org.infobip.mip.service.client.InfobipVerifyRequest
import org.infobip.mip.service.client.InfobipVerifyResponse
import org.infobip.mip.service.client.VerifyProperties
import org.infobip.mip.service.client.error.MobileIdentityError
import org.infobip.mip.service.client.error.MobileIdentityException
import org.infobip.mip.utils.TokenManagerService
import org.slf4j.LoggerFactory
import org.springframework.http.HttpMethod
import org.springframework.stereotype.Service
import org.springframework.web.reactive.function.client.WebClientResponseException

private val log = LoggerFactory.getLogger(VerifyService::class.java)

@Service
class VerifyService(
    private val infobipHttpClient: InfobipHttpClient,
    private val tokenManagerService: TokenManagerService,
    private val verifyProperties: VerifyProperties,
    private val mapper: ObjectMapper = jacksonObjectMapper()
) {
    fun sendVerifyRequest(msisdn: String, deviceIp: String, devicePort: Int): InfobipVerifyResponse {
        val infobipVerifyRequest = InfobipVerifyRequest(true, msisdn, verifyProperties.callbackEndpoint, deviceIp, devicePort)
        val response: InfobipVerifyResponse

        try {
            response = infobipHttpClient.sendRequest<InfobipVerifyResponse>(HttpMethod.POST, VERIFY_ENDPOINT, infobipVerifyRequest)
        } catch (unauthorized: WebClientResponseException.Unauthorized) {
            log.error("Send verify request failed with Unauthorized: $unauthorized")
            throw MobileIdentityException.Unauthorized()
        } catch (badRequest: WebClientResponseException.BadRequest) {
            val badRequestResponse = mapper.readValue<InfobipVerifyResponse>(badRequest.responseBodyAsString)
            log.error("Send verify request failed with BadRequest: ${badRequestResponse.error!!.description}")
            throw MobileIdentityException.BadRequest(badRequestResponse)
        } catch (exception: Exception) {
            log.error("Send verify request failed: $exception")
            throw exception
        }

        if (response.status == InfobipVerifyResponse.Status.ERROR) {
            log.error("Verify request responded with error status: ${response.error!!.description}")
            throw MobileIdentityException.BadRequest(response)
        }

        return response
    }

    fun checkForVerifyResult(token: String): VerifyResult? {
        tokenManagerService.getVerifyResultByToken(token)?.let { result ->
            tokenManagerService.removeVerifyResultEntry(token)
            return result
        }
        return null
    }

    fun resolveVerifyCallback(token: String, verifyStatus: VerifyStatus?, error: MobileIdentityError?) =
        tokenManagerService.insertVerifyResult(token, VerifyResult(verifyStatus, token, error))

    companion object {
        const val VERIFY_ENDPOINT = "/mi/verification/1/verify"
    }
}

package org.infobip.mip.utils

import org.infobip.mip.service.VerifyResult
import org.slf4j.LoggerFactory
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Service

private val log = LoggerFactory.getLogger(TokenManagerService::class.java)

@Service
class TokenManagerService {
    private val verifyResultByToken = mutableMapOf<String, VerifyResult>()
    private var previousTokens = setOf<String>()

    fun insertVerifyResult(token: String, verifyResult: VerifyResult) {
        synchronized(token.intern()) {
            verifyResultByToken.putIfAbsent(token, verifyResult)
        }
    }

    fun getVerifyResultByToken(token: String): VerifyResult? = verifyResultByToken[token]

    fun removeVerifyResultEntry(token: String) = verifyResultByToken.remove(token)

    @Scheduled(cron = "\${verify.zombie-requests-check-rate}")
    fun removeZombieTokens() {
        val currentTokens = verifyResultByToken.keys.toSet()
        previousTokens.intersect(currentTokens).forEach {
            removeVerifyResultEntry(it)
            log.error("Token was not resolved and remained in memory. Token: $it")
        }
        previousTokens = currentTokens
    }
}

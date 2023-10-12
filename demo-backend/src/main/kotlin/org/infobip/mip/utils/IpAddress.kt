package org.infobip.mip.utils

import jakarta.servlet.http.HttpServletRequest
import org.slf4j.LoggerFactory
import java.net.Inet6Address
import java.net.InetAddress
import java.util.regex.Matcher
import java.util.regex.Pattern

private val log = LoggerFactory.getLogger(IpAddress::class.java)

private val forwardedForPattern: Pattern = Pattern.compile("^[^, ]+")

data class IpAddress(val address: String, val port: Int)

fun resolveIpAddress(request: HttpServletRequest, usingProxy: Boolean): IpAddress {
    return if (usingProxy) {
        resolveIpAddress(request.getHeader("X-Forwarded-For")!!, request.getHeader("X-Forwarded-Port")?.toInt())
    } else {
        IpAddress(request.remoteAddr, request.remotePort)
    }
}

fun resolveIpAddress(forwardedForAddress: String, forwardedForPort: Int?): IpAddress {
    if (isIPv6(forwardedForAddress)) {
        return resolveIpv6Address(forwardedForAddress, forwardedForPort)
    }
    return resolveIpv4Address(forwardedForAddress, forwardedForPort)
}

private fun isIPv6(ipAddress: String): Boolean {
    if (ipAddress.startsWith("[")) {
        return true
    }
    return try {
        val inetAddress = InetAddress.getByName(ipAddress)
        inetAddress is Inet6Address
    } catch (e: Exception) {
        log.error("Error while checking if address is IPv6", e)
        false
    }
}

private fun resolveIpv6Address(forwardedForAddress: String, forwardedForPort: Int?): IpAddress {
    if (forwardedForAddress.startsWith("[")) {
        return resolveProxiedIpv6Address(forwardedForAddress, forwardedForPort)
    }
    return IpAddress(forwardedForAddress, forwardedForPort ?: 0)
}

private fun resolveProxiedIpv6Address(forwardedForAddress: String, forwardedForPort: Int?): IpAddress {
    val endingBracketIndex: Int = forwardedForAddress.indexOf(']')
    val ipAddress: String = forwardedForAddress.substring(1, endingBracketIndex)
    return if (isIPv6(ipAddress)) {
        var port = forwardedForPort ?: 0
        if (forwardedForAddress[endingBracketIndex + 1] == ':') {
            port = forwardedForAddress.substring(endingBracketIndex + 2).toInt()
        }
        IpAddress(ipAddress, port)
    } else {
        log.error("Error while resolving proxied IPv6")
        throw Exception("Error while resolving proxied IPv6")
    }
}

private fun resolveIpv4Address(
    forwardedForAddress: String,
    forwardedForPort: Int?
): IpAddress {
    val addressMatcher: Matcher = forwardedForPattern.matcher(forwardedForAddress)
    addressMatcher.find()
    val address: String = addressMatcher.group()
    val addressParts = address.split(":").toTypedArray()

    val port: Int = if (addressParts.size > 1) {
        addressParts[1].toInt()
    } else if (forwardedForPort != null) {
        val portMatcher: Matcher = forwardedForPattern.matcher(forwardedForPort.toString())
        portMatcher.find()
        portMatcher.group().toInt()
    } else {
        0
    }

    return IpAddress(addressParts[0], port)
}
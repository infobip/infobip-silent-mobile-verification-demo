# Silent Mobile Verification Demo

This is a [Silent mobile verification](https://www.infobip.com/docs/mobile-identity/services/#silent) implementation demonstration meant to ease client integration process. It consists of two modules: enterprise backend and an end-user client. Additional information can be found on our <a href="https://github.com/infobip/infobip-silent-mobile-verification-demo/wiki" target="_blank">Wiki</a>.
Published under [Apache 2.0 license](LICENSE).

## Requirements
The following requirements need to be installed and available in your `$PATH`

### For backend module:
* JDK 19 or above
* [Apache Maven](https://maven.apache.org/download.cgi)

### For client module:
* Flutter 3.19.0 or above
* 26 (Android 8.0) - 30 (Android 13.0) API level to run on an Android device

### Dependencies setup

    $ git clone git@github.com:infobip/infobip-silent-mobile-verification-demo
    $ cd infobip-silent-mobile-verification-demo/demo-backend
    $ mvn install
    $ cd ../demo-client
    $ flutter pub get

## Quick start guide

### Note
iOS part of the demo application is currently not fully developed and will be available soon. Application can be built, but it will not work as expected.

### Initialize the application
#### Get API key and base URL
The application uses the [API Key Header](https://www.infobip.com/docs/essentials/api-authentication#api-key-header) authentication method to communicate with the Infobip's Mobile Identity services. Note that there are other authentication methods available too (see [the official documentation](https://www.infobip.com/docs/essentials/api-authentication)).
Once you have an [Infobip account](https://www.infobip.com/signup), you can manage your API keys through the Infobip [API key management page](https://portal.infobip.com/settings/accounts/api-keys).
To see your base URL, log in to the [Infobip API Resource](https://www.infobip.com/docs/api) hub with your Infobip credentials or visit your [Infobip account](https://portal.infobip.com/homepage/).

#### Publicly expose backend service callback endpoint
Backend service application needs to have a publicly available callback endpoint so that Infobip is able to reach it. In this demo, the callback endpoint is set on `/verify/callback`.

#### Set backend service application properties
With this information, properties in `infobip-silent-mobile-verification-demo/demo-backend/src/main/resources/application.yml` should be changed as follows:
* append `App ` string with the API key as the `infobip-http-client.authorization` property
* base URL as the `infobip-http-client.infobip-base-url` property
* publicly exposed callback endpoint URL as the `verify.callback-endpoint` property
* set the `using-proxy` property to `true` if there is a proxy between the end-user client and the backend service communication

#### Set end-user client application properties
On the end-user client, `backendApiBaseUrl` property in `infobip-silent-mobile-verification-demo/demo-client/lib/config/app_config.dart` should be set to a URL of the backend service that is accessible by the end-user client (if having problems with this see <a href="https://github.com/infobip/infobip-silent-mobile-verification-demo/wiki/Why-the-end-user-client-can-not-access-the-backend-service%3F" target="_blank">Why the end-user client can not access the backend service?</a>).

### Run the backend application

    $ cd infobip-silent-mobile-verification-demo/demo-backend
    $ mvn spring-boot:run

### Run the end-user client

Start a device emulator or connect a physical device, then do the following:

    $ cd infobip-silent-mobile-verification-demo/demo-client
    $ flutter run
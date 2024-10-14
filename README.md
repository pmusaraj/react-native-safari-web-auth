# react-native-safari-web-auth

Login authentication for iOS 13+ using [ASWebAuthenticationSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession).

## Getting started

`$ yarn add react-native-safari-web-auth`

`$ pod install` (in the ios folder)

## Usage

Since version 2.0.0, the library uses promises (previously, it used custom URL schemes in the app) to handle callbacks.

Example:

```javascript
import SafariWebAuth from "react-native-safari-web-auth";
import { Platform } from "react-native";

async function handleAuthentication() {
  if (Platform.OS === "ios") {
    try {
      const authRequest = await SafariWebAuth.requestAuth(
        "AUTH_URL",
        "urlScheme", // use a custom scheme that will be returned to the RN app via the callback.
        true
        // the third parameter sets the prefersEphemeralWebBrowserSession variable in ASWebAuthenticationSession,
        // when true, it skips iOS dialog prompt but uses incognito mode (i.e. user always has to log in)
      );

      if (authRequest) {
        console.log(authRequest);
        // decode (if necessary) and then use the URL in your app
      }
    } catch (error) {
      console.error(error);
    }
  }
}
```

# react-native-safari-web-auth

Login authentication bridge for iOS 13+ using [ASWebAuthenticationSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession).

## Getting started

`$ yarn add react-native-safari-web-auth`

`$ pod install` (in the ios folder)

## Usage

```javascript
import SafariWebAuth from "react-native-safari-web-auth";
import { Platform } from "react-native";

if (Platform.OS === "ios") {
  SafariWebAuth.requestAuth("https://your.site.com/auth", "customurlscheme");
}
```

Should be used in conjunction with a custom URL scheme for your app that handles the login callback.

# react-native-safari-web-auth

One-time login authentication for iOS 12+ only, using [ASWebAuthentication](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession).

## Getting started

`$ npm install react-native-safari-web-auth --save`

### Installation

`$ react-native link react-native-safari-web-auth`

## Usage

```javascript
import SafariWebAuth from "react-native-safari-web-auth";

if (Platform.OS !== "ios" && parseInt(Platform.Version, 10) >= 12) {
	SafariWebAuth.requestAuth(`https://your.site.com/auth`);
}
```

Should be used in conjunction with a custom URL scheme for your app that handles the login callback. 

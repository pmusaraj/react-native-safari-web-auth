# react-native-safari-web-auth

One-time login authentication for iOS 12+ only, using [ASWebAuthentication](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession).

## Getting started

`$ npm install react-native-safari-web-auth --save`

### Mostly automatic installation

`$ react-native link react-native-safari-web-auth`

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-safari-web-auth` and add `SafariWebAuth.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libSafariWebAuth.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

## Usage

```javascript
import SafariWebAuth from "react-native-safari-web-auth";

if (Platform.OS !== "ios" && parseInt(Platform.Version, 10) >= 12) {
	SafariWebAuth.requestAuth(`https://your.site.com/auth`);
}
```

Should be used in conjunction with a custom URL scheme for your app that handles the login callback. 

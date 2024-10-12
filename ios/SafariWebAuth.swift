import AuthenticationServices
import Foundation
import React

@objc(SafariWebAuth)
class SafariWebAuth: RCTEventEmitter, ASWebAuthenticationPresentationContextProviding {
  var webAuthSession: ASWebAuthenticationSession?

  override func supportedEvents() -> [String]? {
    return ["SafariWebAuth"]
  }

  func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
    return ASPresentationAnchor()
  }

  @objc(requestAuth:callbackURLScheme:)
  func requestAuth(url: String, callbackURLScheme: String) {
    guard let parsedUrl = URL(string: url) else {
      // TODO: reject/notify?
      return
    }

    self.webAuthSession = ASWebAuthenticationSession(
      url: parsedUrl,
      callbackURLScheme: callbackURLScheme,
      completionHandler: { (callbackURL: URL?, error: Error?) in
        if let error = error {
          let errorUrl = URL(string: "\(callbackURLScheme)://error?desc=\(error.localizedDescription)")
          UIApplication.shared.open(errorUrl!, options: [:], completionHandler: nil)
        } else if let callbackURL = callbackURL {
          UIApplication.shared.open(callbackURL, options: [:], completionHandler: nil)
        }
      })

    self.webAuthSession?.presentationContextProvider = self
    // webAuthSession?.prefersEphemeralWebBrowserSession = true
    self.webAuthSession?.start()
  }
}
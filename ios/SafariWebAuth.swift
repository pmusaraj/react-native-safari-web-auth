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

  @objc(requestAuth:callbackURLScheme:ephemeral:resolver:rejecter:)
  func requestAuth(url: String, callbackURLScheme: String, ephemeral: Bool, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    guard let parsedUrl = URL(string: url) else {
      reject("error", "Invalid URL.", nil)
      return
    }

    self.webAuthSession = ASWebAuthenticationSession(
      url: parsedUrl,
      callbackURLScheme: callbackURLScheme,
      completionHandler: { (callbackURL: URL?, error: Error?) in
        if let error = error {
          reject("error", error.localizedDescription, nil)
        } else if let callbackURL = callbackURL {
          resolve(callbackURL.absoluteString)
        }
      })

    self.webAuthSession?.presentationContextProvider = self
    self.webAuthSession?.prefersEphemeralWebBrowserSession = ephemeral
    self.webAuthSession?.start()
  }
}
import AuthenticationServices
import Foundation
import React

@objc(SafariWebAuth)
class SafariWebAuth: RCTEventEmitter, ASWebAuthenticationPresentationContextProviding {
  var webAuthSession: ASWebAuthenticationSession?
  var webAuthSessionID = 0

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

    self.webAuthSession?.cancel()
    self.webAuthSessionID += 1
    let sessionID = self.webAuthSessionID

    self.webAuthSession = ASWebAuthenticationSession(
      url: parsedUrl,
      callbackURLScheme: callbackURLScheme,
      completionHandler: { [weak self] (callbackURL: URL?, error: Error?) in
        if self?.webAuthSessionID == sessionID {
          self?.webAuthSession = nil
        }

        if let error = error {
          reject("error", error.localizedDescription, nil)
        } else if let callbackURL = callbackURL {
          resolve(callbackURL.absoluteString)
        } else {
          reject("error", "Authentication completed without a callback URL.", nil)
        }
      })

    self.webAuthSession?.presentationContextProvider = self
    self.webAuthSession?.prefersEphemeralWebBrowserSession = ephemeral
    if self.webAuthSession?.start() != true {
      self.webAuthSession = nil
      reject("error", "Failed to start authentication session.", nil)
    }
  }
}

//
//  SafariWebAuth.swift
//  SafariWebAuth
//
//

import Foundation
import AuthenticationServices

@objc(SafariWebAuth)
@available(iOS 12.0, *)
class SafariWebAuth: NSObject {
    var webAuth: ASWebAuthenticationSession?
    
    @objc func requestAuth(_ authUrl: String) -> Void {
        
        let oauthUrl = URL(string: authUrl)
        
        self.webAuth = ASWebAuthenticationSession.init(url: oauthUrl!, callbackURLScheme: "", completionHandler: { (callBack:URL?, error:Error?) in
            guard error == nil, let successURL = callBack else {print ("canceled"); return}
            
            if UIApplication.shared.canOpenURL(successURL) {
                UIApplication.shared.open(successURL, options: [:], completionHandler: nil)
            }
        })
        self.webAuth?.start()
        
    }
}

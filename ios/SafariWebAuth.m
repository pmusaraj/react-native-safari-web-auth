#import "SafariWebAuth.h"
#import <React/RCTUtils.h>
#import <React/RCTLog.h>
#import <AuthenticationServices/ASWebAuthenticationSession.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpartial-availability"
ASWebAuthenticationSession *_authenticationVC;
#pragma clang diagnostic pop

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
#import <AuthenticationServices/AuthenticationServices.h>
@interface SafariWebAuth() <ASWebAuthenticationPresentationContextProviding>
@end
#endif

@implementation SafariWebAuth

RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(requestAuth:(NSURL *)requestURL
                     resolver:(RCTPromiseResolveBlock)resolve
                     rejecter:(RCTPromiseRejectBlock)reject)
{
    if (!requestURL) {
        RCTLogError(@"[SafariWebAuth] You must specify a url.");
        return;
    }
    
    if (@available(iOS 12.0, *)) {
        ASWebAuthenticationSession* authenticationVC =
        [[ASWebAuthenticationSession alloc] initWithURL:requestURL
                                      callbackURLScheme: @""
                                      completionHandler:^(NSURL * _Nullable callbackURL,
                                                          NSError * _Nullable error) {
            _authenticationVC = nil;

            if (callbackURL) {
                NSLog(@"[SafariWebAuth] Auth success, callbackURL = %@", callbackURL);
                resolve([callbackURL absoluteString]);
                [RCTSharedApplication() openURL:callbackURL];
            } else {
                NSLog(@"[SafariWebAuth] Auth failure, error = %@", error);
                reject(@"requestAuth", @"Auth failed", error);
            }
        }];

        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
        if (@available(iOS 13.0, *)) {
            authenticationVC.presentationContextProvider = self;
        }
        #endif

        _authenticationVC = authenticationVC;

        [authenticationVC start];
    }
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
#pragma mark - ASWebAuthenticationPresentationContextProviding

- (ASPresentationAnchor)presentationAnchorForWebAuthenticationSession:(ASWebAuthenticationSession *)session  API_AVAILABLE(ios(13.0)){
   return UIApplication.sharedApplication.keyWindow;
}
#endif

@end

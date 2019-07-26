#import "SafariWebAuth.h"
#import <React/RCTUtils.h>
#import <React/RCTLog.h>
#import <AuthenticationServices/ASWebAuthenticationSession.h>

ASWebAuthenticationSession *_authenticationVC;

@implementation SafariWebAuth

RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(requestAuth:(NSURL *)requestURL)
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
                [RCTSharedApplication() openURL:callbackURL];
            }
        }];

        // New in iOS 13
        if (@available(iOS 13.0, *)) {
            authenticationVC.presentationContextProvider = self;
        }

        _authenticationVC = authenticationVC;

        [authenticationVC start];
    }
}

#pragma mark - ASWebAuthenticationPresentationContextProviding

- (ASPresentationAnchor)presentationAnchorForWebAuthenticationSession:(ASWebAuthenticationSession *)session  API_AVAILABLE(ios(13.0)){
   return UIApplication.sharedApplication.keyWindow;
}

@end

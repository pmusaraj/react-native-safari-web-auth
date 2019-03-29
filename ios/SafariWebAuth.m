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
            } else {
                RCTLogError(@"[SafariWebAuth] Could not load URL.");
            }
        }];

        _authenticationVC = authenticationVC;
        [authenticationVC start];
    }
}

@end

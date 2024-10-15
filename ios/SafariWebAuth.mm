#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(SafariWebAuth, NSObject)

RCT_EXTERN_METHOD(requestAuth:
  (NSString *)url
  callbackURLScheme:(NSString *)callbackURLScheme
  ephemeral:(BOOL *)ephemeral
  resolver:(RCTPromiseResolveBlock)resolve
  rejecter:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

@end

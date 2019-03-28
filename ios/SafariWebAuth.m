
#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(SafariWebAuth, NSObject)

RCT_EXTERN_METHOD(requestAuth:(NSString *)authUrl)

@end

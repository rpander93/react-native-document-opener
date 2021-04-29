#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(DocumentOpener, NSObject)

RCT_EXTERN_METHOD(openAsync:(NSString *)filePath
                  mimeType:(NSString *)mimeType
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(presentOptionsAsync:(NSString *)filePath
                  mimeType:(NSString *)mimeType
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
    return NO;
}

@end

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "IpaynowPluginApi.h"
#import "IpaynowPluginDelegate.h"
#import "IPNDESUtil.h"
#import "NowPayPlugin.h"
#import "PayManager.h"
#import "WechatAuthSDK.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "SwiftFintechClient.h"
#import "SwiftFintechClientConstEnum.h"
#import "SwiftFintechClientConstFintechConfig.h"
#import "SwiftFintechClientFintechStateModel.h"
#import "SwiftFintechClientType1ConfigModel.h"
#import "SwiftFintechClientType2ConfigModel.h"
#import "SwiftFintechClientType3ConfigModel.h"
#import "SwiftFintechToolSDK.h"

FOUNDATION_EXPORT double PaySDKVersionNumber;
FOUNDATION_EXPORT const unsigned char PaySDKVersionString[];


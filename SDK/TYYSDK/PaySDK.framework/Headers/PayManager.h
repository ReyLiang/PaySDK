//
//  PayManager.h
//
//  Created by Rey on 2018/8/22.
//  Copyright © 2018年 TYY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, NowPayResult) {
    NowPayResultFail           ,  //失败
    NowPayResultSuccess   ,  //成功
    NowPayResultCancel      ,  //取消
    NowPayResultUnknown     //未知
};


@protocol NowPluginDelegate <NSObject>

/**
 *  支付完成回调接收
 *
 *  @param result  支付状态
 *  @param errorCode 错误码
 *  @param errorInfo 错误信息
 */
- (void)iPaynowPluginResult:(NowPayResult)result errorCode:(NSString *)errorCode errorInfo:(NSString *)errorInfo;

@end

typedef void(^AlipayCompletionBlock)(NSDictionary *resultDic);

@interface PayManager : NSObject
///小程序支付
+ (BOOL) wechatAppPayWithAppid:(NSString *)appid
                      userName:(NSString *)userName
                          path:(NSString *)path;

+ (BOOL) alipayPayInterceptorWithUrl:(NSString *)urlStr
                          fromScheme:(NSString *)schemeStr
                            callback:(AlipayCompletionBlock)completionBlock;

+ (void) alipayPayOrder:(NSString *)orderStr
             fromScheme:(NSString *)schemeStr
               callback:(AlipayCompletionBlock)completionBlock;

+ (void) wftPay:(NSString *)tokenId
     fromScheme:(NSString *)schemeStr
       callback:(AlipayCompletionBlock)completionBlock;


+ (void) nowPay:(NSString *)payinfo
     fromScheme:(NSString *)schemeStr
 viewController:(UIViewController *)viewController
       delegate:(id<NowPluginDelegate>)delegate;

+ (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

+ (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation;

+ (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url;

+ (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options NS_AVAILABLE_IOS(9_0); // no equiv. notification. return NO if the application can't open for some reason
+ (void)willEnterForeground:(UIApplication *)app;
@end

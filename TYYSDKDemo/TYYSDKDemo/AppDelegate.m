//
//  AppDelegate.m
//  TYYSDKDemo
//
//  Created by Rey on 2018/8/24.
//  Copyright © 2018年 TYY. All rights reserved.
//

#import "AppDelegate.h"
#import <TYYSDK/TYYSDK-Swift.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    return [[TYYSDK share] application:application
         didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    ///支付使用(必须)
    [[TYYSDK share] applicationWillEnterForeground:application];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    ///支付使用(必须)
    return [[TYYSDK share] application:app open:url options:options];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    ///支付使用(必须)
    return [[TYYSDK share] application:application open:url sourceApplication:sourceApplication annotation:annotation];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    ///支付使用(选接)
    return [[TYYSDK share] application:application handleOpen:url];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    ///最好调用下(可选)
    [[TYYSDK share] logout];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}





- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}





@end

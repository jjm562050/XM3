//
//  AppDelegate.m
//  微内涵
//
//  Created by MAC22 on 15/10/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MMDrawerController.h"
#import "UMSocial.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //初始化友盟
    [UMSocialData setAppKey:@"551a5860fd98c513b60002f7"];
    
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    //中央视图
    MainTabBarController *mainTabbar = [[MainTabBarController alloc] init];
    //左边视图
    LeftViewController *left = [[LeftViewController alloc] init];
    //右边视图
    RightViewController *right = [[RightViewController alloc] init];
    
    MMDrawerController *drawer = [[MMDrawerController alloc] initWithCenterViewController:mainTabbar leftDrawerViewController:left rightDrawerViewController:nil];
    
    //设置左右边的显示大小
    [drawer setMaximumLeftDrawerWidth:150];
    [drawer setMaximumRightDrawerWidth:200];
    
    //设置手势区域
    [drawer setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawer setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    self.window.rootViewController = drawer;
    
    
    //添加启动页面
    UIImageView *imgaeView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imgaeView.image = [UIImage imageNamed:@"1.png"];
    [drawer.view addSubview:imgaeView];
    
    [UIView animateWithDuration:0 animations:^{
        imgaeView.alpha = 1;
    }];

    
    //延迟1.5秒消失
    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        imgaeView.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];

    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

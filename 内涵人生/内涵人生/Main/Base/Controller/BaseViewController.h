//
//  BaseViewController.h
//  微内涵
//
//  Created by MAC22 on 15/10/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)ctreateButton;

//加载
- (void)showHud:(NSString *)title;
//结束加载
- (void)completeHUD:(NSString *)title;

@end

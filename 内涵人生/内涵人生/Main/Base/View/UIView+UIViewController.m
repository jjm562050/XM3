//
//  UIView+UIViewController.m
//  体育也疯狂
//
//  Created by MAC22 on 15/10/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)

- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    
    while(next != nil)
    {
        if([next isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
    }
    
    return nil;
    
}

@end

//
//  EnlargePicture.m
//  内涵人生
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 zhengyiqun. All rights reserved.
//

#import "EnlargePicture.h"

static CGRect oldframe;

@implementation EnlargePicture

+ (void)showImage:(UIImageView *)largeImageView
{
    UIImage *image = largeImageView.image;
    
    //获取窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    //创建背景视图
    UIView *backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    
    oldframe = [largeImageView convertRect:largeImageView.bounds toView:window];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag = 100;
    
    [backgroundView addSubview:imageView];
    
    [window addSubview:backgroundView];

    //创建手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImage:)];
    
    [backgroundView addGestureRecognizer: tap];

    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        
        
        backgroundView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}


+ (void)hideImage:(UITapGestureRecognizer*)tap
{
    UIView *backgroundView = tap.view;
    
    UIImageView *imageView = (UIImageView*)[tap.view viewWithTag:1];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame = oldframe;
        backgroundView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [backgroundView removeFromSuperview];
        
    }];
    
}


@end

//
//  MainTabBarController.m
//  微内涵
//
//  Created by MAC22 on 15/10/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"


@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.tabBar.backgroundImage = [UIImage imageNamed:@"changeShowTimeBg.png"];
    
    [self _createSubControllers];
    
    //[self _createTabbr];
}


//创建tabbar  一种方式
- (void)_createTabbr
{
    //1.获取UITabBarButton 并移除
    for (UIView *view in self.tabBar.subviews)
    {
        //通过字符串获取类
        Class class = NSClassFromString(@"UITabBarButton");
        
        if ([view isKindOfClass:class])
        {
            //移除
            [view removeFromSuperview];
        }
        
    }
    
    
    NSArray *tabbarNames = @[
                             @"tabbar_1",
                             @"tabbar_2",
                             @"tabbar_3",
                             @"tabbar_4"
                             ];
    
    NSArray *names = @[@"LOL视频",@"内涵图片",@"内涵视频",@"美女图片欣赏"];
    
    
    //开源中国
    //段错误  scgmengfont
    //栈益处
    //code4
    //github
    //cocochina
    
    //按钮的宽度
    CGFloat width = kScreenWidth / tabbarNames.count;
    
    for (int i = 0 ; i < tabbarNames.count ; i++)
    {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * width, 0, width, 49);
        
        button.tag = i;
        
        //图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((width - 30) / 2 , 0, 30, 30)];
        imageView.image = [UIImage imageNamed:tabbarNames[i]];
        
        [button addSubview:imageView];
        
        
        //文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 31, width, 18)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.text = names[i];
        [button addSubview:label];
        
        
        //按钮的方法
        [button addTarget:self action:@selector(tabBarAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:button];
        
    }
    
}



//加载子控制器
- (void)_createSubControllers
{
    
    NSArray *storyNames = @[@"LolVideo",@"Picture",@"IntentionVideo",@"AppreciatePicture"];
    
    NSMutableArray *viewsArray = [[NSMutableArray alloc] initWithCapacity:storyNames.count];
    
    for (int i = 0; i < storyNames.count; i++)
    {
        UIStoryboard *story = [UIStoryboard storyboardWithName:storyNames[i] bundle:[NSBundle mainBundle]];
        
        //获取控制器
        BaseNavigationController *baseNav = [story instantiateInitialViewController];
        
        [viewsArray addObject:baseNav];
    
    }
    
    self.viewControllers = viewsArray;
    
    NSArray *imageName = @[
                           @"tabbar_news@2x.png",
                           @"tabbar_picture@2x.png",
                           @"tabbar_video@2x.png",
                           @"tabbar_setting@2x.png"
                           ];
    
    NSArray *selectedImageNames = @[@"tabbar_news_hl@2x.png",
                                    @"tabbar_picture_hl@2x.png",
                                    @"tabbar_video_hl@2x.png",
                                    @"tabbar_setting_hl@2x.png"
                                    ];
    
    NSArray *names = @[@"LOL视频",@"内涵图片",@"内涵视频",@"个人信息"];

    
    UITabBar *tabbar = self.tabBar;
    for (int i = 0; i<names.count; i++)
    {
        UITabBarItem *tabbarItem = [tabbar.items objectAtIndex:i];
        //文字
        tabbarItem.title = names[i];
        
        //图片
        tabbarItem.image = [UIImage imageNamed:imageName[i]];
        
        //选中图片
        UIImage *selectedImage = [UIImage imageNamed:selectedImageNames[i]];
        tabbarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //选中字体
        UIColor *color = [UIColor colorWithRed:180 / 255.0 green:53 / 255.0 blue:55 /255.0 alpha:1];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : color} forState:UIControlStateSelected];
        
    }
    
}

#pragma mark - 按钮的方法
- (void)tabBarAction:(UIButton *)button
{
    self.selectedIndex = button.tag;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

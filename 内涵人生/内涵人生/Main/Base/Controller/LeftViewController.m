//
//  LeftViewController.m
//  微内涵
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "LeftViewController.h"
#import "PerformanceViewController.h"
#import "WallPaperViewController.h"
#import "MainTabBarController.h"
#import "UIViewController+MMDrawerController.h"


@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor *color = [UIColor colorWithRed:180 / 255.0 green:53 / 255.0 blue:55 /255.0 alpha:1];
    self.view.backgroundColor = color;
    
    [self createSubViews];
}

- (void)createSubViews
{
    NSArray *array = @[@"返回",@"壁纸",@"段子"];
    
    for (int i = 0; i<array.count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(25, 100 + 60 * i, 100, 60);
        
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:20];

        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = i;
        [self.view addSubview:button];
    }
    
    
}


#pragma mark - 按钮的方法
- (void)buttonAction:(UIButton *)btn
{
    if (btn.tag == 0)
    {
        MainTabBarController *lolVideo = [[MainTabBarController alloc] init];
        
        [self.mm_drawerController setCenterViewController:lolVideo withCloseAnimation:YES completion:nil];
        
    }
    else if (btn.tag == 1)
    {
        WallPaperViewController *wall = [[WallPaperViewController alloc] init];
        
        [self presentViewController:wall animated:YES completion:nil];
        
    }
    else
    {
        PerformanceViewController *per = [[PerformanceViewController alloc] init];
        
        [self presentViewController:per animated:YES completion:nil];
        
    }
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

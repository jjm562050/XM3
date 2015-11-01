//
//  BaseViewController.m
//  微内涵
//
//  Created by MAC22 on 15/10/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"

@interface BaseViewController ()
{
    MBProgressHUD *_hud;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


//设置导航栏的左右按钮
- (void)ctreateButton
{
    //左边
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 50, 50);
    
    [leftButton setImage:[UIImage imageNamed:@"navigationbar_menu_icon@2x.png"] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(leftButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
    
    //右边
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 50);
    
    [rightButton setImage:[UIImage imageNamed:@"navigationbar_more_normal@2x.png"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;

    
    
}


#pragma mark 导航栏按钮的方法
- (void)leftButton:(UIButton *)leftBtn
{
    MMDrawerController *drawer = self.mm_drawerController;
    
    [drawer openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)rightButton:(UIButton *)rightBtn
{
    MMDrawerController *drawer = self.mm_drawerController;
    
    [drawer openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
}


#warning 菊花
//加载
- (void)showHud:(NSString *)title
{
    if(_hud == nil)
    {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    }
    
    _hud.labelText = title;
    
    _hud.dimBackground = YES;
    
    [_hud show:YES];
    
    
}


//结束加载
- (void)completeHUD:(NSString *)title
{
    
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    _hud.mode = MBProgressHUDModeCustomView;
    
    _hud.labelText = title;
    
    //持续1.5隐藏
    [_hud hide:YES afterDelay:0.5];
    
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

//
//  CollectController.m
//  内涵人生
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 zhengyiqun. All rights reserved.
//

#import "CollectController.h"

@interface CollectController ()

@end

@implementation CollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收藏";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _createSubView];
    
}

- (void)_createSubView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 200) / 2, (kScreenHieght - 30 - 49) / 2, 200, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"暂无收藏";
    label.font = [UIFont systemFontOfSize:30];
    label.textColor = [UIColor grayColor];
    label.alpha = 0.5;
    
    [self.view addSubview:label];
    
    
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

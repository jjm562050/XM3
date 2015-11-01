//
//  WallPagerCell.h
//  内涵人生
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 zhengyiqun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WallPagerModel.h"
#import "UMSocial.h"

@interface WallPagerCell : UITableViewCell<UIAlertViewDelegate,UMSocialUIDelegate>

@property(nonatomic,strong) UIImageView *wallPager;

@property (nonatomic,strong) WallPagerModel *model;

@end

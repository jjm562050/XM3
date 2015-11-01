//
//  LolVideoCell.h
//  微内涵
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LolVideoModel.h"

@interface LolVideoCell : UITableViewCell
{
    //头像
    UIImageView *_imageView;
    //名称
    UILabel *_label;
    
}

@property (nonatomic,strong) LolVideoModel *model;

@end

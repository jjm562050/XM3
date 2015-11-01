//
//  DetailLolVideoCell.h
//  微内涵
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailLolVideoModel.h"

@interface DetailLolVideoCell : UITableViewCell
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_dateLabel;
    UILabel *_timeLabel;
    
}
@property (nonatomic,strong) DetailLolVideoModel *model;
@end

//
//  PictureCell.h
//  微内涵
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureModel.h"

@interface PictureCell : UITableViewCell
{
    UILabel *_wbodyLabel;
    
}

@property (nonatomic,strong) UIImageView *wpicImageView;

@property (nonatomic,strong) PictureModel *model;

@end

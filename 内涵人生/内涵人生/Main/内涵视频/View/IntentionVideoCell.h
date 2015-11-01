//
//  IntentionVideoCell.h
//  微内涵
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntentionVideoModel.h"

@interface IntentionVideoCell : UITableViewCell
{
    UIImageView *_imageView;
    UILabel *_contentLabel;
    UILabel *_likesLabel;
    
    
}
@property (nonatomic,strong) IntentionVideoModel *model;

@end

//
//  PerformanceCell.h
//  微内涵
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerformanceModel.h"

@interface PerformanceCell : UITableViewCell

@property (nonatomic,strong) UILabel *wbodyLabel;


//计算文字的大小
- (CGFloat)calculateWbodySize:(NSString *)string;

@end

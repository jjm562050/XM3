//
//  PerformanceCell.m
//  微内涵
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PerformanceCell.h"

@implementation PerformanceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self _createSubView];
    }
    
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}


- (void)_createSubView
{
    
    _wbodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, 0)];
    _wbodyLabel.font = [UIFont systemFontOfSize:16];
    _wbodyLabel.numberOfLines = 0;
    _wbodyLabel.textColor = [UIColor whiteColor];
    
    [self.contentView addSubview:_wbodyLabel];
    
}



//计算文字的大小
- (CGFloat)calculateWbodySize:(NSString *)string
{
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor blackColor],
                                 NSFontAttributeName : [UIFont systemFontOfSize:16]
                                 };
    
    CGSize size = CGSizeMake(kScreenWidth , MAXFLOAT);
    
    CGRect rect = [string boundingRectWithSize:size
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes
                                       context:nil];
    
    
    return rect.size.height + 50;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

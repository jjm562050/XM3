//
//  IntentionVideoCell.m
//  微内涵
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "IntentionVideoCell.h"
#import "UIImageView+WebCache.h"

@implementation IntentionVideoCell

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

- (void)setModel:(IntentionVideoModel *)model
{
    if (_model != model)
    {
        _model = model;
        
        [self setNeedsLayout];
    }
    
}

- (void)_createSubView
{
    //图片
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 90, 90)];
    _imageView.layer.borderWidth = 2;
    _imageView.layer.borderColor = [UIColor grayColor].CGColor;
    _imageView.layer.cornerRadius = 10;
    _imageView.layer.masksToBounds = YES;
    
    //正文
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, kScreenWidth - 150, 70)];
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:15];
    
    //喜爱数
    _likesLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 75, kScreenWidth - 100, 15)];
    _likesLabel.font = [UIFont systemFontOfSize:13];
    
    
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_contentLabel];
    [self.contentView addSubview:_likesLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //图片
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.vpic_small] placeholderImage:[UIImage imageNamed:@"Headbeijing@2x.png"]];
    
    //正文
    _contentLabel.text = _model.wbody;
    
    //喜爱数
    _likesLabel.text = [NSString stringWithFormat:@"👍%@",_model.likes];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

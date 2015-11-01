//
//  DetailLolVideoCell.m
//  微内涵
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "DetailLolVideoCell.h"
#import "UIImageView+WebCache.h"

@implementation DetailLolVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self _createSubview];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(DetailLolVideoModel *)model
{
    if (_model != model)
    {
        _model = model;
        
        [self setNeedsLayout];
    }
}

- (void)_createSubview
{
    //图片
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 80, 80)];
    _imageView.layer.borderWidth = 1;
    _imageView.layer.borderColor = [UIColor blackColor].CGColor;
    _imageView.layer.cornerRadius = 10;
    _imageView.layer.masksToBounds = YES;
    
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, kScreenWidth - 90, 60)];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    
    //发布时间
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.frame.size.width + 10, _titleLabel.frame.size.height + 5,130 , 20)];
    _dateLabel.font = [UIFont systemFontOfSize:14];
    
    //时长
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.frame.size.width + _dateLabel.frame.size.width + 5, _titleLabel.frame.size.height + 5, 100, 20)];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:_imageView];
    [self.contentView addSubview:_dateLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_titleLabel];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.thumb] placeholderImage:[UIImage imageNamed:@"Headbeijing@2x.png"]];
    
    _titleLabel.text = _model.title;
    
    _dateLabel.text = [NSString stringWithFormat:@"发布:%@",_model.date];
    
    _timeLabel.text = [NSString stringWithFormat:@"时长:%@",_model.time];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

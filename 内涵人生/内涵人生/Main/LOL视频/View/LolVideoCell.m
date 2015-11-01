//
//  LolVideoCell.m
//  微内涵
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "LolVideoCell.h"
#import "UIImageView+WebCache.h"

@implementation LolVideoCell

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

- (void)setModel:(LolVideoModel *)model
{
    if (_model != model)
    {
        _model = model;
        
        [self setNeedsLayout];
    }
    
}

- (void)_createSubview
{
    CGFloat width = kScreenWidth / 3;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, width - 10, 110)];
    //设置属性
    _imageView.layer.cornerRadius = 20;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.borderWidth = 3;
    _imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:_imageView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, width, 20)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:_label];
    

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //头像
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.icon] placeholderImage:[UIImage imageNamed:@"Headbeijing@2x.png"]];
    
    //名称
    _label.text = _model.name;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

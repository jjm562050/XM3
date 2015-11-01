//
//  PictureCell.m
//  微内涵
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PictureCell.h"
#import "UIImageView+WebCache.h"

@implementation PictureCell

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

- (void)setModel:(PictureModel *)model
{
    if (_model != model)
    {
        _model = model;
        
        [self setNeedsLayout];
    }
    
}

- (void)_createSubview
{
    //文字
    _wbodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth - 20, 30)];
    _wbodyLabel.font = [UIFont systemFontOfSize:16];
    _wbodyLabel.textColor = [UIColor purpleColor];
    
    //图片
    _wpicImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 40, kScreenWidth - 10, 0)];
    
    [self.contentView addSubview:_wbodyLabel];
    [self.contentView addSubview:_wpicImageView];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //文字
    _wbodyLabel.text = _model.wbody;
    
    //NSLog(@"%@",_model.wpic_middle);
    //图片
    //UIImageView+AFNetworking.h不支持gif图片格式  使用支持gif格式图片的SDImage库
    [_wpicImageView sd_setImageWithURL:[NSURL URLWithString:_model.wpic_middle] placeholderImage:[UIImage imageNamed:@"284338.jpg"]];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

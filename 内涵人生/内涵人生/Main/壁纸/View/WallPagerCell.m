//
//  WallPagerCell.m
//  内涵人生
//
//  Created by apple on 15/10/28.
//  Copyright (c) 2015年 zhengyiqun. All rights reserved.
//

#import "WallPagerCell.h"
#import "UIImageView+WebCache.h"
#import "EnlargePicture.h"
#import "UMSocial.h"
#import "MBProgressHUD.h"
#import "UIView+UIViewController.h"

@implementation WallPagerCell

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

- (void)setModel:(WallPagerModel *)model
{
    if (_model != model)
    {
        _model = model;
        
        [self setNeedsLayout];
    }
    
}

- (void)_createSubView
{
    _wallPager = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 400)];
    
    //开启图片点击事件
    _wallPager.userInteractionEnabled = YES;
    
    [self.contentView addSubview:_wallPager];
    
    //创建放大手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage:)];
    
    //点击次数
    tap.numberOfTapsRequired = 2;

    [_wallPager addGestureRecognizer:tap];
    
    
    //分享的手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareImage)];
    
    //手指数
    tap1.numberOfTouchesRequired = 2;
    
    [_wallPager addGestureRecognizer:tap1];
    
    
    //长按保存图片
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(savePicture:)];
    
    [_wallPager addGestureRecognizer:longPress];
    
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.wallPager sd_setImageWithURL:[NSURL URLWithString:_model.thumb] placeholderImage:[UIImage imageNamed:@"284338.jpg"]];
    
}



#pragma mark - 手势的方法
//放大
- (void)showImage:(UITapGestureRecognizer *)tap
{
    [EnlargePicture showImage:(UIImageView *)tap.view];
    
}


//分享
- (void)shareImage
{
    UIImage *image = self.wallPager.image;
    
    [UMSocialSnsService presentSnsIconSheetView:self.viewController
                                         appKey:@"551a5860fd98c513b60002f7"
                                      shareText:self.viewController.title
                                     shareImage:image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToSms,UMShareToEmail,nil]
                                       delegate:self];
}



//长按保存的方法
- (void)savePicture:(UILongPressGestureRecognizer *)longPress
{
    if(longPress.state == UIGestureRecognizerStateEnded)
    {
        //提示是否保存
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否保存图片" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
        
        [alterView show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        
        UIImage *image = self.wallPager.image;
        
        //把图片保存到相册
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
    }
    
}

//保存后调用的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    //提示保存成功
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    //显示模式改为：自定义视图模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功";
    
    //延迟隐藏
    [hud hide:YES afterDelay:1.5];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  PlayVideoController.m
//  微内涵
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PlayVideoController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"

#import <MediaPlayer/MediaPlayer.h>

@interface PlayVideoController ()<UMSocialUIDelegate>
{
    
    NSString *_urlStr;
}
@end

@implementation PlayVideoController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _createSubview];
    
    [self loadData];
    
    [self _createButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = YES;
}

//设置
- (void)_createButton
{
    //左边
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 40, 30);
    
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = left;
    
    //右边
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40, 30);
    
    [rightButton setTitle:@"分享" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;

    
}


- (void)_createSubview
{
    //大图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, kScreenWidth - 20,300)];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:_model.thumb] placeholderImage:[UIImage imageNamed:@"Headbeijing@2x.png"]];
    
    imageView.userInteractionEnabled = YES;
    
    [self.view addSubview:imageView];
    
    //播放图片
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 20) / 2 - 30, 120 , 60, 60)];
    
    imageView1.image = [UIImage imageNamed:@"PlayMovie@2x.png"];
    
    [imageView addSubview:imageView1];
    
    
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(play)];
    
    [imageView addGestureRecognizer:tap];
    
    
}

- (void)loadData
{
    [self showHud:@"正在加载..."];
    
    NSString *string = [NSString stringWithFormat:@"http://api.dotaly.com/lol/api/v1/getvideourl?iap=0&ident=1EFB14A9-BC26-497D-A761-D2DE836C3933&jb=0&nc=3435719118&tk=55b9a53452e4994c8e2d83a9207c671d&type=flv&vid=%@",self.model.id];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //NSLog(@"%@",dict);
        
        _urlStr = dict[@"url"];
        
        //NSLog(@"%@",_urlStr);
        
        [self completeHUD:@"加载完成"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];

    
}

#warning 手势的方法
- (void)play
{
    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:_urlStr]];
    
    [self presentViewController:player animated:YES completion:nil];
    
    
}

#warning 按钮的方法
- (void)backButton
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//分享
- (void)share
{
    //NSLog(@"dddddd%@",_urlStr);
    
//    [UMSocialData defaultData].extConfig.we
    
    //分享视频
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeVideo url:_urlStr];
    
    //分享图片、
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:_model.thumb];
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:nil shareText:self.model.title shareImage:nil shareToSnsNames:@[UMShareToSina] delegate:self];
    
    
    
    
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"551a5860fd98c513b60002f7"
//                                      shareText:self.title
//                                     shareImage:[UIImage imageNamed:self.model.thumb]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToSms,UMShareToEmail,nil]
//                                       delegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

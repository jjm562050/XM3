//
//  AppreciatePictureController.m
//  微内涵
//
//  Created by MAC22 on 15/10/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "AppreciatePictureController.h"
#import "SDImageCache.h"
#import "UMSocial.h"
#import "UIImageView+AFNetworking.h"
#import "CollectController.h"

@interface AppreciatePictureController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
    NSArray *_namesArray;
    
    //登录的UI
    UIButton *_loginButton;
    UILabel *_nameLable;
    UIImageView *_headImageView;
    
    UILabel *_cacheLabel;

}
@end

@implementation AppreciatePictureController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _createSubView];
}


- (void)viewDidAppear:(BOOL)animated
{
    _cacheLabel.text = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
    
    [_tableView reloadData];
}


//创建子控件
- (void)_createSubView
{
    _namesArray = @[@"收藏",@"地图",@"反馈",@"关于",@"清除缓存",@"退出登录"];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth - 10,kScreenHieght) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
    
    //开启点击事件
    _headImageView.userInteractionEnabled = YES;
    
    //创建头视图 view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    _tableView.tableHeaderView = view;
    
    //按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((kScreenWidth - 80) / 2  , 10, 80  , 80);
    button.layer.cornerRadius = button.frame.size.width / 2;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(loginButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];

    //头像
    _headImageView = [[UIImageView alloc] initWithFrame:button.bounds];
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width / 2;
    _headImageView.layer.masksToBounds = YES;
    
    [button addSubview:_headImageView];
    
    
    //名称
    _nameLable = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 200) / 2, 90, 200, 30)];
    _nameLable.textAlignment = NSTextAlignmentCenter;
    _nameLable.font = [UIFont systemFontOfSize:20];
    [view addSubview:_nameLable];
    
    //保存登录信息
    NSUserDefaults *username = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *iconURL = [NSUserDefaults standardUserDefaults];
    if (![username objectForKey:@"username"])
    {
        _nameLable.text = @"登录";
        _headImageView.image = [UIImage imageNamed:@"head@2x.png"];
    }
    else
    {
        _nameLable.text = [username objectForKey:@"username"];
        [_headImageView setImageWithURL:[NSURL URLWithString:[iconURL objectForKey:@"iconURL"]]];
    }
    
    
    //创建label
    _cacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 8, 70, 30)];
    _cacheLabel.font = [UIFont systemFontOfSize:15];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _namesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    cell.textLabel.text = _namesArray[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    
    if (indexPath.row == 5)
    {
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;

    }
    
    
    //创建label
    if (indexPath.row == 4)
    {
        //_cacheLabel.backgroundColor = [UIColor purpleColor];
        
        [cell.contentView addSubview:_cacheLabel];

    }
    
    return cell;
}

//单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//组的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


//选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0)
    {
        CollectController *collect = [[CollectController alloc] init];
        
        [self.navigationController pushViewController:collect animated:YES];
        
    }
    else if (indexPath.row == 1)
    {
        
    }
    else if (indexPath.row == 2)
    {
        NSString *string = @"有好的建议或者发现程序BUG可发邮件到2524920054@qq.com或者475980563@qq.com";
        
        [self showContent:string];
        
    }
    else if (indexPath.row == 3)
    {
        NSString *string = @"本应用是不含广告的1.0版本,其中可能有不可预知的BUG,本应用多图多视频建议在Wi-Fi环境下使用";
        
        [self showContent:string];
        
    }
    else if (indexPath.row == 4)
    {
        
        //清除缓存
        if([self countCacheFileSize] > 0)
        {
            UIAlertView * alterView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"是否清除缓存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alterView show];
            
        }

    }
    else
    {
        //退出登录
        NSUserDefaults *username = [NSUserDefaults standardUserDefaults];
        [username removeObjectForKey:@"username"];
        NSUserDefaults *iconURL = [NSUserDefaults standardUserDefaults];
        [iconURL removeObjectForKey:@"iconURL"];
        
        _nameLable.text = @"登录";
        _headImageView.image = [UIImage imageNamed:@"head@2x.png"];
        
    }
}


#pragma mark - 清除缓存
#pragma mark - 获取缓存文件的路径 并 计算当前应用程序缓存文件的大小

-(CGFloat)countCacheFileSize
{
    
    //1.获取缓存文件夹的路径
    // 函数  用于获取当前程序的沙盒路径
    NSString *homePath = NSHomeDirectory();
    
    NSLog(@"%@",homePath);
    
    /*
     字文件夹1： 视频缓存 /tmp/
     字文件夹2:  /Library/Caches/com.huiwenjiaoyu.-----/fsCachedData/
     */
    
    //2.使用- (CGFloat)getFileSize:(NSString *)filePath  来计算这些文件夹中文件的大小
    NSArray *pathArray = @[@"/tmp/",
                           @"/Library/Caches/com.hackemist.SDWebImageCache.default/"
                           ];
    
    //初始化filesize
    CGFloat fileSize = 0;
    
    //文件大小之和
    for (NSString *string in pathArray)
    {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        
        fileSize += [self getFileSize:filePath];
        
    }
    
    //3.对上一步计算的结果进行求和  并返回
    return fileSize;
}

#pragma mark - 计算此路径下的文件大小
- (CGFloat)getFileSize:(NSString *)filePath
{
    //文件管理对象 单例
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //数组 存储文件夹中所有的字文件夹以及文件的名字
    NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
    
    //初始化size
    long long size = 0;
    
    //遍历文件夹
    for (NSString *fileName in fileNames)
    {
        //拼接获取文件夹的路径
        NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
        
        //获取文件的信息
        NSDictionary *dic = [manager attributesOfItemAtPath:subFilePath error:nil];
        
        //获取缓存文件的大小
        NSNumber *sizeNumber = dic[NSFileSize];
        
        //使用一个 long long 类型来存储文件的大小
        long long subFileSize = [sizeNumber longLongValue];
        
        //文件大小求和
        size += subFileSize;
        
    }
    
    return size / 1024.0 / 1024.0;
}

#pragma mark - 清除缓存
- (void)clearCache
{
    //1.获取文件路径
    //1.获取缓存文件夹的路径
    //函数 用于获取当前程序的沙盒路径
    NSString *homePath = NSHomeDirectory();
    
    NSArray *pathArray = @[@"/tmp/",
                           @"/Library/Caches/com.hackemist.SDWebImageCache.default/"
                           ];
    
    //2.删除文件
    for (NSString *string in pathArray)
    {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        
        // 文件管理对象  单例
        NSFileManager *manager = [NSFileManager defaultManager];
        
        //数组 存储文件夹中所有的字文件夹以及文件的名字
        NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
        
        //遍历文件夹
        for(NSString *fileName in fileNames)
        {
            //拼接获取文件夹的路径
            NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
            
            //删除文件
            [manager removeItemAtPath:subFilePath error:nil];
            
        }
    }
    
    //3.重新计算缓存大小
    _cacheLabel.text = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
    
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //清除缓存
        [self clearCache];
        
    }
}

#pragma mark - 登录按钮的方法
- (void)loginButton:(UIButton *)btn
{
    //NSLog(@"sdgfsd");
    NSUserDefaults *username = [NSUserDefaults standardUserDefaults];
    if (![username objectForKey:@"username"])
    {
        [self login];
    }
}

//登录的方法    友盟
- (void)login
{
    //第三方登录
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            //打印
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            NSUserDefaults *username = [NSUserDefaults standardUserDefaults];
            [username setObject:snsAccount.userName forKey:@"username"];
            
            NSUserDefaults *iconURL = [NSUserDefaults standardUserDefaults];
            [iconURL setObject:snsAccount.iconURL forKey:@"iconURL"];
            
            // _nameLable.text = snsAccount.userName;
            //  NSUserDefaults *username = [NSUserDefaults standardUserDefaults];
            
            if (![username objectForKey:@"username"])
            {
                _nameLable.text = @"登录";
                _headImageView.image = [UIImage imageNamed:@"head@2x.png"];
            }
            else
            {
                _nameLable.text = [username objectForKey:@"username"];
                [_headImageView setImageWithURL:[NSURL URLWithString:[iconURL objectForKey:@"iconURL"]]];
            }
        }});

    
}


#pragma mark - 反馈 关于
- (void)showContent:(NSString *)content
{
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alterView show];
    
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

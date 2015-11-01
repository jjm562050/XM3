//
//  IntentionVideoController.m
//  微内涵
//
//  Created by MAC22 on 15/10/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "IntentionVideoController.h"
#import "IntentionVideoModel.h"
#import "IntentionVideoCell.h"

#import <MediaPlayer/MediaPlayer.h>

@interface IntentionVideoController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    
    UITableView *_tableView;
    
    NSInteger _indexPage; //请求参数的页数
    NSString  *_time; //请求参数的时间戳
    
}
@end

@implementation IntentionVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.title = @"内涵视频";
    
    //上滑影藏导航栏下滑出现
    self.navigationController.hidesBarsOnSwipe=YES;
    
    [self _createTableView];
    [self obtainSystemTime];
    [self loadData];
}

//tableview
- (void)_createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    //下拉
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //上拉
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //注册
    [_tableView registerClass:[IntentionVideoCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
}

#warning 下拉 上拉刷新
//下拉刷新
- (void)loadNewData
{
    //从第一页开始下载
    _indexPage = 0;
    
    //给当前的时间  重新刷新
    NSInteger time = _time.integerValue;
    _time = [NSString stringWithFormat:@"%ld",time];
    
    
    [self loadData];
}

//上拉
- (void)loadMoreData
{
    _indexPage++;
    
    //加载下一页的数据
    NSInteger time = _time.integerValue - 3600*_indexPage*24;
    _time = [NSString stringWithFormat:@"%ld",time];
    
    [self loadData];
    
}

//获取系统当前时间
- (void)obtainSystemTime
{
    //获取当前的时间
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    //获取从1970到当前时间的总时间
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    _time = [NSString stringWithFormat:@"%f",timeInterval];
    
    //NSLog(@"%lf",timeInterval);
}

//加载数据
- (void)loadData
{
    [self showHud:@"正在加载..."];
    
    NSString *urlStr = [NSString stringWithFormat:SHIPING_URL,_indexPage,_time];

    [AFNateWorking afNetWorking:urlStr params:nil metod:@"GET" completionBlock:^(id completion) {
        //NSLog(@"%@",completion);
        NSArray *items = completion[@"items"];
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in items)
        {
            IntentionVideoModel *model = [[IntentionVideoModel alloc] initWithDataDic:dic];
            
            [data addObject:model];
        }
        
        //添加数据
        if (_indexPage == 0)
        {
            _dataArray = data;
        }
        else
        {
            [_dataArray addObjectsFromArray:data];
        }
        
        
        //刷新
        [_tableView reloadData];
        
        //关闭
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
        [self completeHUD:@"加载完成"];
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"error:%@",error);
    }];
    
    
    
    
}

#warning UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntentionVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    
    return cell;
    
}

//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}

//选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntentionVideoModel *model = _dataArray[indexPath.row];
    
    NSString *urlString = model.vplay_url;
    
    [self player:urlString];
}


#warning 播放方法
- (void)player:(NSString *)string
{
    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:string]];
    
    [self presentViewController:player animated:YES completion:nil];
    
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

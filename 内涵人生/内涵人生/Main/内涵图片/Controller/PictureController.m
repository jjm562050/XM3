//
//  PictureController.m
//  微内涵
//
//  Created by MAC22 on 15/10/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PictureController.h"
#import "PictureCell.h"
#import "AFNateWorking.h"
#import "PictureModel.h"

@interface PictureController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    NSInteger _indexPage; //请求参数的页数
    NSString  *_time; //请求参数的时间戳
}
@end

@implementation PictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"内涵图片";
    
    _indexPage = 0;
    //上滑影藏导航栏下滑出现
    self.navigationController.hidesBarsOnSwipe=YES;
    
    [self _createSubView];
    
    [self loadData];
}

- (void)_createSubView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    //下拉
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //上拉
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //注册
    [_tableView registerClass:[PictureCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
    
}

#pragma mark - 下拉 上拉
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


//加载数据
- (void)loadData
{
    [self showHud:@"正在加载..."];
    
    NSString *urlStr = [NSString stringWithFormat:QUTU_URL,_indexPage,_time];
    
    [AFNateWorking afNetWorking:urlStr params:nil metod:@"GET" completionBlock:^(id completion) {
        //NSLog(@"fff%@",completion);
        
        NSArray *items = completion[@"items"];
        //NSLog(@"%@",items);
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in items)
        {
            PictureModel *model = [[PictureModel alloc] initWithDataDic:dic];
            
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


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    PictureModel *model = _dataArray[indexPath.row];
    
    cell.model = model;
    
    //重新设置frame
    cell.wpicImageView.frame = CGRectMake(5, 40, kScreenWidth - 10, model.wpic_m_height.integerValue);
    
    return cell;
}

//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PictureModel *model = _dataArray[indexPath.row];
    
    return model.wpic_m_height.integerValue + 60;
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

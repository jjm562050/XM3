//
//  DetailVideoController.m
//  微内涵
//
//  Created by apple on 15/10/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "DetailVideoController.h"
#import "AFHTTPRequestOperationManager.h"
#import "DetailLolVideoCell.h"
#import "PlayVideoController.h"
#import "MJRefresh.h"

@interface DetailVideoController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _pageIndex;
    
    NSMutableArray *_dataArray;
    
    UITableView *_tableView;
}
@end

@implementation DetailVideoController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBar.translucent = NO;

    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //上滑影藏导航栏下滑出现
    //self.navigationController.hidesBarsOnSwipe=YES;
    
    _pageIndex = 1;
    [self _createTableView];
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)_createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //下拉刷新
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //注册
    [_tableView registerClass:[DetailLolVideoCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
    
    
}

//加载新的数据
- (void)loadNewData
{
    _pageIndex = 1;
    
    [self loadData];
    
}

//加载更多数据
- (void)loadMoreData
{
    _pageIndex++;
    
    [self loadData];
    
}


//加载数据
- (void)loadData
{
    //调用
    [self showHud:@"正在加载..."];
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.dotaly.com/lol/api/v1/shipin/latest?author=%@&iap=0&ident=0&jb=0&limit=50&nc=0&offset=%ld&tk=0",self.author,_pageIndex];
    
    //创建HTTP请求操作管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
         //NSLog(@"%@",dict);
         NSArray *array = dict[@"videos"];
         //NSLog(@"%@",array);
         
          NSMutableArray *dataArray = [[NSMutableArray alloc] init];
         
         for (NSDictionary *dic in array)
         {
             DetailLolVideoModel *model = [[DetailLolVideoModel alloc] init];
             [model setValuesForKeysWithDictionary:dic];
             
             [dataArray addObject:model];
         }
         
         //添加数据
         if (_pageIndex == 1)
         {
             _dataArray = dataArray;
         }
         else
         {
             [_dataArray addObjectsFromArray:dataArray];
         }
         
         //关闭
         [self completeHUD:@"加载完成"];

         
         //刷新
         [_tableView reloadData];
         
         //关闭
         [_tableView.header endRefreshing];
         [_tableView.footer endRefreshing];
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"请求失败");
     }];

    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailLolVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    return cell;
    
}

//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailLolVideoModel *model = _dataArray[indexPath.row];
    
    PlayVideoController *play = [[PlayVideoController alloc] init];
    
    play.model = model;
    
    [self.navigationController pushViewController:play animated:YES];
    
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

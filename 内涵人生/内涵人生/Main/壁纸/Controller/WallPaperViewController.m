//
//  WallPaperViewController.m
//  微内涵
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "WallPaperViewController.h"
#import "AFNateWorking.h"
#import "WallPagerModel.h"
#import "WallPagerCell.h"


@interface WallPaperViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    //请求参数
    NSMutableArray *_dataArray;
    NSInteger _indexPage;
    
    NSInteger _index;
    //UIImageView *_shareImageView;
}
@end

@implementation WallPaperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //初始化
    //_shareImageView = [[UIImageView alloc] init];
    _indexPage = 1;
    
    [self _createSubView];
    
    [self loadData];
    
}


//下拉刷新
- (void)loadNewData
{
    //从第一页开始下载
    _indexPage = 1;
    
    [self loadData];
}

//上拉
- (void)loadMoreData
{
    _indexPage++;
    
    
    [self loadData];
    
}


- (void)loadData
{
    [self showHud:@"正在加载..."];
    
    NSString *url = [NSString stringWithFormat:WallPager,_indexPage];
    
    [AFNateWorking afNetWorking:url params:nil metod:@"GET" completionBlock:^(id completion) {
        
        //NSLog(@"%@",completion);
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in completion)
        {
            WallPagerModel *model = [[WallPagerModel alloc] init];
            model.thumb = dic[@"thumb"];
            
            [data addObject:model];
        }
        
        //添加数据
        if (_indexPage == 1)
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
        NSLog(@"%@",error);
    }];
    
}


- (void)_createSubView
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,64)];
    UIColor *color = [UIColor colorWithRed:180 / 255.0 green:53 / 255.0 blue:55 /255.0 alpha:1];
    view.backgroundColor = color;
    
    [self.view addSubview:view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 25, 50, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHieght - 64) style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    //下拉
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    //上拉
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    
    [_tableView registerClass:[WallPagerCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WallPagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
    
}



#pragma mark - 按钮的方法
- (void)btnAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

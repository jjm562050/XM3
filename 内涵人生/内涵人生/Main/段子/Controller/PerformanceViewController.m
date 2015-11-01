//
//  PerformanceViewController.m
//  微内涵
//
//  Created by apple on 15/10/27.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PerformanceViewController.h"
#import "PerformanceModel.h"
#import "PerformanceCell.h"

@interface PerformanceViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    
    NSInteger _indexPage;
    NSString  *_time; //请求参数的时间戳
}
@end

@implementation PerformanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _indexPage = 1;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"12.png"];
    imageView.frame=CGRectMake(0, 0, kScreenWidth , kScreenHieght);
    [self.view addSubview:imageView];
    
    [self obtainSystemTime];
    
    [self _createSubView];
    
    [self loadData];
}


//下拉刷新
- (void)loadNewData
{
    //从第一页开始下载
    _indexPage = 1;
    
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


- (void)loadData
{
    [self showHud:@"正在加载..."];
    
    NSString *url = [NSString stringWithFormat:Performance_URL,_indexPage,_time];
    
    [AFNateWorking afNetWorking:url params:nil metod:@"GET" completionBlock:^(id completion) {
        
        //NSLog(@"%@",completion);
        
        NSArray *items = completion[@"items"];
        //NSLog(@"%@",items);
        
        NSMutableArray *data = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in items)
        {
            PerformanceModel *model = [[PerformanceModel alloc] init];
            model.wbody = dic[@"wbody"];
            
            [data addObject:model];
        }
        
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
    
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[PerformanceCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PerformanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    PerformanceModel *model = _dataArray[indexPath.row];
    
    cell.wbodyLabel.text = model.wbody;
    
    CGFloat height = [cell calculateWbodySize:model.wbody];
    
    cell.wbodyLabel.frame = CGRectMake(15, 10, kScreenWidth - 30, height);
    
    //选中方式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PerformanceModel *model = _dataArray[indexPath.row];
    
    CGFloat height = [self calculateWbodySize:model.wbody];
    
    return height + 50;
}

//计算文字的大小
- (CGFloat)calculateWbodySize:(NSString *)string
{
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor blackColor],
                                 NSFontAttributeName : [UIFont systemFontOfSize:16]
                                 };
    
    CGSize size = CGSizeMake(kScreenWidth - 30, MAXFLOAT);
    
    CGRect rect = [string boundingRectWithSize:size
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes
                                       context:nil];
    
    
    return rect.size.height;
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

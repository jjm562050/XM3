//
//  LolVideoController.m
//  微内涵
//
//  Created by MAC22 on 15/10/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "LolVideoController.h"
#import "AFHTTPRequestOperationManager.h"
#import "LolVideoModel.h"
#import "LolVideoCell.h"
#import "DetailVideoController.h"

@interface LolVideoController ()
{
    //创建不同的tableview
    UITableView *_tableView1;
    UITableView *_tableView2;
    UITableView *_tableView3;
    
    //创建不同的数组
    NSArray *_array1;
    NSArray *_array2;
    NSArray *_array3;
    
    //创建保存总的数据数组
    NSMutableArray *_dataArray;
}
@end

@implementation LolVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"LOL视频";
    
    //上滑影藏导航栏下滑出现
    //self.navigationController.hidesBarsOnSwipe = NO;

    
    [self _createTableViews];
    
    [self loadData];
    
    [self ctreateButton];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    //设置导航栏为半透明
    self.navigationController.navigationBar.translucent = YES;
}

//创建tableview
- (void)_createTableViews
{
    CGFloat width = kScreenWidth / 3;
    
    //第一个加入到控制器的tableview 的高度为64
    UITableView *table = [[UITableView alloc] init];
    [self.view addSubview:table];
    
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width, kScreenHieght - 110)];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
//    _tableView1.backgroundColor = [UIColor redColor];
    [_tableView1 registerClass:[LolVideoCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:_tableView1];
    
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(width, 64, width, kScreenHieght - 110)];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
//    _tableView2.backgroundColor = [UIColor orangeColor];
    [_tableView2 registerClass:[LolVideoCell class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:_tableView2];
    
    
    _tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(width * 2, 64, width, kScreenHieght - 110)];
    _tableView3.delegate = self;
    _tableView3.dataSource = self;
//    _tableView3.backgroundColor = [UIColor purpleColor];
    [_tableView3 registerClass:[LolVideoCell class] forCellReuseIdentifier:@"cell3"];
    [self.view addSubview:_tableView3];
    
    //隐藏滑动条
    _tableView1.showsVerticalScrollIndicator = NO;
    _tableView2.showsVerticalScrollIndicator = NO;
    _tableView3.showsVerticalScrollIndicator = NO;
    
    //取消分割线
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView3.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

//下载数据
- (void)loadData
{
    //调用
    [self showHud:@"正在加载..."];
    
    NSString *urlString = @"http://api.dotaly.com/lol/api/v1/authors?iap=0&ident=0&jb=0&nc=0&tk=0";
    //创建HTTP请求操作管理器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        //NSLog(@"%@",dict);
        NSArray *array = dict[@"authors"];
        
        //NSLog(@"%@",array);
        
        //初始化
        _dataArray = [[NSMutableArray alloc] init];
        
        //用循环遍历数组array
        for (NSDictionary *dic in array)
        {
            LolVideoModel *model = [[LolVideoModel alloc] init];
            model.icon = dic[@"icon"];
            model.name = dic[@"name"];
            model.url = dic[@"url"];
            model.detail = dic[@"detail"];
            model.youku_id = dic[@"youku_id"];
            model.wxID = dic[@"id"];
            
            [_dataArray addObject:model];
        }
        
        
        //给数组赋予不同范围的值 subarrayWithRange:NSMakeRange(0, 17) 从0个元素开始取后面17个元素
        _array1 = [_dataArray subarrayWithRange:NSMakeRange(0, 17)];
        _array2 = [_dataArray subarrayWithRange:NSMakeRange(17, 17)];
        _array3 = [_dataArray subarrayWithRange:NSMakeRange(34, 17)];
        
        //刷新tableview
        [_tableView1 reloadData];
        [_tableView2 reloadData];
        [_tableView3 reloadData];
        
        [self completeHUD:@"加载完成"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _tableView1)
    {
        return _array1.count;
    }
    else if (tableView == _tableView2)
    {
        return _array2.count;
    }
    else
    {
        return _array3.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _tableView1)
    {
        LolVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    
        //NSLog(@"%ld",_array1.count);
        cell.model = _array1[indexPath.row];
        
        return cell;
    }
    else if (tableView == _tableView2)
    {
        LolVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        cell.model = _array2[indexPath.row];
        return cell;
    }
    
    LolVideoCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
    
    cell.model = _array3[indexPath.row];
    return cell;
    
}

//选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView1)
    {
        LolVideoModel *model = _array1[indexPath.row];
        DetailVideoController *dvc = [[DetailVideoController alloc] init];
        
        dvc.title = model.name;
        dvc.author = model.wxID;
        
        [self.navigationController pushViewController:dvc animated:YES];
        
    }
    else if (tableView == _tableView2)
    {
        LolVideoModel *model = _array2[indexPath.row];
        DetailVideoController *dvc = [[DetailVideoController alloc] init];
        
        dvc.title = model.name;
        dvc.author = model.wxID;
        
        [self.navigationController pushViewController:dvc animated:YES];

    }
    else
    {
        LolVideoModel *model = _array3[indexPath.row];
        DetailVideoController *dvc = [[DetailVideoController alloc] init];
        
        dvc.title = model.name;
        dvc.author = model.wxID;
        
        [self.navigationController pushViewController:dvc animated:YES];

    }
    
}


//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView1)
    {
        return 130;
    }else if (tableView == _tableView2)
    {
        return 130;
    }
    else
    {
        return 130;
    }
    
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

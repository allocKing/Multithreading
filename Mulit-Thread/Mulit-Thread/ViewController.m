//
//  ViewController.m
//  Mulit-Thread
//
//  Created by 谷统鑫 on 16/5/28.
//  Copyright © 2016年 谷统鑫. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "GTXThreadModel.h"

/**
 *  可重用cell标识符
 */
static NSString *cellId = @"cellId";

@interface ViewController ()<UITableViewDataSource>
/**
 *  表格视图
 */
@property (nonatomic ,strong) UITableView *table;
/**
 *  模型数组
 */
@property (nonatomic, strong) NSArray <GTXThreadModel *>*gamesArr;

@end

@implementation ViewController

/**
 *  设置根视图
 */

- (void)loadView{

    UITableView *table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.view = table;
    
    table.dataSource = self;
    
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    
    _table = table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loaddata];
    
}

- (void)loaddata{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlString = @"https://raw.githubusercontent.com/allocKing/Multithreading/master/apps.json";
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * responseObject) {
//        NSLog(@"%@",responseObject);
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            GTXThreadModel *model = [[GTXThreadModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [arrM addObject:model];
        }
        
        self.gamesArr = arrM.copy;
        
        [self.table reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败");
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _gamesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.textLabel.text = _gamesArr[indexPath.row].name;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

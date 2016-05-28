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
#import "UIImageView+WebCache.h"
#import "GTXAppCell.h"

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
/**
 *  下载队列
 */
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

/**
 *  设置根视图
 */

- (void)loadView{

    UITableView *table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.view = table;
    
    // 设置行高
    table.rowHeight = 100;
    
    table.dataSource = self;
    
    [table registerNib:[UINib nibWithNibName:@"GTXAppCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
    
    _table = table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _queue = [[NSOperationQueue alloc]init];
    
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
    
    GTXAppCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.nameLabel.text = _gamesArr[indexPath.row].name;
    
    cell.downLoad.text = _gamesArr[indexPath.row].download;
    
    UIImage *image = [UIImage imageNamed:@"user_default"];
    
    cell.appIcon.image = image;
    
    if (_gamesArr[indexPath.row].image !=nil ) {
        
        NSLog(@"内存缓存");
        
        cell.appIcon.image = _gamesArr[indexPath.row].image;
        
        return cell;
    }
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        
        [NSThread sleepForTimeInterval:1];
        
        NSURL *url = [NSURL URLWithString:_gamesArr[indexPath.row].icon];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        UIImage *image = [UIImage imageWithData:data];
        
        _gamesArr[indexPath.row].image = image;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            cell.appIcon.image = image;
        }];
    }];
    
    
    [_queue addOperation:op];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  Mulit-Thread
//
//  Created by 谷统鑫 on 16/5/28.
//  Copyright © 2016年 谷统鑫. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()
/**
 *  表格视图
 */
@property (nonatomic ,strong) UITableView *table;

@end

@implementation ViewController

/**
 *  设置根视图
 */

- (void)loadView{

    UITableView *table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.view = table;
    
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
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络请求失败");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

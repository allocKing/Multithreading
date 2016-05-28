//
//  GTXThreadModel.h
//  Mulit-Thread
//
//  Created by 谷统鑫 on 16/5/28.
//  Copyright © 2016年 谷统鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTXThreadModel : NSObject
/**
 *  游戏名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  下载量
 */
@property (nonatomic, copy) NSString *download;
/**
 *  图标
 */
@property (nonatomic, copy) NSString *icon;

@end

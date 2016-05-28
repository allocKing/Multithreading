//
//  GTXAppCell.h
//  Mulit-Thread
//
//  Created by 谷统鑫 on 16/5/28.
//  Copyright © 2016年 谷统鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTXAppCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *appIcon;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *downLoad;

@end

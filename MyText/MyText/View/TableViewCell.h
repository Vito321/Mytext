//
//  TableViewCell.h
//  MyText
//
//  Created by 张丹 on 16/12/20.
//  Copyright © 2016年 张丹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dataModel.h"
@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ImageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ImageWide;

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
-(void)showDataInTableViewCell:(dataModel *)model;

@end

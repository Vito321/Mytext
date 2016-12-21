//
//  ViewController.m
//  MyText
//
//  Created by 张丹 on 16/12/20.
//  Copyright © 2016年 张丹. All rights reserved.
//

#import "ViewController.h"

#import "LCLoadingHUD.h"
#import "TableViewCell.h"
#import "TextManage.h"
#import "dataModel.h"

#define urlstr @"http://thoughtworks-ios.herokuapp.com/facts.json"

CGFloat Height;

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>{
  
    NSMutableArray *listArray;
}
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Height = 150;
    //获取数据
    [self getDataOfList:urlstr];
    // 取消tableView的留白
    self.automaticallyAdjustsScrollViewInsets=NO ;
    self.tableView.tableFooterView = [UIView new];
    
}

#pragma mark - 自定义方法
#pragma mark 数据请求
-(void)getDataOfList:(NSString *)url{
    
    listArray = [NSMutableArray array];
    
    [LCLoadingHUD showLoading:@"正在加载"];
    [[[TextManage shareManager] AFManager] GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = [responseObject valueForKey:@"rows"];
        for (NSDictionary *dicIn in array)
        {
            dataModel *modelS = [[dataModel alloc]init];
            [modelS setValuesForKeysWithDictionary:dicIn];
            
            [listArray addObject:modelS];
        }
        [LCLoadingHUD hideInKeyWindow];

        self.title = [responseObject valueForKey:@"title"];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LCLoadingHUD hideInKeyWindow];

    }];
}
#pragma mark -tableView 的代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (listArray.count==0) {
        return 0;
    }else{
        return listArray.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return Height+10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    
    if (cell==nil) {
        NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:nil options:nil];
        cell = [cells lastObject];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
   [cell showDataInTableViewCell: listArray[indexPath.row]];
    
    return cell;
}


@end

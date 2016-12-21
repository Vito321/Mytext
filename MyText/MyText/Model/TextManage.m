//
//  TextManage.m
//  MyText
//
//  Created by 张丹 on 16/12/20.
//  Copyright © 2016年 张丹. All rights reserved.
//

#import "TextManage.h"


@implementation TextManage

#pragma mark 单例
static id manager;
+ (id) shareManager{
    if (manager==nil) {
        manager = [[self alloc]init];
    }
    return manager;
}
#pragma mark 懒加载 创建AF管理
-(AFHTTPSessionManager *)AFManager
{
    if (_AFManager==nil) {
        _AFManager = [AFHTTPSessionManager manager];
        //设置超时时间30秒
        [_AFManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _AFManager.requestSerializer.timeoutInterval = 30;
        [_AFManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return _AFManager;
}
@end

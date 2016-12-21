//
//  TextManage.h
//  MyText
//
//  Created by 张丹 on 16/12/20.
//  Copyright © 2016年 张丹. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface TextManage : NSObject

@property (nonatomic,strong)AFHTTPSessionManager *AFManager;

//单例
+ (id) shareManager;


@end

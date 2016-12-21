//
//  dataModel.h
//  MyText
//
//  Created by 张丹 on 16/12/20.
//  Copyright © 2016年 张丹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataModel : NSObject

@property (nonatomic ,strong) NSString * titleNameStr;//navigation的标题

@property (nonatomic ,strong) NSString * Title;//cell的标题

@property (nonatomic ,strong) NSString * Description;//内容

@property (nonatomic ,strong) NSString * ImageHref;//图片

@end

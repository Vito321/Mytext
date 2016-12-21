//
//  InterfaceTools.h
//  Fur
//
//  Created by 张丹 on 16/12/20.
//  Copyright © 2016年 张丹. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceTools : NSObject

/**
 *  标记view的颜色
 *
 *  @param views 需要标记的父view
 */
+ (void)markerView:(UIView*)views;

/**
 *  添加虚线框
 *
 *  @param view  视图
 *  @param color 颜色
 */
+ (void)addDotViewBorder:(UIView*)view color:(UIColor*)color;

/**
 *  获取view的父tableViewCell
 *
 *  @param tView 视图
 *
 *  @return tableViewCell
 */
+ (UITableViewCell*)getSuperTableViewCellFromView:(UIView*)tView;

/**
 *  获取当前控制器
 *
 *  @return 控制器
 */
+ (UIViewController *)getPresentedViewController;


#pragma mark - 字体

/**
 *  动态计算文本所占区域大小
 *
 *  @param text      文本
 *  @param font      字体
 *  @param superSize 所绘制区域的范围
 *
 *  @return 区域大小
 */
+ (CGSize)sizeFromText:(NSString*)text
              withFont:(UIFont*)font
                inSize:(CGSize)superSize;

/**
 *  获取自定义字体
 *
 *  @param path 路径
 *  @param size 大小
 *
 *  @return 自定义字体
 */
+ (UIFont*)customFontWithPath:(NSString*)path size:(CGFloat)size;

/**
 *  获取字体对应高度
 *
 *  @param fontsize 字体大小
 *
 *  @return 高度
 */
+ (float)getHeightFromFontSize:(float)fontsize;

#pragma mark - 图片

/**
 *  根据颜色生成image
 *
 *  @param color 颜色
 *
 *  @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  根据颜色和大小生成image
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return image
 */
+ (UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  等比例缩放图片
 *
 *  @param size  大小
 *  @param image 图片
 *
 *  @return 图片
 */
+ (UIImage*)imageWithScaleToSize:(CGSize)size image:(UIImage*)image mode:(BOOL)isFill;

/**
 *  指定宽度自适应图片
 *
 *  @param img   图片
 *  @param width 宽度
 *
 *  @return 图片
 */
+ (UIImage*)scaleImage:(UIImage*)img withFixWidth:(float)width;

/**
 *  指定高度自适应图片
 *
 *  @param img   图片
 *  @param height 宽度
 *
 *  @return 图片
 */
+ (UIImage*)scaleImage:(UIImage*)img withFixHeight:(float)height;

/**
 *  合并图片
 *
 *  @param image1 背景图片
 *  @param image2 覆盖图片
 *  @param frame  frame
 *
 *  @return 图片
 */
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 frame:(CGRect)frame mode:(CGBlendMode)mode;

/**
 *  合并图片
 *
 *  @param image1 图1
 *  @param image2 图2
 *
 *  @return 图
 */
+ (UIImage *)mergeImage:(UIImage*)image1 image2:(UIImage *)image2;


@end

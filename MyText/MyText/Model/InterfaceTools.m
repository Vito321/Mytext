//
//  InterfaceTools.m
//  Fur
//
//  Created by 张丹 on 16/12/20.
//  Copyright © 2016年 张丹. All rights reserved.
//

#import "InterfaceTools.h"
#import <CoreText/CoreText.h>

@implementation InterfaceTools

/**
 *  标记view的颜色
 *
 *  @param views 需要标记的父view
 */
+ (void)markerView:(UIView*)views{
    
    views.layer.borderWidth = 2;
    views.layer.borderColor = [UIColor colorWithRed:(arc4random()%255)/255. green:(arc4random()%255)/255. blue:(arc4random()%255)/255. alpha:1].CGColor;
    
    for (UIView *view in views.subviews) {
        view.layer.borderWidth = 2;
        view.layer.borderColor = [UIColor colorWithRed:(arc4random()%255)/255. green:(arc4random()%255)/255. blue:(arc4random()%255)/255. alpha:1].CGColor;
        if (view.subviews.count != 0) {
            [self markerView:view];
        }
    }
}

/**
 *  获取自定义字体
 *
 *  @param path 路径
 *  @param size 大小
 *
 *  @return 自定义字体
 */
+ (UIFont*)customFontWithPath:(NSString*)path size:(CGFloat)size{
    NSURL *fontUrl = [NSURL fileURLWithPath:path];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    UIFont *font = [UIFont fontWithName:fontName size:size];
    CGFontRelease(fontRef);
    return font;
}

/**
 *  添加虚线框
 *
 *  @param view  视图
 *  @param color 颜色
 */
+ (void)addDotViewBorder:(UIView*)view color:(UIColor*)color{
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = view.bounds;
    borderLayer.position = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));

    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:5].CGPath;
    borderLayer.lineWidth = 3. / [[UIScreen mainScreen] scale];
    borderLayer.lineDashPattern = @[@8, @8];
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = color.CGColor;
    [view.layer addSublayer:borderLayer];
}

/**
 *  获取view的父tableViewCell
 *
 *  @param tView 视图
 *
 *  @return tableViewCell
 */
+ (UITableViewCell*)getSuperTableViewCellFromView:(UIView*)tView{
    UITableViewCell *cell;
    UIView *view = tView.superview;
    while (![view isKindOfClass:[UITableView class]]) {
        if ([view isKindOfClass:[UITableViewCell class]]) {
            cell = (UITableViewCell*)view;
            break;
        }else{
            view = view.superview;
        }
    }
    return cell;
}

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
                inSize:(CGSize)superSize{
    return [text boundingRectWithSize:superSize
                              options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:@{NSFontAttributeName: font}
                              context:nil].size;
}

/**
 *  根据颜色生成image
 *
 *  @param color 颜色
 *
 *  @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color{
    return [InterfaceTools imageWithColor:color size:CGSizeMake(6.f, 6.f)];
}

/**
 *  根据颜色和大小生成image
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return image
 */
+ (UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  获取当前控制器
 *
 *  @return 控制器
 */
+ (UIViewController *)getPresentedViewController{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController*)result selectedViewController];
    }else if ([result isKindOfClass:[UINavigationController class]]){
        result = [(UINavigationController*)result visibleViewController];
    }
    
    return result;
}

/**
 *  等比例缩放图片
 *
 *  @param size  大小
 *  @param image 图片
 *
 *  @return 图片
 */
+ (UIImage*)imageWithScaleToSize:(CGSize)size image:(UIImage*)image mode:(BOOL)isFill{
    
    CGFloat width = CGImageGetWidth(image.CGImage);
    CGFloat height = CGImageGetHeight(image.CGImage);
    
    if (image.imageOrientation == UIImageOrientationUp||
        image.imageOrientation == UIImageOrientationDown||
        image.imageOrientation == UIImageOrientationUpMirrored||
        image.imageOrientation == UIImageOrientationDownMirrored) {
        
    }else{
        CGSize s = size;
        size = CGSizeMake(s.height, s.width);
    }
    
    float verticalRadio = size.height/height;
    float horizontalRadio = size.width/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        if (isFill) {
            radio = verticalRadio < horizontalRadio ? horizontalRadio : verticalRadio;
        }else{
            radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
        }
        
    }
    else
    {
        if (!isFill) {
            radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
        }else{
            radio = verticalRadio > horizontalRadio ? verticalRadio : horizontalRadio;
        }
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    if (image.imageOrientation == UIImageOrientationUp||
        image.imageOrientation == UIImageOrientationDown||
        image.imageOrientation == UIImageOrientationUpMirrored||
        image.imageOrientation == UIImageOrientationDownMirrored) {
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(size);
        
        // 绘制改变大小的图片
        [image drawInRect:CGRectMake(xPos, yPos, width, height)];

        // 从当前context中创建一个改变大小后的图片
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        
        // 返回新的改变大小后的图片
        return scaledImage;
    }else{
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(CGSizeMake(size.height, size.width));
        
        // 绘制改变大小的图片
        [image drawInRect:CGRectMake(yPos, xPos, height, width)];
        
        // 从当前context中创建一个改变大小后的图片
        UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
        
        // 返回新的改变大小后的图片
        return scaledImage;
    }
}

/**
 *  获取字体对应高度
 *
 *  @param fontsize 字体大小
 *
 *  @return 高度
 */
+ (float)getHeightFromFontSize:(float)fontsize{
    return fontsize/72*96;
}

/**
 *  指定宽度自适应图片
 *
 *  @param img   图片
 *  @param width 宽度
 *
 *  @return 图片
 */
+ (UIImage*)scaleImage:(UIImage*)img withFixWidth:(float)width{
    return [UIImage imageWithCGImage:img.CGImage scale:img.size.width*img.scale/width orientation:img.imageOrientation];
}

/**
 *  指定高度自适应图片
 *
 *  @param img   图片
 *  @param height 宽度
 *
 *  @return 图片
 */
+ (UIImage*)scaleImage:(UIImage*)img withFixHeight:(float)height{
    return [UIImage imageWithCGImage:img.CGImage scale:img.size.height*img.scale/height orientation:img.imageOrientation];
}

/**
 *  合并图片
 *
 *  @param image1 背景图片
 *  @param image2 覆盖图片
 *  @param frame  frame
 *
 *  @return 图片
 */
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 frame:(CGRect)frame mode:(CGBlendMode)mode{
    UIGraphicsBeginImageContext(image1.size);
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    [image2 drawInRect:frame blendMode:mode alpha:1];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

/**
 *  合并图片
 *
 *  @param image1 图1
 *  @param image2 图2
 *
 *  @return 图
 */
+ (UIImage *)mergeImage:(UIImage*)image1 image2:(UIImage *)image2{
    
    if ((int)image1.size.width == (int)image2.size.width) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(image1.size.width, image1.size.height+image2.size.height),YES,image1.scale);
        [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
        [image2 drawInRect:CGRectMake(0, image1.size.height, image2.size.width, image2.size.height)];
    }else if ((int)image1.size.height == (int)image2.size.height){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(image1.size.width + image2.size.width, image1.size.height),YES,image1.scale);
        [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
        [image2 drawInRect:CGRectMake(image1.size.width, 0, image2.size.width, image2.size.height)];
    }else{
        return nil;
    }
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

@end


//
//  TableViewCell.m
//  MyText
//
//  Created by 张丹 on 16/12/20.
//  Copyright © 2016年 张丹. All rights reserved.
//

#import "TableViewCell.h"
#import "UIImageView+WebCache.h"
#import "InterfaceTools.h"
extern CGFloat Height;
@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


/**
 将内容显示在cell上

 @param model 每行的数据模型
 */
-(void)showDataInTableViewCell:(dataModel *)model{
    
    self.titleLab.text = model.Title;
    self.contentLab.text = model.Description;
    
    
    CGRect tempFrame =  CGRectMake(5, 0,self.contentView.frame.size.width-117-22, Height-self.titleLab.frame.size.height);
   self.titleLab.frame = [self frameFromeTextLableText:self.titleLab.text Frame:self.titleLab.frame Font:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
    
    self.contentLab.frame = [self frameFromeTextLableText:self.contentLab.text Frame:tempFrame Font:[UIFont systemFontOfSize:17.f]];
    
    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:model.ImageHref]];
    
    
    if ([model.Description length]!=0 &&![model.Description isKindOfClass:[NSNull class]]) {
       //有内容
        if (self.contentLab.frame.size.height >self.ImageHeight.constant) {
            //如果内容的高度大于图片的高度，则显示内容的高度
             Height = self.titleLab.frame.size.height+self.titleLab.frame.origin.y+self.contentLab.frame.size.height+self.contentLab.frame.origin.y;
        }else{
             //如果图片的高度大于内容的高度，则显示图片的高度
             Height = self.titleLab.frame.size.height+self.titleLab.frame.origin.y+self.ImageHeight.constant+self.ImageView.frame.origin.y+25;
        }
        
        
    }else{
        //没有内容
        if ([model.ImageHref length]==0 &&[model.ImageHref isKindOfClass:[NSNull class]]) {
            //没有图片，则显示标题的高度
            Height = self.titleLab.frame.size.height+self.titleLab.frame.origin.y;
            
        }else{
            //有图片，则显示图片的高度
            Height = self.titleLab.frame.size.height+self.titleLab.frame.origin.y+self.ImageHeight.constant+self.ImageView.frame.origin.y+25;
        }
       
    }
  
    
}

/**
 获取view的frame

 @param text  内容
 @param frame 初始frame
 @param font  view的字体

 @return frame
 */
-(CGRect)frameFromeTextLableText:(NSString *)text Frame:(CGRect)frame Font:(UIFont *)font{
    CGRect Frame = frame;
    
    Frame.size.height = [InterfaceTools sizeFromText:text withFont:font inSize:frame.size].height;
    
    return  Frame;
}

@end

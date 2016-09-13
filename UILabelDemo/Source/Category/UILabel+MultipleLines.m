//
//  UILabel+MultipleLines.m
//  UILabelDemo
//
//  Created by zhongpingjiang on 16/9/12.
//  Copyright © 2016年 shaoqing. All rights reserved.
//

#import "UILabel+MultipleLines.h"

@implementation UILabel (MultipleLines)

- (CGSize)setText:(NSString *)text lines:(NSInteger)lines andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)cSize{
    
    self.numberOfLines = lines;  //限定行数
    if (!text && text.length !=0) {
        return CGSizeZero;
    }
    
    CGSize textSize = [self.class sizeWithText:text lines:lines font:self.font andLineSpacing:lines constrainedToSize:cSize];

    if ([self p_isSingleLine:textSize.height font:self.font]) {
        lineSpacing = 0.0f;
    }
    
    //设置文字的属性
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    [self setAttributedText:attributedString];
    return CGSizeMake(textSize.width, textSize.height);
}

+ (CGSize)sizeWithText:(NSString *)text lines:(NSInteger)lines font:(UIFont*)font andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)cSize{
    
    if (!text && text.length !=0) {
        return CGSizeZero;
    }
    NSString *firstWord = [text substringToIndex:1];
    
    CGFloat oneRowHeight = [firstWord sizeWithAttributes:@{NSFontAttributeName:font}].height;
    CGSize textSize = [text boundingRectWithSize:cSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    CGFloat rows = textSize.height / oneRowHeight;
    CGFloat realHeight = oneRowHeight;
    // 0 不限制行数
    if (lines == 0) {
        if (rows >= 1) {
            realHeight = (rows * oneRowHeight) + (rows - 1) * lineSpacing;
        }
    }else{
        if (rows >= lines) {
            rows = lines;
        }
        realHeight = (rows * oneRowHeight) + (rows - 1) * lineSpacing;
    }
    return CGSizeMake(textSize.width, realHeight);
}

//单行的判断
- (BOOL)p_isSingleLine:(CGFloat)height font:(UIFont*)font{

    BOOL isSingle = NO;
    CGFloat oneRowHeight = [@"占位" sizeWithAttributes:@{NSFontAttributeName:font}].height;
    if (fabs(height - oneRowHeight)  < 0.001f) {
        isSingle = YES;
    }
    return isSingle;
}

@end

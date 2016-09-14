//
//  UILabel+MultipleLines.m
//  UILabelDemo
//
//  Created by zhongpingjiang on 16/9/12.
//  Copyright © 2016年 shaoqing. All rights reserved.
//

#import "UILabel+MultipleLines.h"
#import <objc/runtime.h>
#import "QSShowTextCellConfig.h"


@implementation UILabel (MultipleLines)

- (BOOL)isSingleLine{

    return [objc_getAssociatedObject(self, @selector(isSingleLine)) boolValue];
}

- (void)setSingleLine:(BOOL)isSingleLine{

    objc_setAssociatedObject(self, @selector(isSingleLine), [NSNumber numberWithBool:isSingleLine], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setTextSize:(CGSize)textSize{

    objc_setAssociatedObject(self, @selector(textSize), [NSValue valueWithCGSize:textSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)textSize{

    return [objc_getAssociatedObject(self, @selector(textSize)) CGSizeValue];
}

- (CGSize)setText:(NSString *)text lines:(NSInteger)lines andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)cSize{
    
    self.numberOfLines = lines;  //限定行数
    if (!text && text.length !=0) {
        return CGSizeZero;
    }
    
    self.textSize = [self.class sizeWithText:text lines:lines font:self.font andLineSpacing:lines constrainedToSize:cSize];
    
    if ([self p_isSingleLine:self.textSize.height font:self.font]) {
        lineSpacing = 0.0f;
        [self setSingleLine:YES];
    }else{
        [self setSingleLine:NO];
    }
    
    //设置文字的属性
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    [self setAttributedText:attributedString];
    return CGSizeMake(self.textSize.width, self.textSize.height);
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

+ (CGSize)realSizeWithText:(NSString *)text lines:(NSInteger)lines font:(UIFont*)font andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)cSize{

    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:QSTextFontSize];
    CGSize textSize = [label setText:text lines:lines andLineSpacing:lineSpacing constrainedToSize:cSize];
    label.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
    [label adjustLabelContent];
    return label.frame.size;
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

- (void)adjustLabelContent{

    if (self.isSingleLine) {
        [self sizeThatFits:self.textSize];//固定原始label的大小，避免文本太多，单行显示时超出label size
    }else{
        [self sizeToFit]; //调整label的宽和高，使它根据字符串的大小做合适的改变,避免多行显示时文本不从顶部往下排版
    }
    NSLog(@"testSize = %@, size = %@",NSStringFromCGSize(self.textSize),NSStringFromCGSize(self.frame.size));
}

@end

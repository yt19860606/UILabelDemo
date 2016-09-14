//
//  UILabel+MultipleLines.h
//  UILabelDemo
//
//  Created by zhongpingjiang on 16/9/12.
//  Copyright © 2016年 shaoqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MultipleLines)

/**
 *  文本是一行就能显示
 */
@property (nonatomic,assign,setter=setSingleLine:)BOOL isSingleLine;

@property (nonatomic,assign)CGSize textSize;


/**
 *  设置文本多行可控间距显示
 *
 *  @param text        文本
 *  @param lines       行数，lines = 0不限制行数
 *  @param lineSpacing 行间距
 *  @param cSize       文本显示的最大区域
 *
 *  @return 文本占用的size
 */


- (CGSize)setText:(NSString *)text lines:(NSInteger)lines andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)cSize;


/**
 *  计算文本占用的size
 *
 *  @param text        文本
 *  @param lines       行数，lines = 0不限制行数
 *  @param font        字体类型
 *  @param lineSpacing 行间距
 *  @param cSize       文本显示的最大区域
 *
 *  @return 文本占用的size
 */
+ (CGSize)sizeWithText:(NSString *)text lines:(NSInteger)lines font:(UIFont*)font andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)cSize;

+ (CGSize)realSizeWithText:(NSString *)text lines:(NSInteger)lines font:(UIFont*)font andLineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)cSize;

- (void)adjustLabelContent;

@end

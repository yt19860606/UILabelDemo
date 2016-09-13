//
//  QSShowTextCell.h
//  UILabelDemo
//
//  Created by zhongpingjiang on 16/9/12.
//  Copyright © 2016年 shaoqing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface QSShowTextCell : SWTableViewCell

- (void)layoutSubviewsWithText:(NSString *)text;

+ (CGFloat)cellHeightWithText:(NSString *)text;

@end

//
//  QSShowTextCell.m
//  UILabelDemo
//
//  Created by zhongpingjiang on 16/9/12.
//  Copyright © 2016年 shaoqing. All rights reserved.
//

#import "QSShowTextCell.h"
#import "UILabel+MultipleLines.h"
#import "QSShowTextCellConfig.h"

@interface QSShowTextCell()

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *contentLabel;

@end


@implementation QSShowTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (UILabel *)titleLabel{

    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 16)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{

    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.font = [UIFont systemFontOfSize:QSTextFontSize];
        _contentLabel.textColor = [UIColor blackColor];
    }
    return _contentLabel;
}

- (void)layoutSubviewsWithText:(NSString *)text{

    _titleLabel.text = @"DESCRIPTION";
    
    CGSize textSize = [_contentLabel setText:text lines:QSTextDefaultLines andLineSpacing:QSTextLineSpacing constrainedToSize:QSTextConstrainedSize];
    _contentLabel.frame = CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame) + 10, textSize.width, textSize.height);
    [_contentLabel sizeToFit];
    
    _contentLabel.layer.borderColor = [UIColor redColor].CGColor;
    _contentLabel.layer.borderWidth = 1;
}

+ (CGFloat)cellHeightWithText:(NSString *)text{

    return [UILabel sizeWithText:text
                           lines:QSTextDefaultLines
                            font:[UIFont systemFontOfSize:QSTextFontSize]
                  andLineSpacing:QSTextLineSpacing
               constrainedToSize:QSTextConstrainedSize].height + 41;

}


@end

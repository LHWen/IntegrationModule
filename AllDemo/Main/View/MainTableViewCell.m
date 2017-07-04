//
//  MainTableViewCell.m
//  AllDemo
//
//  Created by yuhui on 16/12/27.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self p_setupInitCell];
    }
    return self;
}

- (void)p_setupInitCell {
    
    if (!_titleLable) {
        _titleLable = [CreateViewFactory p_setLableClearBGColorOneLineText:_titleLable.text
                                                                  textFont:15
                                                                 textColor:[UIColor blackColor]
                                                             textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_titleLable];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

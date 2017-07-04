//
//  HWFoldHeaderView.m
//  TableViewFolding
//
//  Created by yuhui on 16/8/25.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "HWFoldHeaderView.h"

@interface HWFoldHeaderView()

@end

@implementation HWFoldHeaderView {
    
    BOOL _created;            /** 是否创建过 */
    UILabel *_titleLabel;     /** 标题 */
    UILabel *_detailLabel;    /** 其他内容 */
    UIImageView *_imageView;  /** 图标 */
    UIButton *_btn;           /** 收起按钮 */
    BOOL _canFold;            /** 是否可展开 */
}

- (void)setFoldSectionHeaderViewWithTitle:(NSString *)title detail:(NSString *)detail type:(HerderStyle)type section:(NSInteger)section canFold:(BOOL)canFold width:(CGFloat)width{
    if (!_created) {
        [self creatUIWidth:width];
    }
    _titleLabel.text = title;
    if (type == HerderStyleNone) {
        _detailLabel.hidden = YES;
    } else {
        _detailLabel.hidden = NO;
        _detailLabel.attributedText = [self attributeStringWith:detail];
    }
    _section = section;
    _canFold = canFold;
    if (canFold) {
        _imageView.hidden = NO;
    } else {
        _imageView.hidden = YES;
    }
}

- (NSMutableAttributedString *)attributeStringWith:(NSString *)money {
    NSString *str = [NSString stringWithFormat:@"应收合计:%@", money];
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = [str rangeOfString:money];
    
    [ats setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range];
    
    return ats;
}

- (void)creatUIWidth:(CGFloat)width {
    _created = YES;
    
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 130, 30)];
    _titleLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_titleLabel];
    
    //其他内容
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(145, 5, width-40, 30)];
    _detailLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_detailLabel];
    
    //按钮
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(0, 0, width, 30);
    [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_btn];
    
    //图片
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width - 30, 15, 8, 9)];
    _imageView.image = [UIImage imageNamed:@"arrow_down_gray"];
    [self.contentView addSubview:_imageView];
    
    //线
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, width, 1)];
    line.image = [UIImage imageNamed:@"line"];
    [self.contentView addSubview:line];
}

- (void)setFold:(BOOL)fold {
    _fold = fold;
    if (fold) {
        _imageView.image = [UIImage imageNamed:@"arrow_down_gray"];
    } else {
        _imageView.image = [UIImage imageNamed:@"arrow_up_gray"];
    }
}

#pragma mark = 按钮点击事件
- (void)btnClick:(UIButton *)btn {
    if (_canFold) {
        if ([self.delegate respondsToSelector:@selector(foldHeaderSection:)]) {
            [self.delegate foldHeaderSection:_section];
        }
    }
}


@end

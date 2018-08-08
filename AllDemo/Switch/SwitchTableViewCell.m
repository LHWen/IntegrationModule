//
//  SwitchTableViewCell.m
//  AllDemo
//
//  Created by LHWen on 2018/8/8.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "SwitchTableViewCell.h"

@interface SwitchTableViewCell()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UISwitch *rSwitch;

@end

@implementation SwitchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self p_setupLayout];
    }
    return self;
}

- (void)setTitleStr:(NSString *)titleStr {
    
    _titleStr = [titleStr copy];
    if (_titleStr.length > 0) {
        _titleLbl.text = _titleStr;
        [_titleLbl setNeedsDisplay];
    }
}

- (void)setIndexRow:(NSInteger)indexRow {
    
    _indexRow = indexRow;
}

- (void)setIsOpen:(BOOL)isOpen {
    
    _isOpen = isOpen;
    [_rSwitch setOn:isOpen animated:YES];
    [_rSwitch setNeedsDisplay];
}

- (void)p_setupLayout {
    
    [self p_setTitleLableLayout];
    [self p_setSwitchLayout];
}

- (void)p_setTitleLableLayout {
    
    if (!_titleLbl) {
        _titleLbl = [CreateViewFactory p_setLableWhiteBGColorOneLineLeftText:@"" textFont:15.0f textColor:[UIColor blackColor]];
        [self.contentView addSubview:_titleLbl];
        [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@13.0f);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
}

- (void)p_setSwitchLayout {
    
    if (!_rSwitch) {
        _rSwitch = [[UISwitch alloc] init];
        // 开关color
        _rSwitch.tintColor = [UIColor grayColor]; // 关闭状态下color
        _rSwitch.onTintColor = [UIColor greenColor]; // 开启状态下color
        _rSwitch.thumbTintColor = [UIColor orangeColor]; // 滑块color
        // size 放缩
        _rSwitch.transform = CGAffineTransformMakeScale(1.0, 1.0);
        _rSwitch.on = YES;
//        [_rSwitch setOn:YES animated:YES];
        [_rSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_rSwitch];
        [_rSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-13.0f));
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
}

- (void)switchAction:(UISwitch *)sender {
    
    if (_rSwitch.on) {
        NSLog(@"%ld row switch is open", _indexRow);
    } else {
        NSLog(@"%ld row switch is off", _indexRow);
    }
    
    self.completion(_indexRow, _rSwitch.on);
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

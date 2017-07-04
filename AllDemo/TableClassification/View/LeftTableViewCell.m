//
//  LeftTableViewCell.m
//  testTableViewGroup
//
//  Created by yuhui on 16/8/24.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "LeftTableViewCell.h"

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface LeftTableViewCell()

@property (nonatomic, strong) UIView *redView;

@end

@implementation LeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 40)];
        self.name.numberOfLines = 0;
        self.name.font = [UIFont systemFontOfSize:14];
        self.name.textColor = rgba(130, 130, 130, 1.0);
        self.name.highlightedTextColor = [UIColor redColor];
        [self.contentView addSubview:self.name];
        
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(0, 6, 2, 40)];
        self.redView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.redView];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [UIColor colorWithWhite:0 alpha:0.1];
    self.highlighted = selected;
    self.name.highlighted = selected;
    self.redView.hidden = !selected;
}

@end

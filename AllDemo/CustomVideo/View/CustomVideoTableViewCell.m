//
//  CustomVideoTableViewCell.m
//  AllDemo
//
//  Created by LHWen on 2018/1/5.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "CustomVideoTableViewCell.h"
//#import "UIImageView+WebCache.h"
#import "VideoItemModel.h"

@interface CustomVideoTableViewCell ()

@property (nonatomic, strong) UIView *contentbgView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIView *coverBGView;
@property (nonatomic, strong) UIImageView *coverImgView;
@property (nonatomic, strong) UIImageView *playerImgView;

@end

@implementation CustomVideoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self p_setup];
        return self;
    }
    return nil;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    
    _indexPath = indexPath;
}

- (void)setItemModel:(VideoItemModel *)itemModel {
    
    _itemModel = itemModel;
    self.titleLable.text = _itemModel.title;
    [self.coverImgView sd_setImageWithURL:[NSURL URLWithString:_itemModel.cover]];
    
    [self.contentView setNeedsDisplay];
    [self.contentView setNeedsLayout];
}

- (void)p_setup {
    
    [self p_setupContentView];
    [self p_setupTitleLable];
    [self p_setupCoverBackGroundView];
    [self p_setupCoverImageView];
}

- (void)p_setupContentView {
    
    if (!_contentbgView) {
        _contentbgView = [CreateViewFactory p_setViewBGColor:[UIColor whiteColor]];
        [self.contentView addSubview:_contentbgView];
        [_contentbgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
}

- (void)p_setupTitleLable {
    
    if (!_titleLable) {
        _titleLable = [CreateViewFactory p_setLableWhiteBGColorOneLineLeftText:@"" textFont:15.0f textColor:[UIColor blackColor]];
        [self.contentView addSubview:_titleLable];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@13.0f);
            make.right.equalTo(@(-13.0f));
        }];
    }
}

- (void)p_setupCoverBackGroundView {
    
    if (!_coverBGView) {
        _coverBGView = [CreateViewFactory p_setViewBGColor:[UIColor whiteColor]];
        _coverBGView.frame = CGRectMake(0, 44.0f, kSCREENWIDTH, 120);
        [self.contentView addSubview:_coverBGView];
    }
}

- (void)p_setupCoverImageView {
    
    if (!_coverImgView) {
        
        _coverImgView = [CreateViewFactory p_setImageViewScaleAspectFillImageName:@""];
        _coverImgView.userInteractionEnabled = YES;
        [_coverImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageViewTap:)]];
        _coverImgView.frame = CGRectMake(13.0f, 0, kSCREENWIDTH - 26.0f, 120.0f);
        [_coverBGView addSubview:_coverImgView];
        
        _playerImgView = [CreateViewFactory p_setImageViewScaleAspectFitImageName:@"ImageResources.bundle/play"];
        _playerImgView.userInteractionEnabled = YES;
        [_playerImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageViewTap:)]];
        [_coverBGView addSubview:_playerImgView];
        [_playerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(_coverBGView);
        }];
    }
}

- (void)coverImageViewTap:(UITapGestureRecognizer *)recognizer {
    
    CGRect imgFrame = CGRectMake(13.0f, 44.0f, kSCREENWIDTH - 26.0f, 120.0f);
    self.customVideoBlock(_indexPath, imgFrame);
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

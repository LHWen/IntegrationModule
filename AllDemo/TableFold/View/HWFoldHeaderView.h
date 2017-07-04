//
//  HWFoldHeaderView.h
//  TableViewFolding
//
//  Created by yuhui on 16/8/25.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HerderStyle) {
    
    HerderStyleNone,
    HerderStyleTotal
};

@protocol HWFoldSectionHeaderViewDelegate <NSObject>

- (void)foldHeaderSection:(NSInteger)SectionHeader;

@end

@interface HWFoldHeaderView : UITableViewHeaderFooterView

/** 是否折叠 */
@property (nonatomic, assign) BOOL fold;

/** 选择的Section */
@property (nonatomic, assign) NSInteger section;

/** 代理 */
@property (nonatomic, weak) id<HWFoldSectionHeaderViewDelegate> delegate;


/** 调用方法 */
- (void)setFoldSectionHeaderViewWithTitle:(NSString *)title detail:(NSString *)detail type:(HerderStyle)type section:(NSInteger)section canFold:(BOOL)canFold width:(CGFloat)width;

@end

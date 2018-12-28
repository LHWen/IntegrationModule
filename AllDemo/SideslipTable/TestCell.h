//
//  TestCell.h
//  AllDemo
//
//  Created by LHWen on 2018/12/11.
//  Copyright © 2018 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestCell : UITableViewCell

/**标记左滑菜单是否打开*/
@property(nonatomic,assign,readonly)BOOL isOpen;
/**测试文字*/
@property(nonatomic,strong)UILabel *testLb;
/**取消关注的回调*/
@property(nonatomic,copy)void (^cancelCallBack)();
/**删除的回调*/
@property(nonatomic,copy)void (^deleteCallBack)();
/***左后滑动的回调*/
@property(nonatomic,copy)void (^swipCallBack)();



/**
 *  关闭左滑菜单
 *  completionHandle 完成后的回调
 */
- (void)closeMenuWithCompletionHandle:(void (^)(void))completionHandle;

@end

NS_ASSUME_NONNULL_END

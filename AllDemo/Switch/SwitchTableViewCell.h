//
//  SwitchTableViewCell.h
//  AllDemo
//
//  Created by LHWen on 2018/8/8.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SwitchCompletion)(NSInteger row,  BOOL isOpen);

@interface SwitchTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, assign) NSInteger indexRow;
@property (nonatomic, assign) BOOL isOpen;

@property (nonatomic, copy) SwitchCompletion completion;


@end

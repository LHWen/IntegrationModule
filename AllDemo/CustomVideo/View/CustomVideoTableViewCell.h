//
//  CustomVideoTableViewCell.h
//  AllDemo
//
//  Created by LHWen on 2018/1/5.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoItemModel;

typedef void(^CustomVideoBlock)(NSIndexPath *index, CGRect imgFrame);

@interface CustomVideoTableViewCell : UITableViewCell

@property (nonatomic, strong) VideoItemModel *itemModel;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) CustomVideoBlock customVideoBlock;

@end

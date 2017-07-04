//
//  DateView.h
//  AllDemo
//
//  Created by yuhui on 17/1/17.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateViewDelegate <NSObject>

- (void)cancelChoose;

- (void)sureChooseTimeString:(NSString *)timeString;

@end

@interface DateView : UIView

@property (nonatomic, weak) id<DateViewDelegate> delegate;

@end

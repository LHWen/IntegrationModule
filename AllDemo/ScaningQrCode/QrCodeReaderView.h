//
//  QrCodeReaderView.h
//  AllDemo
//
//  Created by LHWen on 2018/2/24.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QrCodeReaderViewDelegate <NSObject>

- (void)readerScanResult:(NSString *)result;

@end

@interface QrCodeReaderView : UIView

@property(nonatomic, weak) id<QrCodeReaderViewDelegate>delegate;
@property(nonatomic, copy) UIImageView * readLineView;
@property(nonatomic, assign) BOOL is_Anmotion;
@property(nonatomic, assign) BOOL is_AnmotionFinished;

// 开启扫描
- (void)start;
// 关闭扫描
- (void)stop;
// 初始化扫描线
- (void)loopDrawLine;

@end

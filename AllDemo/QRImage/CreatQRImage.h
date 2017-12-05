//
//  CreatQRImage.h
//  AllDemo
//
//  Created by LHWen on 2017/9/4.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreatQRImage : NSObject

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize;

+ (UIImage *)qrCodeString:(NSString *)string;

+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

+ (UIImage *)colorQrcodeImage;

@end

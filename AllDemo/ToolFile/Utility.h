//
//  Utility.h
//  SrvMgr
//
//  Created by yuhui on 16/8/31.
//  Copyright © 2016年 since2006. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject

/** 十六进制颜色转换 */
+(UIColor *) colorWithHexString: (NSString *) stringToConvert;

/** 颜色转化为图片 */
+ (UIImage*) createImageWithColor: (UIColor*) color;

@end

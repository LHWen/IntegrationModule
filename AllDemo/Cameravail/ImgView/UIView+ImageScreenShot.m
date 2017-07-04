//
//  UIView+ImageScreenShot.m
//  AllDemo
//
//  Created by yuhui on 17/2/8.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "UIView+ImageScreenShot.h"

@implementation UIView (ImageScreenShot)

- (UIImage *)imageScreenShot {
    
    UIGraphicsBeginImageContext(self.frame.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end

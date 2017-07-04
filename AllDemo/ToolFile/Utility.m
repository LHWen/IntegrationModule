//
//  Utility.m
//  SrvMgr
//
//  Created by yuhui on 16/8/31.
//  Copyright © 2016年 since2006. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    UIColor *DEFAULT_VOID_COLOR = [UIColor lightGrayColor];
    
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 8 characters
    if ([cString length] == 8)
    {
        return DEFAULT_VOID_COLOR;
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.length = 2;
    
    if (cString.length == 8)
        range.location = 2;
    else
        range.location = 0;
    
    NSString *rString = [cString substringWithRange:range];
    
    if (cString.length == 8)
        range.location = 4;
    else
        range.location = 2;
    
    NSString *gString = [cString substringWithRange:range];
    
    if (cString.length == 8)
        range.location = 6;
    else
        range.location = 4;
    
    NSString *bString = [cString substringWithRange:range];
    
    range.location = 0;
    if (cString.length == 6)
        cString = [NSString stringWithFormat:@"FF%@", cString];
    
    NSString *aString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b, a;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:((float) a / 255.0f)];
}


+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end

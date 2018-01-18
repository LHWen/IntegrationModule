//
//  CalculateTextHeight.m
//  tudou
//
//  Created by hufayou on 6/3/15.
//  Copyright (c) 2015 hufayou. All rights reserved.
//

#import "CalculateTextHeight.h"

@implementation CalculateTextHeight

+ (CGFloat)calculateTextHeightWithText:(NSString *)text withWidth:(CGFloat)width andTextSize:(CGFloat)size
{
    NSRange fullRange = NSMakeRange(0, text.length);
    NSMutableParagraphStyle *pstyle = [[NSMutableParagraphStyle alloc] init];
    pstyle.lineBreakMode = NSLineBreakByCharWrapping;
    pstyle.alignment = NSTextAlignmentLeft;
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:text];
    [attriString addAttribute:NSParagraphStyleAttributeName value:pstyle range:fullRange];
    [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:fullRange];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:fullRange];
    
    CGRect r = [attriString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    return r.size.height += 15;
}

+ (CGFloat)getSpaceTextHeight:(NSString*)string withFontSize:(CGFloat)fontSize andWidth:(CGFloat)width andMaxHeight:(CGFloat)maxHeight andLineSpacing:(CGFloat)spacing
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = spacing; //设置行间距
    paraStyle.hyphenationFactor = 0.0; //传说是指定用连字符号连接的门槛。有效值躺在0.0和1.0之间包容（目前没有发现其作用）
    paraStyle.firstLineHeadIndent = 0.0; //首行缩进距离
    paraStyle.paragraphSpacingBefore = 0.0; //改变段落之间的距离
    paraStyle.headIndent = 0.0; //头部缩进 距离
    paraStyle.tailIndent = 0.0; //大于0 将会显示竖直方向的文字
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
}

@end

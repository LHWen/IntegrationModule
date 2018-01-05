//
//  VideoItemModel.h
//  AllDemo
//
//  Created by LHWen on 2018/1/5.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoItemModel : NSObject

@property (nonatomic, copy) NSString *title;    // 标题
@property (nonatomic, copy) NSString *mp4_url;  // 视频地址
@property (nonatomic, copy) NSString *cover;    // 背景图地址

@end

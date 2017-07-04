//
//  VoiceViewController.h
//  AllDemo
//
//  Created by yuhui on 16/12/27.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VoiceType) {
    
    VoiceTypeAgainRecord = 1001,   /* 重录 */
    VoiceTypeRecording   = 1002,   /* 录制 */
    VoiceTypeStopRecord  = 1003,   /* 停止录制 */
    VoiceTypePlayerVoice = 1004,   /* 播放语音 */
    VoiceTypeSendVoice   = 1005,   /* 上传语音 */
};

@interface VoiceViewController : UIViewController

@end

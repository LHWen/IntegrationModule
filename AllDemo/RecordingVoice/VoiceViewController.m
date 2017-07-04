//
//  VoiceViewController.m
//  AllDemo
//
//  Created by yuhui on 16/12/27.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "VoiceViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface VoiceViewController () <AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (nonatomic, strong) UIButton *againRecord;    // 重录按钮
@property (nonatomic, strong) UIButton *recording;      // 开始录制和暂停录制
@property (nonatomic, strong) UIButton *stopRecord;     // 停止（完成）录制
@property (nonatomic, strong) UIButton *playerVoice;    // 播放语音和暂停播放
@property (nonatomic, strong) UIButton *sendVoice;      // 上传语音

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;   // 音频录音机
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;       // 音频播放 用于播放录音文件

@end

@implementation VoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"语音";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    [self p_setButtonView];
    
    [self setAudioSession];
    
    //添加近距离事件监听，添加前先设置为YES，如果设置完后还是NO的读话，说明当前设备没有近距离传感器
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([UIDevice currentDevice].proximityMonitoringEnabled == YES) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sensorStateChange:)name:UIDeviceProximityStateDidChangeNotification object:nil];
    }
}

#pragma mark - 处理近距离监听触发事件
-(void)sensorStateChange:(NSNotificationCenter *)notification;
{
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗（省电啊）
    if ([[UIDevice currentDevice] proximityState] == YES) {
        //黑屏
        NSLog(@"Device is close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        
    } else {
        //没黑屏幕
        NSLog(@"Device is not close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//        if (!self.audioPlayer.playing) { // 没有播放了，也没有在黑屏状态下，就可以把距离传感器关了
//            [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
//        }
    }
}

/**------创建按钮------*/
- (void)p_setButtonView {
    _againRecord = [self setButtonTitle:@"重录" SelectedTitle:nil Tag:VoiceTypeAgainRecord NormalColor:[UIColor greenColor] SelectColor:[UIColor orangeColor]];
    _againRecord.frame = CGRectMake(10, 200, 80, 60);
    
    _recording = [self setButtonTitle:@"录制" SelectedTitle:nil Tag:VoiceTypeRecording NormalColor:[UIColor orangeColor] SelectColor:[UIColor blueColor]];
    _recording.frame = CGRectMake(110, 200, 100, 60);
    
    _stopRecord = [self setButtonTitle:@"完成" SelectedTitle:nil Tag:VoiceTypeStopRecord NormalColor:[UIColor greenColor] SelectColor:[UIColor blueColor]];
    _stopRecord.frame = CGRectMake(230, 200, 80, 60);
    
    _playerVoice = [self setButtonTitle:@"播放" SelectedTitle:nil Tag:VoiceTypePlayerVoice NormalColor:[UIColor greenColor] SelectColor:[UIColor orangeColor]];
    _playerVoice.frame = CGRectMake(20, 300, 100, 60);
    
    _sendVoice = [self setButtonTitle:@"上传" SelectedTitle:nil Tag:VoiceTypeSendVoice NormalColor:[UIColor greenColor] SelectColor:[UIColor orangeColor]];
    _sendVoice.frame = CGRectMake(140, 300, 100, 60);
    
    [self.view addSubview:_againRecord];
    [self.view addSubview:_recording];
    [self.view addSubview:_stopRecord];
    [self.view addSubview:_playerVoice];
    [self.view addSubview:_sendVoice];
    
    [self p_hiddenPlayerAndSendVoiceIsShow:YES];
    
}

- (UIButton *)setButtonTitle:(NSString *)title
               SelectedTitle:(NSString *)selectTitlt
                         Tag:(VoiceType)buttonTag
                 NormalColor:(UIColor *)normalColor
                 SelectColor:(UIColor *)selecetCoror {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = buttonTag;
    [button setTitle:title forState:UIControlStateNormal];
    if (selectTitlt.length > 0) {
        [button setTitle:selectTitlt forState:UIControlStateSelected];
    }
    [button setBackgroundImage:[Utility createImageWithColor:normalColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[Utility createImageWithColor:selecetCoror] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/** 设置是否隐藏播放与上传按钮 */
- (void)p_hiddenPlayerAndSendVoiceIsShow:(BOOL)isShow {
    _playerVoice.hidden = isShow;
    _sendVoice.hidden = isShow;
    _playerVoice.userInteractionEnabled = YES;
    _sendVoice.userInteractionEnabled = YES;
}

/**---------点击事件集中处理------*/
- (void)buttonClick:(UIButton *)button {
    
    switch (button.tag) {
        case VoiceTypeAgainRecord:{ // 重录 删除语音文件路径 隐藏播放和发送按钮，开启录制与完成按钮交互
            
            [self removeFile];
            
            [self p_hiddenPlayerAndSendVoiceIsShow:YES];
            _recording.userInteractionEnabled = YES;
            _stopRecord.userInteractionEnabled = YES;
            [_recording setTitle:@"录制" forState:UIControlStateNormal];
            break;
        }
        case VoiceTypeRecording:{ // 录制  继续录制
            
            button.selected = !button.selected;
            if (button.selected) {
                
                [_recording setTitle:@"录制ing" forState:UIControlStateNormal];
                if (![self.audioRecorder isRecording]) { // 首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
                    [self.audioRecorder record];
                   // NSLog(@"录制语音");
                }
            }else {
                
                [_recording setTitle:@"暂停" forState:UIControlStateNormal];
                if ([self.audioRecorder isRecording]) { // 暂停录制
                    [self.audioRecorder pause];
                   // NSLog(@"暂停录制语音");
                }
            }
            break;
        }
        case VoiceTypeStopRecord: { // 结束录制   先暂停录制 然后调用录制结束代理
            
            [self p_hiddenPlayerAndSendVoiceIsShow:NO];
            [_playerVoice setTitle:@"播放" forState:UIControlStateNormal];
            [self.audioRecorder stop];
            // NSLog(@"结束");
            break;
        }
        case VoiceTypePlayerVoice: {
            
            button.selected = !button.selected;
            if (button.selected) {
                
                [_playerVoice setTitle:@"播放ing" forState:UIControlStateNormal];
                if (![self.audioPlayer isPlaying]) {
                    [self.audioPlayer play];
                    //NSLog(@"播放ing");
                }else {
                    _playerVoice.selected = YES;
                }
            }else {
                
                [_playerVoice setTitle:@"暂停" forState:UIControlStateNormal];
                [self.audioPlayer stop];
                //NSLog(@"停止播放");
            }
            break;
        }
        case VoiceTypeSendVoice:{ // 上传语音 所有按钮关闭用户交互
            
//            [self p_setButtonUserInteractionEnabled:NO];  // Demo测试不开启
            [self uploadFile];
            break;
        }
            
        default:
            break;
    }

    
}

// 是否开启用户交互
- (void)p_setButtonUserInteractionEnabled:(BOOL)open {
    
    _recording.userInteractionEnabled   = open;
    _stopRecord.userInteractionEnabled  = open;
    _againRecord.userInteractionEnabled = open;
    _playerVoice.userInteractionEnabled = open;
    _sendVoice.userInteractionEnabled   = open;
}

#pragma mark -- 语音 -------

/**
 *  设置音频会话
 */
- (void)setAudioSession {
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}

/**
 *  取得录音文件保存路径
 *
 *  @return 录音文件路径
 */
- (NSURL *)getSavePath {
    NSString *urlString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //    urlString = [urlString stringByAppendingPathComponent:@"myRecord.caf"];  //wav
    urlString = [urlString stringByAppendingPathComponent:@"myRecord.wav"];
    NSLog(@"file path:%@", urlString);
    NSURL *url = [NSURL fileURLWithPath:urlString];
    NSLog(@"file URL:%@", url);
    
    return url;
}

- (NSString *)getPath {
    NSString *urlString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //    urlString = [urlString stringByAppendingPathComponent:@"myRecord.caf"];
    urlString = [urlString stringByAppendingPathComponent:@"myRecord.wav"];
    
    return urlString;
}

//删除文件夹及文件级内的文件
- (void)removeFolderWithPath:(NSString *)path
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:path];
    
    if (!blHave) {
        NSLog(@"不存在");
        return ;
    }else {
        NSLog(@"存在");
        BOOL blDele= [fileManager removeItemAtPath:[self getPath] error:nil];
        if (blDele) {
            NSLog(@"删除成功");
        }else {
            NSLog(@"删除失败");
        }
    }
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
- (NSDictionary *)getAudioSetting {
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    // 设置录音格式
    [dictM setObject:[NSNumber numberWithInt: kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    // 设置录音采样率，8000是电话采样率，对于一般录音已经够了
    // 设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）, 采样率必须要设为11025才能使转化成mp3格式后不会失真
    [dictM setObject:[NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];
    // 设置通道，这里采用单声道 1 或 2 ，要转换成mp3格式必须为双通道
    [dictM setObject:@2 forKey:AVNumberOfChannelsKey];
    // 每个采样点位数,分为8、16、24、32
    [dictM setObject:@16 forKey:AVLinearPCMBitDepthKey];
    // 是否使用浮点数采样
    [dictM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    
    return dictM;
}

/**----检查麦克风是否可用-----*/
- (BOOL)checkMicrophoneAvailability{
    __block BOOL ret = NO;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if ([session respondsToSelector:@selector(requestRecordPermission:)]) {
        [session performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            ret = granted;
        }];
    } else {
        ret = YES;
    }
    
    return ret;
}

/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
- (AVAudioRecorder *)audioRecorder{
    
    if (!_audioRecorder) {
        
        if (![self checkMicrophoneAvailability]) {
            NSLog(@"麦克风不可用");
            return  nil;
        }
        
        // 创建录音文件保存路径
        NSURL *url = [self getSavePath];
        // 创建录音格式设置
        NSDictionary *setting = [self getAudioSetting];
        // 创建录音机
        NSError *error = nil;
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate = self;
        _audioRecorder.meteringEnabled = YES; // 如果要监控声波则必须设置为YES
        
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    
    return _audioRecorder;
}

/**
 *  创建播放器
 *
 *  @return 播放器
 */
- (AVAudioPlayer *)audioPlayer{
    
    if (!_audioPlayer) {
        NSString *filePath = [self getPath];
        NSData *fileData = [[NSData data] initWithContentsOfFile:filePath];   // 使用NSData数据进行播放
        NSError *error = nil;
        _audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:&error];
        _audioPlayer.delegate = self;
        _audioPlayer.numberOfLoops = 0;
        [_audioPlayer prepareToPlay];  // 准备播放
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}

#pragma mark - 录音机代理方法
/**
 *  录音完成，录音完成后播放录音
 *
 *  @param recorder 录音机对象
 *  @param flag     是否成功
 */
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    
    NSLog(@"录音完成!");
    [self p_hiddenPlayerAndSendVoiceIsShow:NO];
}

#pragma mark -- AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"%s", __func__);
    self.audioPlayer.delegate = nil;
    self.audioPlayer = nil;
    
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error{
    NSLog(@"%@", error);
}


/** ------删除文件-------- */
- (void)removeFile {
    
    NSLog(@"delete");
    [self removeFolderWithPath:[self getPath]];
    _audioRecorder.delegate = nil;
    _audioRecorder = nil;
    _audioPlayer.delegate = nil;
    _audioPlayer = nil;
}

#pragma mark - 上传语音
- (void)uploadFile {
    
    NSString *url = @"http://192.168.1.43:8899/zj_app/order/zj_v1/uploadVoice?id=1";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"image/jpeg", nil];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData)  {
        
        //              application/octer-stream   audio/mpeg video/mp4   application/octet-stream
        /* url      :  本地文件路径
         * name     :  与服务端约定的参数
         * fileName :  自己随便命名的
         * mimeType :  文件格式类型 [mp3 : application/octer-stream application/octet-stream] [mp4 : video/mp4]
         */
        
        NSString *filePath = [self getPath];
        NSData *fileData = [[NSData data] initWithContentsOfFile:filePath];   // 使用NSData数据进行播放
        [formData appendPartWithFileData:fileData
                                    name:@"voice"
                                fileName:@"myVideo.mp3"
                                mimeType:@"application/octet-stream"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        float progress = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        NSLog(@"上传进度-----   %f",progress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        [self p_setButtonUserInteractionEnabled:YES];  // 上传成功后开启所有按钮交互
        NSLog(@"上传成功 %@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败 %@",error);
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self removeFile];
    
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];  // 关闭传感器
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

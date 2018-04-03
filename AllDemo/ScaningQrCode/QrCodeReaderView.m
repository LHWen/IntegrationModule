//
//  QrCodeReaderView.m
//  AllDemo
//
//  Created by LHWen on 2018/2/24.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "QrCodeReaderView.h"
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>

#define Height [UIScreen mainScreen].bounds.size.height
#define Width  [UIScreen mainScreen].bounds.size.width
#define XCenter self.center.x
#define YCenter self.center.y
#define SHeight (XCenter + 30)
#define SWidth (XCenter + 30)

static CGFloat kSpringY = 60;
static NSString *contentTitleColorStr = @"666666"; // 正文颜色较深

@interface QrCodeReaderView() <AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>
{
    AVCaptureSession *_session;
}

- (void)p_instanceDevice;

- (void)p_setOverlayPickerView:(QrCodeReaderView *)reader;

@end

@implementation QrCodeReaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self p_instanceDevice];
    }
    return self;
}

- (void)p_instanceDevice {
    
    // 添加一个背景图片 扫描区域
    UIImageView *scanZoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake((Width - SWidth)/2, kSpringY, SWidth, SWidth)];
    scanZoneImageView.image = [UIImage imageNamed:@"scanscanBg"];
    
    [self addSubview:scanZoneImageView];
    
    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    //创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 位置做标 扫描区域
    output.rectOfInterest = [self rectOfInterestByScanViewRect:CGRectMake((Width - SWidth)/2, kSpringY, SWidth, SWidth)];
    
    //初始化链接对象
    _session = [[AVCaptureSession alloc]init];
    // 设置为高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if (input) {
        [_session addInput:input];
    }
    
    if (output) {
        [_session addOutput:output];
        //设置扫码支持的的编码格式（支持条形码和二维码兼容）
        NSMutableArray *a = [NSMutableArray array];
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
            [a addObject:AVMetadataObjectTypeQRCode];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
            [a addObject:AVMetadataObjectTypeEAN13Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]) {
            [a addObject:AVMetadataObjectTypeEAN8Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
            [a addObject:AVMetadataObjectTypeCode128Code];
        }
        output.metadataObjectTypes = a;
        
    }
    
    AVCaptureVideoPreviewLayer *layer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:_session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.layer.bounds;
    [self.layer insertSublayer:layer atIndex:0];
    [self p_setOverlayPickerView:self];
    
    //开始捕获
    [_session startRunning];
}

// 初始化扫描线
- (void)loopDrawLine {
    
    _is_AnmotionFinished = NO;
    CGRect rect = CGRectMake((Width - SWidth)/2 + 5, kSpringY + 5, SWidth - 10, 2);
    if (_readLineView) {
        _readLineView.alpha = 1;
        _readLineView.frame = rect;
    } else {
        _readLineView = [[UIImageView alloc]initWithFrame:rect];
        _readLineView.image = [UIImage imageNamed:@"scanLine"];
        [self addSubview:_readLineView];
    }
    
    [UIView animateWithDuration:1.5 animations:^{
        _readLineView.frame = CGRectMake((Width - SWidth)/2 + 5, kSpringY + SWidth - 5, SWidth - 10, 2);
        
    } completion:^(BOOL finished) {
        if (!_is_Anmotion) {
            [self loopDrawLine];
        }
        _is_AnmotionFinished=YES;
    }];
}

- (void)start {
    [_session startRunning];
}

- (void)stop {
    [_session stopRunning];
}

- (void)p_setOverlayPickerView:(QrCodeReaderView *)reader {
    
    // 设置蒙层
    [self setOverView];
    
    //用于说明的label
    UILabel *labIntroudction = [[UILabel alloc]init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame = CGRectMake(0, kSpringY + SWidth + 30 , Width, 50);
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.textColor = [UIColor whiteColor];
    labIntroudction.text = @"请扫描二维码";
    [self addSubview:labIntroudction];
    
    // 开关灯button
//    UIButton * turnBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    turnBtn.backgroundColor=[UIColor clearColor];
//
//    [turnBtn setBackgroundImage:[UIImage imageNamed:@"lightSelect"] forState:UIControlStateNormal];
//    [turnBtn setBackgroundImage:[UIImage imageNamed:@"lightNormal"] forState:UIControlStateSelected];
//    turnBtn.frame = CGRectMake(0, 0, 50, 50);
//    turnBtn.center = self.center;
//    [turnBtn addTarget:self action:@selector(turnBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:turnBtn];
}

- (void)turnBtnEvent:(UIButton *)button {
    
    button.selected=!button.selected;
    if (button.selected) {
        [self turnTorchOn:YES];
    }else{
        [self turnTorchOn:NO];
    }
}

- (void)turnTorchOn:(BOOL)on {
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass !=nil) {
        AVCaptureDevice * device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]&&[device hasFlash]) {
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                
            }else{
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}

#pragma mark - 扫描结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if (metadataObjects&&metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject * metadataObject=[metadataObjects objectAtIndex:0];
        //输出扫描字符串
        if (_delegate && [_delegate respondsToSelector:@selector(readerScanResult:)]){
            [_delegate readerScanResult:metadataObject.stringValue];
        }
    }
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate 光感
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL, sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary *)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    
    NSLog(@"brightnessValue %f", brightnessValue);
}

#pragma mark - 添加模糊效果
- (void)setOverView {
    
    CGFloat width = Width;
    CGFloat height = Height;
    
    CGFloat x = (Width - SWidth)/2;
    CGFloat y = kSpringY;
    CGFloat w = SWidth;
    CGFloat h = SWidth;
    
    [self creatView:CGRectMake(0, 0, width, y)];
    [self creatView:CGRectMake(0, y, x, h)];
    [self creatView:CGRectMake(0, y + h, width, height - y - h)];
    [self creatView:CGRectMake(x + w, y, width - x - w, h)];
}

//改变透明度
- (void)creatView:(CGRect)rect {
    
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor grayColor];
    view.alpha = 0.5;
    [self addSubview:view];
}

// 扫描中心
- (CGRect)rectOfInterestByScanViewRect:(CGRect)rect {
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
//    CGFloat x = (height - CGRectGetHeight(rect)) / 2 / height;
//    CGFloat y = (width - CGRectGetWidth(rect)) / 2 /width;
    
    CGPoint o = rect.origin;
    CGFloat x = o.y / height;
    CGFloat y = o.x / width;
    
    CGFloat w = CGRectGetHeight(rect) / height;
    CGFloat h = CGRectGetWidth(rect) / width;
    
    return CGRectMake(x, y, w, h);
}

@end

//
//  QrCodeScanningViewController.m
//  AllDemo
//
//  Created by LHWen on 2018/2/24.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "QrCodeScanningViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "QrCodeReaderView.h"

#define DeviceMaxHeight [UIScreen mainScreen].bounds.size.height
#define DeviceMaxWidth  [UIScreen mainScreen].bounds.size.width

#define  IOS8 [[UIDevice currentDevice].systemVersion intValue] >= 8 ? YES:NO

@interface QrCodeScanningViewController ()
<UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
AVCaptureMetadataOutputObjectsDelegate,
QrCodeReaderViewDelegate>
{
    BOOL isFirst; //第一次进入该界面
    BOOL isPush; //跳转到下级页面
    QrCodeReaderView *_readView;
    
}

@property(nonatomic,strong)CIDetector * detector;

- (void)p_initScan;

// 扫描结果
- (void)p_accordingQcode:(NSString *)string;

@end

@implementation QrCodeScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"二维码/条码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStyleDone target:self action:@selector(rightBtnEvent)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    isFirst=YES;
    isPush=NO;
    [self p_initScan];
}

- (void)p_initScan {
    
    if (_readView) {
        [_readView removeFromSuperview];
        _readView = nil;
    }

    _readView = [[QrCodeReaderView alloc] initWithFrame:self.view.bounds];
    _readView.is_AnmotionFinished = YES;
    _readView.backgroundColor = [UIColor clearColor];
    _readView.delegate = self;
    _readView.alpha = 0;
    [self.view addSubview:_readView];

    [UIView animateWithDuration:0.5 animations:^{
        _readView.alpha = 1;
    } completion:^(BOOL finished) {

    }];
}

//相册
- (void)rightBtnEvent {
    
    _detector=[CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy :CIDetectorAccuracyHigh}];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        if (IOS8) {
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"未开启访问相册权限，现在去开启！" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 跳转到权限设置
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
        return;
    }
    
    isPush=YES;
    UIImagePickerController * mediaUI=[[UIImagePickerController alloc]init];
    mediaUI.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    mediaUI.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    mediaUI.allowsEditing=NO;
    mediaUI.delegate=self;
    
    [self presentViewController:mediaUI animated:YES completion:^{
        UIStatusBarStyle  barStyle=[self preferredStatusBarStyle];
        barStyle=UIStatusBarStyleDefault;
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    _readView.is_Anmotion = YES;
    NSArray * feartures = [self.detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    if (feartures.count >= 1) {
        [picker dismissViewControllerAnimated:YES completion:^{
            UIStatusBarStyle style = [self preferredStatusBarStyle];
            style = UIStatusBarStyleLightContent;
            
            CIQRCodeFeature  *feature=[feartures objectAtIndex:0];
            NSString *scanResult = feature.messageString;
            
            // 播放二维码扫描完成后的声音
            SystemSoundID soundID;
            NSString *soundFile = [[NSBundle mainBundle]pathForResource:@"noticeMusic" ofType:@"wav"];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &soundID);
            AudioServicesPlaySystemSound(soundID);
            
            [self p_accordingQcode:scanResult];
        }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"该图片没有包含一个二维码！" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        });
        
        [picker dismissViewControllerAnimated:YES completion:^{
            UIStatusBarStyle style=[self preferredStatusBarStyle];
            style=UIStatusBarStyleLightContent;
            _readView.is_Anmotion=NO;
            [_readView start];
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        UIStatusBarStyle style=[self preferredStatusBarStyle];
        style=UIStatusBarStyleDefault;
    }];
}

#pragma mark -- 扫描结果
- (void)p_accordingQcode:(NSString *)string {
    
    NSURL * url = [NSURL URLWithString: string];
    if ([[UIApplication sharedApplication] canOpenURL: url]) {
        [[UIApplication sharedApplication] openURL: url];
    }else {
        
        // 扫描结果
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController * alert=[UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
            
        });
    }
}
#pragma mark -- 代理方法的实现  扫描结果
- (void)readerScanResult:(NSString *)result {
    
    _readView.is_Anmotion=YES;
    [_readView stop];
    
    NSString *resultString = result;//返回的扫描结果
    NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc]; // 如果中文是utf-8编码转gbk结果为空(还没搞明白)
    
    // 如果扫描中文乱码则需要处理，否则不处理
    if (retStr) {
        NSInteger max = [result length];
        char *nbytes = malloc(max + 1);
        for (int i = 0; i < max; i++) {
            unichar ch = [result  characterAtIndex: i];
            nbytes[i] = (char) ch;
        }
        nbytes[max] = '\0';
        resultString=[NSString stringWithCString: nbytes encoding: enc];
    }
    
    [self p_accordingQcode:resultString];
    [self performSelector:@selector(reStartScan) withObject:nil afterDelay:1.5];
}

// 重新开始扫描
- (void)reStartScan {
    
    _readView.is_Anmotion=NO;
    if (_readView.is_AnmotionFinished) {
        [_readView loopDrawLine];
    }
    [_readView start];
}

#pragma mark -view
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (isFirst || isPush) {
        if (_readView) {
            [self reStartScan];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
    if (isFirst) {
        isFirst=NO;
    }
    if (isPush) {
        isPush=NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    if (index == NSNotFound) {
        
        [_readView stop];
        [_readView removeFromSuperview];
        _readView = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

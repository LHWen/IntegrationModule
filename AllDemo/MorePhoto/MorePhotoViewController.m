//
//  MorePhotoViewController.m
//  AllDemo
//
//  Created by yuhui on 16/12/27.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "MorePhotoViewController.h"
#import "AddPhotoView.h"       // 添加照片封装类

@interface MorePhotoViewController ()

@property (nonatomic, strong) AddPhotoView *addPhotoView;

@end

@implementation MorePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"多张";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    _addPhotoView = [[AddPhotoView alloc] init];
    _addPhotoView.controller = self;
    _addPhotoView.frame = CGRectMake(0, 20, kSCREENWIDTH, 200);
    _addPhotoView.leftMargin = 10;
    _addPhotoView.maxImagesCount = 4;   // 一次最多选择4张，对于多行布局没有细调整
    [_addPhotoView initView];
    [self.view addSubview:_addPhotoView];
    
    UIButton *button = ({
        UIButton *button       = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"上传图片" forState:UIControlStateNormal];
        button.frame           = CGRectMake(20, 264, 100, 40);
        button.backgroundColor = [UIColor greenColor];
        [button addTarget:self action:@selector(sendPhotoDatas:) forControlEvents:UIControlEventTouchUpInside];
        
        button;
    });
    
    [self.view addSubview:button];

}

- (void)sendPhotoDatas:(UIButton *)button {
 
    NSLog(@"上传照片调用以下方法");
//    [self sendImages];
}

/** ------使用AF进行上传照片流------- */
- (void)sendImages {
    
    NSArray *imgArray = [[_addPhotoView getArray] copy];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    NSString *url = @"此处是请求地址";
    
    /**
     * 如果需要上传多个参数：使用字典形式保存在 parameters中
     *  NSDictionary *params = @{@"cid": _cid, @"note": content};
     *  @"key": value
     */
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        for (NSInteger i = 0; i < imgArray.count; i++) {
            
            NSString *fileName = [NSString stringWithFormat:@"%ld.jpg", (long)[NSDate date].timeIntervalSince1970];
            
            NSData *imageData = nil;
            if (UIImagePNGRepresentation(imgArray[i])) {
                //返回为png图像。
                imageData = UIImagePNGRepresentation(imgArray[i]);
            }else {
                //返回为JPEG图像。
                imageData = UIImageJPEGRepresentation(imgArray[i], 1.0);
            }
            
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:imageData
                                        name:@"图片的参数"
                                    fileName:fileName
                                    mimeType:@"application/octet-stream"];
        }
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //上传成功
        NSLog(@"task=%@", responseObject);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        //上传失败
        NSLog(@"task=上传失败：%@", error);
    }];

}

@end

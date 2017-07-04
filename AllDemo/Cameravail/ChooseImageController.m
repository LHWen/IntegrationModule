///Users/yuhui/Desktop/AllDemo/AllDemo
//  ChooseImageController.m
//  AllDemo
//
//  Created by yuhui on 17/2/7.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "ChooseImageController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

// 获取相册资源 但是这里有点问题

@interface ChooseImageController ()

@property (nonatomic, strong) UIImageView *photoImgView;

@end

@implementation ChooseImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = @"选择照片";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    [self p_setupImageViewOfPhoto];
    
    // lib
    ALAssetsLibrary *assetlibrary = [[ALAssetsLibrary alloc] init];
    
    // 创建子线程 用于扫描相册的工作
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"currentThread = %@", [NSThread currentThread]);
        // 扫描媒体库
        [assetlibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            // 遍历到第一张图片的时候停止遍历 显示该图片
            // 使用一个bolck 查看我们遍历资源
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                // 主要业务逻辑
                NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                if ([assetType isEqualToString:ALAssetTypePhoto]) { // 属于照片类型
                    *stop = NO;
                    ALAssetRepresentation *assetRepresenttation = [result defaultRepresentation];
                    CGFloat imagescale = [assetRepresenttation scale];
                    UIImageOrientation imageOrientation = (UIImageOrientation)[assetRepresenttation orientation];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        CGImageRef imageRef = [assetRepresenttation fullResolutionImage];
                        UIImage *image = [[UIImage alloc] initWithCGImage:imageRef scale:imagescale orientation:imageOrientation];
                        if (image != nil) {
                            // 将图片显示
                            _photoImgView.image = image;
                        }
                    });
                }
            }];
        } failureBlock:^(NSError *error) {
            NSLog(@"error=%@", error);
        }];
    });
}

- (void)p_setupImageViewOfPhoto {
    
    _photoImgView = [[UIImageView alloc] init];
    _photoImgView.backgroundColor = [UIColor clearColor];
    _photoImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_photoImgView];
    [_photoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(210);
    }];
}

@end

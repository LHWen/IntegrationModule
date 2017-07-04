//
//  AddPhotoView.m
//  获取相册图片
//
//  Created by yuhui on 16/12/9.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "AddPhotoView.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>  // 适配iOS8.0之前

#import "ELCImagePickerController.h"
#import "ELCImagePickerHeader.h"

@interface AddPhotoView () <UIImagePickerControllerDelegate, UIActionSheetDelegate, ELCImagePickerControllerDelegate, UIScrollViewDelegate>
{
    UIView *_imagesView;           // 显示图片视图
    NSMutableArray *_imageArray;   // 保存图片数组
    UIImageView *_deleteImageView; // 删除的图片视图
    CGRect _showImageFrame;        // 显示大图的位置大小
    NSInteger _i; // 当前显示的最后一张图片
    UIScrollView *_scrollView;
    UIImageView *_showScrollImgView;
    UIImageView *_showImageView;   // 显示大图的视图
}

@property (nonatomic, strong) UIButton *addImageButton;
@property (nonatomic, assign) CGRect lastImageFrame;

@end

@implementation AddPhotoView

- (UIButton *)btnAddImage {
    
    if (!_addImageButton) {
        _addImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addImageButton setImage:[UIImage imageNamed:@"ico_del"] forState:UIControlStateNormal];
        [_addImageButton addTarget:self action:@selector(clickAddPhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addImageButton;
}

- (instancetype)init {
   
    self = [super init];
    if (self) {
        _imageArray = [[NSMutableArray alloc] init];
        _i = 0;
        
        [self initDefault];
    }
    return self;
    
}

/** ---------------初始化图片显示默认值---------------- */
- (void)initDefault {
    
    _imageMargin = 6;
    _leftMargin = 21;
    _imageSize = 65;
    _maxImagesCount = 9;
    _imagesInRow = 4;
}

/** -------------初始化承载显示照片View和添加照片button------------ */
- (void)initView {
    
    self.backgroundColor = [UIColor clearColor];
    
    _imagesView = [[UIView alloc] initWithFrame:CGRectMake(_leftMargin, 0, self.frame.size.width - _leftMargin * 2, _imageSize)];
    _imagesView.backgroundColor = [UIColor clearColor];
    [self addSubview:_imagesView];
    
    self.btnAddImage.frame = CGRectMake(_leftMargin, 0, _imageSize, _imageSize);
    [self addSubview:self.addImageButton];
}

/** ------------------点击添加相片--------------------- */
- (void)clickAddPhoto {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择上传照片方式"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"相册", @"相机", nil];
    sheet.actionSheetStyle = UIActionSheetStyleAutomatic;   // 提示框的样式
    sheet.tag = 1;
    [sheet showInView:_controller.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 1) {
        
        switch (buttonIndex) {
            case 0:{   // 选择相册 添加照片
                [self setObtainMoreImage];
                break;
            }
            case 1:{   // 选择相机 添加照片
                [self setImageFromIpckerController];
                break;
            }
            case 2:{   // 取消添加
                
                break;
            }
                
            default:
                break;
        }
        
    }else if (actionSheet.tag == 2) {
        
        switch (buttonIndex) {
            case 0:{   // 删除照片
                [self deleteImage];
                break;
            }
            case 1:{   // 取消删除
                _deleteImageView.backgroundColor=[UIColor clearColor];
                _deleteImageView.alpha = 1.0;
                break;
            }
            default:
                break;
        }
        
    }
    
}

/** ------------------相册中选择照片,可选择多张------------------ */
- (void)setObtainMoreImage {
   
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) {
            return ;
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
            elcPicker.maximumImagesCount = _maxImagesCount; // Set the maximum number of images to select to 100
            elcPicker.returnsOriginalImage = YES; // Only return the fullScreenImage, not the fullResolutionImage
            elcPicker.returnsImage = YES; // Return UIimage if YES. If NO, only return asset location information
            elcPicker.onOrder = YES; // For multiple image selection, display and return order of selected images
//            elcPicker.mediaTypes = @[(NSString *)kUTTypeImage]; //Supports image and movie types
            
            elcPicker.imagePickerDelegate = self;
            
            [_controller presentViewController:elcPicker animated:YES completion:nil];
        });
    }];
}

/** -----------------使用相机拍摄照片----------------- */
- (void)setImageFromIpckerController {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return; // 判断相册是否可以打开
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;     // 设置打开照片相册类型(显示所有相簿)
    imgPicker.delegate = self; // 设置代理
    [_controller presentViewController:imgPicker animated:YES completion:nil];     // modal出这个控制器
}


#pragma mark UIImagePickerControllerDelegate

// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];           // 销毁控制器
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self addPhotoToView:image];    // 设置图片
   
    // 当image从相机中获取的时候存入相册中
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [_controller dismissViewControllerAnimated:YES completion:nil];
}

//** —————————— 这个地方只做一个提示的功能 -----------
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error) {
        NSLog(@"保存失败");
    }else{
        NSLog(@"保存成功");
    }
}

#pragma mark - <CTAssetsPickerControllerDelegate>

/** --------------实现选择照片完成代理------------- */
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    
    [_controller dismissViewControllerAnimated:YES completion:nil];
    
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage *image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                
                if (_imageArray.count < _maxImagesCount) {
                    
                    [self addPhotoToView:image];
                }
            } else {
                //                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else {
            //            NSLog(@"Uknown asset type");
        }
    }
}

/** -------调用图像选择取消,点击“取消”按钮-------- */
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
    
    [_controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)addPhotoToView:(UIImage *)image {
    
    [_imageArray addObject:image];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.tag = 100 + _i;
    imageView.frame = CGRectMake((_i % _imagesInRow) * _imageSize + _imageMargin * _i, (_i / _imagesInRow) * _imageSize, _imageSize, _imageSize);
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleToFill;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage:)]];
    [_imagesView addSubview:imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame           = CGRectMake(_imageSize-20, 0, 20, 20);
    button.tag = 100 + _i;
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:@"new_pro_photo_delete"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(deletePhotobuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:button];
    
    /**------------------- 以下是添加长按手势，删除照片---------
    UILongPressGestureRecognizer *pressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlePressGesture:)];
    pressGesture.minimumPressDuration = 0.5;     // 手势识别时长
    pressGesture.numberOfTouchesRequired = 1;    // 手指数量识别
    [imageView addGestureRecognizer:pressGesture];  // 添加手势到视图
    -------------------------------------------------------*/
    _i += 1;
    
    if (_imageArray.count < _maxImagesCount) {
        self.addImageButton.frame = CGRectMake((_i % _imagesInRow) * _imageSize + _imageMargin * _i + _leftMargin, (_i / _imagesInRow) * _imageSize, _imageSize, _imageSize);
    }else if(_imageArray.count == _maxImagesCount) {
        self.addImageButton.hidden = YES;
    }
}

/** ---------------点击图片手势看大图------------ */
- (void)showImage:(UITapGestureRecognizer *)tap {
    // 在此处理点击查看大图事件
    _showImageView = (UIImageView *)tap.view;
    NSInteger count  = tap.view.tag - 100;
    _showImageFrame = CGRectMake((count % _imagesInRow) * _imageSize + _imageMargin * count, (count / _imagesInRow) * _imageSize, _imageSize, _imageSize);
    
    [UIView animateKeyframesWithDuration:.3 delay:0.0 options:0 animations:^{
        
        /**
         *  分步动画   第一个参数是该动画开始的百分比时间  第二个参数是该动画持续的百分比时间
         */
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
            _showImageView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.3, 1.4), 0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.3 animations:^{
            _showImageView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.5, 1.5), 0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.4 animations:^{
            _showImageView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.8, 1.8), 0);
            _showImageView.center = _controller.view.center;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0.1 animations:^{
            _showImageView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(2.2, 2.2), 0);
        }];
        
    } completion:^(BOOL finished) {
        
        [self setScrollViewAndShowImage];
    }];
}

/** --------------长按删除照片手势--------------- */
//长按删除照片
- (void)handlePressGesture:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        _deleteImageView = (UIImageView *)recognizer.view;
        
        [self setDeletePhotoActionSheet];
    }
}

/** ---------------点击左上角红色X进行删除照片操作--------------- */
- (void)deletePhotobuttonClick:(UIButton *)button {
    
    _deleteImageView = [[UIImageView alloc] initWithImage:_imageArray[button.tag - 100]];
    
   [self setDeletePhotoActionSheet];
}

/** -------------------创建删除提示框-------------------- */
- (void)setDeletePhotoActionSheet {
    
    _deleteImageView.alpha = 0.5;
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"删除照片"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"删除",nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;   // 提示框的样式
    actionSheet.tag = 2;
    [actionSheet showInView:_controller.view];    // 显示在哪个view界面中
}

/** --------------------删除照片--------------------- */
- (void)deleteImage {
    
    for (UIView *view in _imagesView.subviews) {
        [view removeFromSuperview];
    }
    [_imageArray removeObject:_deleteImageView.image];
    
    _i -= 1;
    
    for (int i = 0; i < _imageArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = _imageArray[i];
        imageView.tag = 100 + i;
        imageView.frame = CGRectMake((i % _imagesInRow) * _imageSize + _imageMargin * i, (i / _imagesInRow) * _imageSize, _imageSize, _imageSize);
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleToFill;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage:)]];
        [_imagesView addSubview:imageView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame           = CGRectMake(_imageSize-20, 0, 20, 20);
        button.tag = 100 + i;
        button.backgroundColor = [UIColor clearColor];
        [button setBackgroundImage:[UIImage imageNamed:@"new_pro_photo_delete"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(deletePhotobuttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:button];

         /**------------------- 以下是添加长按手势，删除照片---------
        UILongPressGestureRecognizer *pressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlePressGesture:)];
        pressGesture.minimumPressDuration = 0.5;   // 手势识别时长
        pressGesture.numberOfTouchesRequired = 1;  // 手指数量识别
        [imageView addGestureRecognizer:pressGesture];  // 添加手势到视图
        -------------------------------------------------------*/
          
        _lastImageFrame = imageView.frame;
    }
    
    if(_imageArray.count == 0) {
        self.addImageButton.frame = CGRectMake(_leftMargin, 0, _imageSize, _imageSize);
    } else if (_imageArray.count < _maxImagesCount) {
        self.addImageButton.hidden = NO;
        self.addImageButton.frame = CGRectMake((_i % _imagesInRow) * _imageSize + _imageMargin * _i + _leftMargin, (_i / _imagesInRow) * _imageSize, _imageSize, _imageSize);
    }
}


#pragma mark - 显示大图片

- (void)setScrollViewAndShowImage {
    
    UIImageView *selectedImageView = (UIImageView *)_showImageView;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect originFrame = [selectedImageView convertRect:selectedImageView.bounds toView:window];
    CGRect targetFrame = CGRectMake(0.0, 0.0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    UIView *targetBackgroudView = [[UIView alloc] initWithFrame:originFrame];
    
    _scrollView = [UIScrollView new];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.frame = targetBackgroudView.bounds;
    _scrollView.center = _controller.view.center;
    //设置边缘不弹跳
    _scrollView.bounces = YES;
    _scrollView.userInteractionEnabled = YES;
    //设置水平和竖直方向不滚动
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissViewClick)]];
    
    _showScrollImgView = [[UIImageView alloc] initWithImage:_showImageView.image];
    _showScrollImgView.backgroundColor = [UIColor blackColor];
    _showScrollImgView.frame = targetBackgroudView.bounds;
    _showScrollImgView.userInteractionEnabled = YES;
    _showScrollImgView.contentMode = UIViewContentModeScaleAspectFit;
    [_showScrollImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissViewClick)]];
    [_scrollView addSubview:_showScrollImgView];
    
    /* 缩放有关的设置 */
    _scrollView.minimumZoomScale = 1;
    CGFloat xScale = _scrollView.frame.size.width/_showScrollImgView.frame.size.width;
    CGFloat yScale = _scrollView.frame.size.height/_showScrollImgView.frame.size.height;
    _scrollView.maximumZoomScale = MAX(1+xScale, 1+yScale);
    //设置滚动视图的代理，意在说明，如果滚动视图上
    //有任何的变化行为，则交给当前控制器来处理
    _scrollView.delegate = self;
    
    // 3.添加到self.view中
    [[UIApplication sharedApplication].keyWindow addSubview:_scrollView];
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _scrollView.frame = targetFrame;
        
        _showScrollImgView.frame = targetFrame;
        
    } completion:^(BOOL finished) {
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    }];

}

#pragma  mark - 滚动视图的代理协议中的方法
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _showScrollImgView;
}

- (void)dismissViewClick {
    
    /**
    [UIView animateWithDuration:0.3 animations:^{
        
        _scrollView.frame = CGRectMake(0, 0, 0, 0);
        _scrollView.center = _controller.view.center;
        
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
        [_showScrollImgView removeFromSuperview];
        _showScrollImgView = nil;
        _scrollView = nil;
    }];
     */
    
    [UIView animateKeyframesWithDuration:.5 delay:0.0 options:0 animations:^{
        
        [_scrollView removeFromSuperview];
        [_showScrollImgView removeFromSuperview];
        _showScrollImgView = nil;
        _scrollView = nil;
        
    } completion:^(BOOL finished) {
        
        [UIView animateKeyframesWithDuration:.5 delay:0.0 options:0 animations:^{
            
            /**
             *  分步动画   第一个参数是该动画开始的百分比时间  第二个参数是该动画持续的百分比时间
             */
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
                _showImageView.center = _controller.view.center;
                _showImageView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(2.0, 2.0), 0);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.3 animations:^{
                _showImageView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.8, 1.8), 0);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.2 animations:^{
                _showImageView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.5, 1.5), 0);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.3 animations:^{
                _showImageView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.0, 1.0), 0);
                 _showImageView.frame = _showImageFrame;
            }];
            
        } completion:^(BOOL finished) {
            
        }];

    }];
    
}

- (NSArray *) getArray {
    return _imageArray;
}

@end

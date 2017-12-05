//
//  CreatQRImage.m
//  AllDemo
//
//  Created by LHWen on 2017/9/4.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "CreatQRImage.h"

@implementation CreatQRImage

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)Imagesize logoImageSize:(CGFloat)waterImagesize {
   
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"]; // 通过kvo方式给一个字符串，生成二维码
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"]; // 设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    CIImage *outPutImage = [filter outputImage]; // 拿到二维码图片
    return [[self alloc] createNonInterpolatedUIImageFormCIImage:outPutImage withSize:Imagesize waterImageSize:waterImagesize];
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size waterImageSize:(CGFloat)waterImagesize {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    // 创建一个DeviceGray颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    // width：图片宽度像素
    // height：图片高度像素
    // bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    // bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    // 创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    // 给二维码加 logo 图
    UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
    [outputImage drawInRect:CGRectMake(0,0 , size, size)];
    // logo图
    UIImage *waterimage = [UIImage imageNamed:@"app_icon"];
    
    // 把logo图画到生成的二维码图片上，注意尺寸不要太大（最大不超过二维码图片的%30），太大会造成扫不出来
    [waterimage drawInRect:CGRectMake((size-waterImagesize)/2.0, (size-waterImagesize)/2.0, waterImagesize, waterImagesize)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}

//+ (UIImage *)qrImageColorWithString:(NSString *)string andRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue {
//    
//    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
//    [filter setDefaults];
//    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
//    [filter setValue:data forKey:@"inputMessage"]; // 通过kvo方式给一个字符串，生成二维码
//    [filter setValue:@"H" forKey:@"inputCorrectionLevel"]; // 设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
//    CIImage *outPutImage = [filter outputImage]; // 拿到二维码图片
//    return [[self alloc] imageBlackToTransparent:(UIImage *) withRed:<#(CGFloat)#> andGreen:<#(CGFloat)#> andBlue:<#(CGFloat)#>];
//}

+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue {
    
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage); // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        } else {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef]; // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return resultUIImage;
}

+ (UIImage *)qrCodeString:(NSString *)string {
    
    //二维码过滤器
    CIFilter *qrImageFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //设置过滤器默认属性 (老油条)
    [qrImageFilter setDefaults];
    
    //将字符串转换成 NSdata (虽然二维码本质上是 字符串,但是这里需要转换,不转换就崩溃)
    NSData *qrImageData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    //我们可以打印,看过滤器的 输入属性.这样我们才知道给谁赋值
    NSLog(@"%@",qrImageFilter.inputKeys);
    /*
     inputMessage,        //二维码输入信息
     inputCorrectionLevel //二维码错误的等级,就是容错率
     */
    
    //设置过滤器的 输入值  ,KVC赋值
    [qrImageFilter setValue:qrImageData forKey:@"inputMessage"];
    
    //取出图片
    CIImage *qrImage = [qrImageFilter outputImage];
    
    //但是图片 发现有的小 (27,27),我们需要放大..我们进去CIImage 内部看属性
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(9, 9)];
    
    return [UIImage imageWithCIImage:qrImage];
    
    //    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
//    self.imageView.layer.shadowOffset=CGSizeMake(0, 5);//设置阴影的偏移量
//    self.imageView.layer.shadowRadius=1;//设置阴影的半径
//    self.imageView.layer.shadowColor=[UIColor redColor].CGColor;//设置阴影的颜色为黑色
//    self.imageView.layer.shadowOpacity=0.3;
}


//MARK:彩色的二维码
+ (UIImage *)colorQrcodeImage {
    
    
    //二维码的实质是 字符串, 我们生产二维码,就是根据字符串去生产一张图片
    
    
    //获取内建的所有过滤器.
    //        NSArray *filterArr = [CIFilter filterNamesInCategories:kCICategoryBuiltIn]; //也对
    NSArray *filterArr = [CIFilter filterNamesInCategories:@[kCICategoryBuiltIn]];   //对
    
    NSLog(@"%@",filterArr); //所有内建过滤器,找CR... 二维码的
    
    //创建二维码过滤器
    CIFilter * qrfilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //设置默认属性(老油条)
    [qrfilter setDefaults];
    
    //我们需要给 二维码过期器 设置一下属性,给它一些东西,让它去生成图片吧,那些属性呢,跳进去看
    NSLog(@"%@",qrfilter.inputKeys);
    /*
     inputMessage,            //二维码的信息
     inputCorrectionLevel     //二维码的容错率 ()到达一定值后,就不能识别二维码了
     */
    
    //我们需要给 二维码 的 inputMessage 设置值,  这是私有属性,我们 使用KVC.给其私有属性赋值
    
    //将字符串转为NSData,去获取图片
    NSData * qrimgardata = [@"http://www.baidu.com" dataUsingEncoding:NSUTF8StringEncoding];
    
    //去获取对应的图片(因为测试,直接用字符串会崩溃)
    [qrfilter setValue:qrimgardata forKey:@"inputMessage"];
    
    //去获得对应图片 outPut
    CIImage *qrImage = qrfilter.outputImage;
    
    //图片不清除,打印知道其 大小 为 (27,27). 进入 CIImage,看属性,
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(9, 9)];
    
    
    //创建彩色过滤器   (彩色的用的不多)-----------------------------------------------------
    CIFilter * colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    
    //设置默认值
    [colorFilter setDefaults];
    
    //同样打印这样的 输入属性  inputKeys
    NSLog(@"%@",colorFilter.inputKeys);
    /*
     inputImage,   //输入的图片
     inputColor0,  //前景色
     inputColor1   //背景色
     */
    
    //KVC 给私有属性赋值
    [colorFilter setValue:qrImage forKey:@"inputImage"];
    
    //需要使用 CIColor
    [colorFilter setValue:[CIColor colorWithRed:1 green:0 blue:0.8] forKey:@"inputColor0"];
    [colorFilter setValue:[CIColor colorWithRed:0 green:1 blue:0.4] forKey:@"inputColor1"];
    
    //设置输出
    CIImage *colorImage = [colorFilter outputImage];
    
    
    UIImage *newsImage = [UIImage imageWithCIImage:colorImage];
    return newsImage;
}

@end

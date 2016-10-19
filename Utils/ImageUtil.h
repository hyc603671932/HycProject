//
//  ImageUtil.h
//  ProjectTemplet
//
//  Created by HouKavin on 16/2/4.
//  Copyright © 2016年 HouKavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ImageUtil : NSObject

//把图片保存到aPath路径下
+ (BOOL)writeImage:(UIImage*)image toFileAtPath:(NSString*)aPath;

//获取图片等比例缩放后的大小
+ (CGSize)fitsize:(CGSize)imgSize with:(CGSize) maxSize;
//大图片缩小为maxSize大大小（过大的图片变小）
+ (UIImage *)fitSmallImage:(UIImage *)image with:(CGSize) maxSize;

//设置图片自适应,默认边长为30
+ (UIImage *)rescaleImageWithName:(NSString *)imageName;
//设置图片自适应，带边长
+ (UIImage *)rescaleImageWithName:(NSString *)imageName wide:(float)wide;
//图像缩放
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
//设置图片自适应，带宽高（参数为image、宽、高）
+ (UIImage *)rescaleImageWithImage:(UIImage *)image width:(float)width height:(float)height;
//图片缩放并剪切
+ (UIImage*) imageByScalingAndCroppingForSize:(CGSize)targetSize image:(UIImage *) sourceImage;

//UIColor转UIImage
+ (UIImage*) createImageWithColor: (UIColor*) color;
//16位字符颜色转UIColor
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

@end

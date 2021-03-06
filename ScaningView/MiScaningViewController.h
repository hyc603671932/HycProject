//
//  MiScaningViewController.h
//  NavgationTest
//
//  Created by HouKavin on 16/7/19.
//  Copyright © 2016年 HouKavin. All rights reserved.
//
/*
 1.这是个简易版本的二维码扫描。
 完整版本地址如下：https://github.com/MxABC/LBXScan
 完整版本包含，二维码扫描，生成，zxing库，扫描动画切换等功能
 2.兴趣区域
 方法【setupCameraWithPreView: useCropRect:】中的useCropRect参数代表开启/关闭兴趣区域。
 开启情况：扫描识别区仅限于中央透明区域，必须保证二维码完全进入扫描区。优势在于可以使中央区域扫描精确度提高，且符合用户习惯。缺点在于，二维码较大情况下手机要抬高一个较大的距离。
 关闭情况：全屏都属于扫描区域，扫描速度快，但是精确度较弱
 
 3.备用库
 备用了一个老的支持码类别方法【defaultMetaDataObjectTypes】
 
 */


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol MiScaningDelegate <NSObject>
@optional//非强制实现
- (void)scaningCallBackValue:(NSString *)value;

@end

@interface MiScaningViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>{
    BOOL sessionRuning;
}

@property (assign,nonatomic) id<MiScaningDelegate> delegate;

@end

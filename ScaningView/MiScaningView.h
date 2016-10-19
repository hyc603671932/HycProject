//
//  MiScaningView.h
//  NavgationTest
//
//  Created by HouKavin on 16/7/19.
//  Copyright © 2016年 HouKavin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiScanLineAnimation.h"

@interface MiScaningView : UIView

/**
 @brief  初始化
 @param frame 位置大小
 @param style 类型
 
 @return instancetype
 */
-(id)initWithFrame:(CGRect)frame;

/**
 *  开始扫描动画
 */
- (void)startScanAnimation;

/**
 *  结束扫描动画
 */
- (void)stopScanAnimation;

//

/**
 @brief  根据矩形区域，获取识别兴趣区域
 @param view  视频流显示UIView
 @param style 效果界面参数
 @return 识别区域
 */
+ (CGRect)getScanRectWithPreView:(UIView*)view;

@end

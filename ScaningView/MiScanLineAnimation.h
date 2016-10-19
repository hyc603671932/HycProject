//
//  MiScanLineAnimation.h
//  NavgationTest
//
//  Created by HouKavin on 16/7/20.
//  Copyright © 2016年 HouKavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MiScanLineAnimation : UIImageView


/**
 *  开始扫码线动画
 *
 *  @param animationRect 显示在parentView中得区域
 *  @param parentView    动画显示在UIView
 *  @param image     扫码线的图像
 */
- (void)startAnimatingWithRect:(CGRect)animationRect InView:(UIView*)parentView Image:(UIImage*)image;

/**
 *  停止动画
 */
- (void)stopAnimating;

@end

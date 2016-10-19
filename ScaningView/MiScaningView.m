//
//  MiScaningView.m
//  NavgationTest
//
//  Created by HouKavin on 16/7/19.
//  Copyright © 2016年 HouKavin. All rights reserved.
//

//矩形框(视频显示透明区)域离界面左边及右边距离，默认60
#define ScanRetangleOffset 40

#define ScanCenterUpOffset 44

#import "MiScaningView.h"

@interface MiScaningView()

//扫码区域
@property (nonatomic,assign)CGRect scanRetangleRect;

//线条扫码动画封装
@property (nonatomic,strong)MiScanLineAnimation *scanLineAnimation;

/**
 @brief  启动相机时 菊花等待
 */
@property(nonatomic,strong)UIActivityIndicatorView* activityView;


@end

@implementation MiScaningView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [self drawScanRect];
}


/**
 *  开始扫描动画
 */
- (void)startScanAnimation
{
    
    if(!self.scanLineAnimation){
        self.scanLineAnimation = [[MiScanLineAnimation alloc]init];
        [_scanLineAnimation startAnimatingWithRect:_scanRetangleRect
                                            InView:self
                                             Image:[UIImage imageNamed:@"mi_scaning_line"]];
    }
}



/**
 *  结束扫描动画
 */
- (void)stopScanAnimation
{
    [_scanLineAnimation stopAnimating];
    
}


- (void)drawScanRect
{
    int XRetangleLeft = ScanRetangleOffset;
    
    CGSize sizeRetangle = CGSizeMake(self.frame.size.width - XRetangleLeft*2, self.frame.size.width - XRetangleLeft*2);
    
    
    //扫码区域Y轴最小坐标
    CGFloat YMinRetangle = self.frame.size.height / 2.0 - sizeRetangle.height/2.0 - ScanCenterUpOffset;
    CGFloat YMaxRetangle = YMinRetangle + sizeRetangle.height;
    CGFloat XRetangleRight = self.frame.size.width - XRetangleLeft;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //非扫码区域半透明
    {
        //设置非识别区域颜色(黑色，班透明)
        CGContextSetRGBFillColor(context,0.0,0.0,0.0,0.5);
        
        //填充矩形
        
        //扫码区域上面填充
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, YMinRetangle);
        CGContextFillRect(context, rect);
        
        
        //扫码区域左边填充
        rect = CGRectMake(0, YMinRetangle, XRetangleLeft,sizeRetangle.height);
        CGContextFillRect(context, rect);
        
        //扫码区域右边填充
        rect = CGRectMake(XRetangleRight, YMinRetangle, XRetangleLeft,sizeRetangle.height);
        CGContextFillRect(context, rect);
        
        //扫码区域下面填充
        rect = CGRectMake(0, YMaxRetangle, self.frame.size.width,self.frame.size.height - YMaxRetangle);
        CGContextFillRect(context, rect);
        //执行绘画
        CGContextStrokePath(context);
    }
    
    //中间画矩形(正方形)
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 1);
    
    CGContextAddRect(context, CGRectMake(XRetangleLeft, YMinRetangle, sizeRetangle.width, sizeRetangle.height));
    
    //CGContextMoveToPoint(context, XRetangleLeft, YMinRetangle);
    //CGContextAddLineToPoint(context, XRetangleLeft+sizeRetangle.width, YMinRetangle);
    
    CGContextStrokePath(context);
    
    _scanRetangleRect = CGRectMake(XRetangleLeft, YMinRetangle, sizeRetangle.width, sizeRetangle.height);
    
    
    //画矩形框4格外围相框角
    
    //相框角的宽度和高度
    int wAngle = 24;
    int hAngle = 24;
    
    //4个角的 线的宽度
    CGFloat linewidthAngle = 4;// 经验参数：6和4
    
    //画扫码矩形以及周边半透明黑色坐标参数
    CGFloat diffAngle = linewidthAngle/3;
    //diffAngle = linewidthAngle / 2; //框外面4个角，与框有缝隙
    //diffAngle = linewidthAngle/2;  //框4个角 在线上加4个角效果
    //diffAngle = 0;//与矩形框重合
    
    diffAngle = linewidthAngle/3;//框外面4个角，与框紧密联系在一起
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0. green:167./255. blue:231./255. alpha:1.0].CGColor);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    
    CGContextSetLineWidth(context, linewidthAngle);
    
    
    //
    CGFloat leftX = XRetangleLeft - diffAngle;
    CGFloat topY = YMinRetangle - diffAngle;
    CGFloat rightX = XRetangleRight + diffAngle;
    CGFloat bottomY = YMaxRetangle + diffAngle;
    
    //左上角水平线
    CGContextMoveToPoint(context, leftX-linewidthAngle/2, topY);
    CGContextAddLineToPoint(context, leftX + wAngle, topY);
    
    //左上角垂直线
    CGContextMoveToPoint(context, leftX, topY-linewidthAngle/2);
    CGContextAddLineToPoint(context, leftX, topY+hAngle);
    
    
    //左下角水平线
    CGContextMoveToPoint(context, leftX-linewidthAngle/2, bottomY);
    CGContextAddLineToPoint(context, leftX + wAngle, bottomY);
    
    //左下角垂直线
    CGContextMoveToPoint(context, leftX, bottomY+linewidthAngle/2);
    CGContextAddLineToPoint(context, leftX, bottomY - hAngle);
    
    
    //右上角水平线
    CGContextMoveToPoint(context, rightX+linewidthAngle/2, topY);
    CGContextAddLineToPoint(context, rightX - wAngle, topY);
    
    //右上角垂直线
    CGContextMoveToPoint(context, rightX, topY-linewidthAngle/2);
    CGContextAddLineToPoint(context, rightX, topY + hAngle);
    
    
    //右下角水平线
    CGContextMoveToPoint(context, rightX+linewidthAngle/2, bottomY);
    CGContextAddLineToPoint(context, rightX - wAngle, bottomY);
    
    //右下角垂直线
    CGContextMoveToPoint(context, rightX, bottomY+linewidthAngle/2);
    CGContextAddLineToPoint(context, rightX, bottomY - hAngle);
    
    CGContextStrokePath(context);
}



//根据矩形区域，获取识别区域
+ (CGRect)getScanRectWithPreView:(UIView*)view{
    int XRetangleLeft = ScanRetangleOffset;
    CGSize sizeRetangle = CGSizeMake(view.frame.size.width - XRetangleLeft*2, view.frame.size.width - XRetangleLeft*2);
    
    //扫码区域Y轴最小坐标
    CGFloat YMinRetangle = view.frame.size.height / 2.0 - sizeRetangle.height/2.0 - ScanCenterUpOffset;
    //扫码区域坐标
    CGRect cropRect =  CGRectMake(XRetangleLeft, YMinRetangle, sizeRetangle.width, sizeRetangle.height);
    
    
    //计算兴趣区域
    CGRect rectOfInterest;
    
    //ref:http://www.cocoachina.com/ios/20141225/10763.html
    CGSize size = view.bounds.size;
    CGFloat p1 = size.height/size.width;
    CGFloat p2 = 1920./1080.;  //使用了1080p的图像输出
    if (p1 < p2) {
        CGFloat fixHeight = size.width * 1920. / 1080.;
        CGFloat fixPadding = (fixHeight - size.height)/2;
        rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,
                                    cropRect.origin.x/size.width,
                                    cropRect.size.height/fixHeight,
                                    cropRect.size.width/size.width);
        
    } else {
        CGFloat fixWidth = size.height * 1080. / 1920.;
        CGFloat fixPadding = (fixWidth - size.width)/2;
        rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
                                    (cropRect.origin.x + fixPadding)/fixWidth,
                                    cropRect.size.height/size.height,
                                    cropRect.size.width/fixWidth);
        
        
    }
    
    return rectOfInterest;
}

@end

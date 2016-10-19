//
//  MiScaningViewController.m
//  NavgationTest
//
//  Created by HouKavin on 16/7/19.
//  Copyright © 2016年 HouKavin. All rights reserved.
//

#import "MiScaningViewController.h"
#import "MiScaningView.h"

@interface MiScaningViewController ()
@property (strong,nonatomic)MiScaningView *scanView;
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@end

@implementation MiScaningViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"二维码/条形码";
    if([self isGetCameraPermission]){//如果没有打开相机权限
        CGRect rect = self.view.frame;
        rect.origin = CGPointMake(0, 0);
        
        self.scanView = [[MiScaningView alloc]initWithFrame:rect];
        [self.view addSubview:self.scanView];
        [self setupCameraWithPreView:self.view useCropRect:YES];
    }else {//有相机权限
        [self showAlert:@"相机权限受限" message:@"请到设置隐私中开启本程序相机权限"];
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //扫描动画一定要在viewDidAppear中开始，否则会没有frame
    [self.scanView startScanAnimation];
}

//开启扫描会话，第二个参数useCropRect指是否开启兴趣区域，详情见类首注释
- (void)setupCameraWithPreView:(UIView*)preView useCropRect:(BOOL)useCropRect
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //摄像头聚焦
    if (_device.isFocusPointOfInterestSupported &&[_device isFocusModeSupported:AVCaptureFocusModeAutoFocus])
    {
        [_input.device lockForConfiguration:nil];
        [_input.device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [_input.device unlockForConfiguration];
    }
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    //一定要加入session中后availableMetadataObjectTypes这个数组才会有元素
    [_output setMetadataObjectTypes:_output.availableMetadataObjectTypes];
    
    //设置兴趣区域
    if (useCropRect) {
        CGRect cropRect = [MiScaningView getScanRectWithPreView:self.view];
        
        if (!CGRectEqualToRect(cropRect,CGRectZero) )
        {
            _output.rectOfInterest = cropRect;
        }
    }
    
    
    // Preview
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    _preview.frame = preView.frame;
    [preView.layer insertSublayer:self.preview atIndex:0];
    
    // Start
    [_session startRunning];
    sessionRuning = YES;
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    if ([metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        @try{ //捕获异常，若没有stringValue这个属性捕获之
            NSString *valueStr = metadataObject.stringValue;
            if ([self.delegate respondsToSelector:@selector(scaningCallBackValue:)]) {
                [self.delegate scaningCallBackValue:valueStr];
                [self.navigationController popViewControllerAnimated:YES];
            }
            //扫描到结果后，结束会话，停止扫描动画
            [_session stopRunning];
            [self showAlert:@"扫码成功" message:valueStr];
            [self.scanView stopScanAnimation];
            sessionRuning = NO;
        }@catch (NSException * exception) {
            NSLog(@"扫码出现意外Exception: %@", exception);
            [self showAlert:@"扫码出现意外" message:@"请确认您的二维码/条形码完整并再次尝试扫描"];
        }
        
    }
}


#pragma mark -相机、相册权限
- (BOOL)isGetCameraPermission
{
    BOOL isCameraValid = YES;
    
    //ios7之前系统默认拥有权限
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
        {
            isCameraValid = NO;
        }
    }
    return isCameraValid;
}

/**
 @brief  默认支持码的类别
 @return 支持类别 数组
 */
- (NSArray *)defaultMetaDataObjectTypes
{
    NSMutableArray *types = [@[AVMetadataObjectTypeQRCode,//条形码
                               AVMetadataObjectTypeUPCECode,
                               AVMetadataObjectTypeCode39Code,
                               AVMetadataObjectTypeCode39Mod43Code,
                               AVMetadataObjectTypeEAN13Code,
                               AVMetadataObjectTypeEAN8Code,
                               AVMetadataObjectTypeCode93Code,
                               AVMetadataObjectTypeCode128Code,
                               AVMetadataObjectTypePDF417Code,
                               AVMetadataObjectTypeAztecCode] mutableCopy];
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1)
    {
        [types addObjectsFromArray:@[
                                     AVMetadataObjectTypeInterleaved2of5Code,
                                     AVMetadataObjectTypeITF14Code,
                                     AVMetadataObjectTypeDataMatrixCode
                                     ]];
    }
    
    return types;
}

//展示alertView
-(void)showAlert:(NSString *)title message:(NSString *)message{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)dealloc{
    if (sessionRuning) {
        [_session stopRunning];
        [self.scanView stopScanAnimation];
    }
    self.scanView = nil;
}

@end

//
//  JYKRecordViewController.m
//  JYKVideoKit
//
//  Created by Joyoki on 2019/2/25.
//  Copyright © 2019年 Joyoki. All rights reserved.
//
//  github: https://github.com/Joyoki-J/JYKVideoKit
//

#import "JYKRecordViewController.h"
#import "JYKPreView.h"
#import <AVFoundation/AVFoundation.h>

@interface JYKRecordViewController ()

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) UIView *vPreView;

@end

@implementation JYKRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubViews];
    
    self.captureSession = [[AVCaptureSession alloc] init];
    [self.captureSession beginConfiguration];
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
    NSError *error;
    AVCaptureDeviceInput *videoDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:videoDevice error:&error];
    if (!error && [self.captureSession canAddInput:videoDeviceInput]) {
        [self.captureSession addInput:videoDeviceInput];
    }
    
    AVCapturePhotoOutput *photoOutput = [[AVCapturePhotoOutput alloc] init];
    if ([self.captureSession canAddOutput:photoOutput]) {
        self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
        [self.captureSession addOutput:photoOutput];
    }
    [self.captureSession commitConfiguration];
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    previewLayer.backgroundColor = [UIColor blackColor].CGColor;
    previewLayer.frame = self.vPreView.bounds;
    [self.vPreView.layer addSublayer:previewLayer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - UI

- (void)createSubViews {
    _vPreView = [[UIView alloc] init];
    _vPreView.frame = self.view.bounds;
    _vPreView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_vPreView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 100, 50);
    btn.center = self.view.center;
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    btn.layer.borderWidth = 1.f;
    btn.layer.borderColor = [UIColor blueColor].CGColor;
    [btn addTarget:self action:@selector(onClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)onClickAction:(UIButton *)sender {
    if (!self.captureSession.isRunning) {
        [self.captureSession startRunning];
    } else {
        [self.captureSession stopRunning];
    }
}

#pragma mark - Actions

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self goBack];
}

#pragma mark - Get&Set

//- (JYKPreView *)vPreView {
//    if (!_vPreView) {
//        _vPreView = [[JYKPreView alloc] initWithFrame:self.view.bounds];
//        _vPreView.backgroundColor = [UIColor blackColor];
//        [self.view insertSubview:_vPreView atIndex:0];
//    }
//    return _vPreView;
//}

#pragma mark - Override
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


@end

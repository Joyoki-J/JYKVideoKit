//
//  JYKVideoRecorder.m
//  JYKVideoKit
//
//  Created by Joyoki on 2019/2/25.
//  Copyright © 2019年 Joyoki. All rights reserved.
//
//  github: https://github.com/Joyoki-J/JYKVideoKit
//

#import "JYKVideoRecorder.h"
#import "JYKPreView.h"
#import "JYKVideoContext.h"
#import "JYKAssertDefine.h"
#import "JYKCaptureDeviceManager.h"
#import "JYKVideoWriter.h"

#define kJYKVideoProcessingQueueIdentifier   @"com.joyoki.jykvideokit.video.processingqueue"

@interface JYKVideoRecorder ()
{
    JYKPreView *_preView;
    AVCaptureSession *_captureSession;
    AVCaptureDevice *_videoDevice;
    AVCaptureDeviceInput *_videoInput;
    AVCaptureVideoDataOutput *_videoOutput;
    
    JYKContextQueue *_videoProcessingQueue;
    
    JYKVideoWriter *_videoWriter;
}

@end

@implementation JYKVideoRecorder

- (instancetype)initWithPreView:(JYKPreView *)preView
{
    self = [super init];
    JYKSafeAssert(self, nil);
    
    _preView = preView;
    
    _videoProcessingQueue = [[JYKContextQueue alloc] initWithQueueIdentifier:kJYKVideoProcessingQueueIdentifier];
    
    _videoDevice = [JYKCaptureDeviceManager videoDeviceWithPosition:AVCaptureDevicePositionBack];
    JYKSafeAssert(_videoDevice, nil);
    
    _captureSession = [[AVCaptureSession alloc] init];
    [_captureSession beginConfiguration];
    NSError *error = nil;
    _videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:_videoDevice error:&error];
    if ([_captureSession canAddInput:_videoInput]) {
        [_captureSession addInput:_videoInput];
    }
    
    _videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    [_videoOutput setAlwaysDiscardsLateVideoFrames:NO];
    [_videoOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
    [_videoOutput setSampleBufferDelegate:self queue:_videoProcessingQueue.contextQueue];
    if ([_captureSession canAddOutput:_videoOutput]) {
        [_captureSession addOutput:_videoOutput];
    } else {
        NSLog(@"Couldn't add video output");
        return nil;
    }
    
    AVCaptureConnection *captureConnection = [_videoOutput connectionWithMediaType:AVMediaTypeVideo];
    if ([captureConnection isVideoOrientationSupported]) {
        captureConnection.videoOrientation = [self getCaptureVideoOrientation];
    }
    [_captureSession setSessionPreset:AVCaptureSessionPreset1920x1080];
    
    [_captureSession commitConfiguration];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = _preView.bounds;
    [_preView.layer addSublayer:layer];
    
    
    _videoWriter = [[JYKVideoWriter alloc] init];
    
    return self;
}


- (AVCaptureVideoOrientation)getCaptureVideoOrientation {
    AVCaptureVideoOrientation result;
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
            result = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            //如果这里设置成AVCaptureVideoOrientationPortraitUpsideDown，则视频方向和拍摄时的方向是相反的。
            result = AVCaptureVideoOrientationPortrait;
            break;
        case UIDeviceOrientationLandscapeLeft:
            result = AVCaptureVideoOrientationLandscapeRight;
            break;
        case UIDeviceOrientationLandscapeRight:
            result = AVCaptureVideoOrientationLandscapeLeft;
            break;
        default:
            result = AVCaptureVideoOrientationPortrait;
            break;
    }
    
    return result;
}

- (void)dealloc {
    [self stopCameraCapture];
    [_videoOutput setSampleBufferDelegate:nil queue:dispatch_get_main_queue()];
    [self removeInputsAndOutputs];
    
    NSLog(@"JYKVideoRecorder dealloc");
}

#pragma mark - Get&Set
- (JYKPreView *)preView {
    return _preView;
}

#pragma mark - Private
- (void)stopCameraCapture {
    if ([_captureSession isRunning]) {
        [_captureSession stopRunning];
    }
}

- (void)removeInputsAndOutputs {
    [_captureSession beginConfiguration];
    if (_videoInput) {
        [_captureSession removeInput:_videoInput];
        [_captureSession removeOutput:_videoOutput];
        _videoInput = nil;
        _videoOutput = nil;
    }
    [_captureSession commitConfiguration];
}


#pragma mark - Public
- (BOOL)startPreView {
    
    JYKSafeAssert(_preView, NO);
    AVAuthorizationStatus cameraStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    JYKSafeAssert(cameraStatus != AVAuthorizationStatusDenied, NO);
    AVAuthorizationStatus micphoneStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    JYKSafeAssert(micphoneStatus != AVAuthorizationStatusDenied, NO);
    
    if (![_captureSession isRunning]) {
        [_captureSession startRunning];
    };
    
    return YES;
}

- (BOOL)stopPreView {
    if ([_captureSession isRunning]) {
        [_captureSession stopRunning];
    }
    return YES;
}

- (void)startRecording {
    [_videoWriter startRecordingWithURL:[self newMovieFile]];
}

- (void)finishRecordingWithHandler:(void(^)(void))handler {
    [_videoWriter finishRecordingWithCompletionHandler:handler];
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate&AVCaptureAudioDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    if (!_captureSession.isRunning) return;
    
    CMTime currentTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    [_videoWriter newFrameReadyAtTime:currentTime framebuffer:pixelBuffer];
}

- (NSURL *)newMovieFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *tmpDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    tmpDir = [tmpDir stringByAppendingPathComponent:@"AHVideo"];
    tmpDir = [tmpDir stringByAppendingPathComponent:@"AHVideoParts"];
    
    if (![fileManager fileExistsAtPath:tmpDir]) {
        NSError *error;
        BOOL result = [fileManager createDirectoryAtPath:tmpDir withIntermediateDirectories:YES attributes:nil error:&error];
        if (!result) {
            NSLog(@"error = %@",error);
            return nil;
        }
    }
    
    NSString *fileName = [NSString stringWithFormat:@"AH%ldiOS.MOV", (NSInteger)[[NSDate date] timeIntervalSince1970]];
    tmpDir = [tmpDir stringByAppendingPathComponent:fileName];
    if ([fileManager fileExistsAtPath:tmpDir]) {
        [fileManager removeItemAtPath:tmpDir error:nil];
    }
    
    NSURL *fileUrl = [NSURL fileURLWithPath:tmpDir];
    
    return fileUrl;
}

@end

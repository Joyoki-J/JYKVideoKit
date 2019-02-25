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
{
    AVAssetWriter * asserWriter;
    AVAssetWriterInput * videoWriterInput;
    AVAssetWriterInput * audioWriterInput;
    
    BOOL recording;
    CMTime lastSampleTime;
    NSString * videoFileUrl;
}

@property (nonatomic, strong) UIImageView *vPreView;

@end

@implementation JYKRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubViews];
    
    //1.首先确定录制视频的长宽大小
    CGSize size = CGSizeMake(720, 1280);
    //2.创建视频文件路径，同时删除可能的同名文件
    videoFileUrl = [NSHomeDirectory() stringByAppendingString:@"/Documents/test.mov"];
    unlink([videoFileUrl UTF8String]);
    //3.创建AVAssetWriter对象，同时需要创建错误指针，用来收集错误信息
    NSError * error = nil;
    asserWriter = [[AVAssetWriter alloc]initWithURL:[NSURL fileURLWithPath:videoFileUrl] fileType:AVFileTypeQuickTimeMovie error:&error];
    NSParameterAssert(asserWriter);
    if(error)
    {
        NSLog(@"error = %@", [error localizedDescription]);
    }
    //4.配置视频输入
    //4.1首先视频的压缩配置.比特率
    NSDictionary * videoCompressionPropertys = @{AVVideoAverageBitRateKey:[NSNumber numberWithDouble:128.0 * 1024.0]};
    //4.2视频的参数配置：h264编码
    NSDictionary * videoSettings = @{AVVideoCodecKey:AVVideoCodecH264,
                                     AVVideoWidthKey:[NSNumber numberWithFloat:size.width],
                                     AVVideoHeightKey:[NSNumber numberWithFloat:size.height],
                                     AVVideoCompressionPropertiesKey:videoCompressionPropertys};
    //4.3初始化视频输入
    
    videoWriterInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
    NSParameterAssert(videoWriterInput);
    //4.5设置为实时数据输入
    videoWriterInput.expectsMediaDataInRealTime = YES;
    NSParameterAssert([asserWriter canAddInput:videoWriterInput]);
    if ([asserWriter canAddInput:videoWriterInput])
        NSLog(@"I can add this input");
    else
        NSLog(@"i can't add this input");
    
    //6.初始化音频输入
    AudioChannelLayout acl;
    bzero( &acl, sizeof(acl));   //初始化音频通道
    acl.mChannelLayoutTag = kAudioChannelLayoutTag_Mono;  //设置为单通道模式
    NSDictionary* audioOutputSettings = nil;
    //配置音频参数
    audioOutputSettings = [ NSDictionary dictionaryWithObjectsAndKeys:                           [ NSNumber numberWithInt: kAudioFormatMPEG4AAC ], AVFormatIDKey, /*codec为AAC*/                           [ NSNumber numberWithInt:64000], AVEncoderBitRateKey, /*码率64kbps*/                           [ NSNumber numberWithFloat: 44100.0 ], AVSampleRateKey, /*采样率44.1*/
                           [ NSNumber numberWithInt: 1 ], AVNumberOfChannelsKey, /*单通道*/
                           [ NSData dataWithBytes: &acl length: sizeof( acl ) ], AVChannelLayoutKey,                           nil ];      audioWriterInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:audioOutputSettings]; /*初始化AVAssetWriterInput*/
    audioWriterInput.expectsMediaDataInRealTime = YES; /*设置为实时模式*/
    //7.最后一步，添加源，并打印writer的状态
    [asserWriter addInput:audioWriterInput];
    [asserWriter addInput:videoWriterInput];
    
    NSLog(@"%ld",(long)asserWriter.status);
    
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    @autoreleasepool {
        lastSampleTime = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
        
        if (!recording) {
            return;
        }
        
//        if (captureOutput == videoDataOutput) {
//
//            // video
//
//            if (asserWriter.status > AVAssetWriterStatusWriting)
//            {
//                NSLog(@"Warning: writer status is %ld", (long)asserWriter.status);
//
//                if (asserWriter.status == AVAssetWriterStatusFailed)
//                {
//                    NSLog(@"Error: %@", asserWriter.error);
//                    return;
//                }
//            }
//            if ([videoWriterInput isReadyForMoreMediaData])
//            {
//                // writer buffer
//                if (![videoWriterInput appendSampleBuffer:sampleBuffer])
//                {
//                    NSLog(@"unable to write video frame : %lld",lastSampleTime.value);
//                }
//                else
//                {
//                    NSLog(@"recorded frame time %lld",lastSampleTime.value/lastSampleTime.timescale);
//                }
//            }
//        }
//        else
//        {
//            // audio
//
//            if (asserWriter.status > AVAssetWriterStatusWriting)
//            {
//                NSLog(@"Warning: writer status is %ld", (long)asserWriter.status);
//
//                if (asserWriter.status == AVAssetWriterStatusFailed)
//                {
//                    NSLog(@"Error: %@", asserWriter.error);
//                    return;
//                }
//            }
//
//            if ([audioWriterInput isReadyForMoreMediaData])
//            {
//                // writer buffer
//                if (![audioWriterInput appendSampleBuffer:sampleBuffer])
//                {
//                    NSLog(@"unable to write audio frame : %lld",lastSampleTime.value);
//                }
//                else
//                {
//                    NSLog(@"recorded audio frame time %lld",lastSampleTime.value/lastSampleTime.timescale);
//                }
//            }
//        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - UI

- (void)createSubViews {
    _vPreView = [[UIImageView alloc] init];
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
    
    if (!recording)
    {
        [sender setTitle:@"结束" forState:UIControlStateNormal];
        recording = YES;
        if (recording && asserWriter.status != AVAssetWriterStatusWriting)
        {
            [asserWriter startWriting];
            [asserWriter startSessionAtSourceTime:lastSampleTime];
        }
    }
    else
    {
        [sender setTitle:@"开始" forState:UIControlStateNormal];
        recording = NO;
        [asserWriter finishWritingWithCompletionHandler:^{
            
        }];
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

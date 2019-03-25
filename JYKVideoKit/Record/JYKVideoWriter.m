//
//  JYKVideoWriter.m
//  JYKVideoKit
//
//  Created by Jay on 2019/3/25.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import "JYKVideoWriter.h"
#import "JYKVideoContext.h"

@interface JYKVideoWriter ()

@property (nonatomic, strong) AVAssetWriter *assetWriter;
@property (nonatomic, strong) AVAssetWriterInput *assetWriterVideoInput;
@property (nonatomic, strong) AVAssetWriterInputPixelBufferAdaptor *assetWriterPixelBufferInput;
@property (nonatomic, strong) JYKContextQueue *videoWriterQueue;
@property (nonatomic, assign) CMTime startTime;

@end

@implementation JYKVideoWriter
- (void)dealloc
{
    NSLog(@"JYKVideoRecorder dealloc");
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _videoWriterQueue = [[JYKContextQueue alloc] initWithQueueIdentifier:@"JYKContextQueue"];
    }
    return self;
}

- (void)startRecordingWithURL:(NSURL *)newMovieURL {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:newMovieURL.path]) {
        [fileManager removeItemAtPath:newMovieURL.path error:nil];
    }
    
    NSError *error;
    AVAssetWriter *assetWriter = [[AVAssetWriter alloc] initWithURL:newMovieURL fileType:AVFileTypeQuickTimeMovie error:&error];
    assetWriter.shouldOptimizeForNetworkUse = YES;
    assetWriter.movieFragmentInterval = CMTimeMakeWithSeconds(1.0, 1000);
    if (error) {
        return;
    }
    
    AVAssetWriterInput *assetWriterVideoInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:[self videoOutputSetting]];
    assetWriterVideoInput.expectsMediaDataInRealTime = YES;
    
    if (assetWriterVideoInput && [assetWriter canAddInput:assetWriterVideoInput]) {
        [assetWriter addInput:assetWriterVideoInput];
    }
    
    NSDictionary *sourcePixelBufferAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt:kCVPixelFormatType_32BGRA], kCVPixelBufferPixelFormatTypeKey,
                                                           [NSNumber numberWithInt:1080.f], kCVPixelBufferWidthKey,
                                                           [NSNumber numberWithInt:1920.f], kCVPixelBufferHeightKey,
                                                           nil];
    self.assetWriterPixelBufferInput = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:assetWriterVideoInput sourcePixelBufferAttributes:sourcePixelBufferAttributesDictionary];
    
    [JYKVideoContext runSynchronouslyOnQueue:_videoWriterQueue block:^{
        self.assetWriterVideoInput = assetWriterVideoInput;
        self.assetWriter = assetWriter;
    }];
}

- (void)finishRecordingWithCompletionHandler:(void (^)(void))handler {
    
    [JYKVideoContext runSynchronouslyOnQueue:_videoWriterQueue block:^{
        if (self.assetWriter.status != AVAssetWriterStatusWriting) {
            return;
        }
        
        [self.assetWriterVideoInput markAsFinished];
        [self.assetWriter finishWritingWithCompletionHandler:^{
            
        }];
        self.assetWriter = nil;
        self.assetWriterVideoInput = nil;
        self.assetWriterPixelBufferInput = nil;
    }];
    
    if (handler) {
        handler();
    }
}

- (NSDictionary *)videoOutputSetting {
    // 码率和帧率设置
    NSNumber *bitRate = [NSNumber numberWithInt:(2800 * 1000)];
    NSNumber *frameRate = [NSNumber numberWithInt:30];
    NSNumber *keyFrameInterval = [NSNumber numberWithInt:3];
    NSDictionary *compressionProperties = @{ AVVideoAverageBitRateKey : bitRate,      //视频码率
                                             AVVideoExpectedSourceFrameRateKey : frameRate, //期望帧率
                                             AVVideoMaxKeyFrameIntervalKey : keyFrameInterval,      //关键帧间隔 数值越大压缩比越大
                                             // AVVideoQualityKey: @(0.8), //清晰度压缩比例 iPod iOS8 crash
                                             AVVideoProfileLevelKey : AVVideoProfileLevelH264MainAutoLevel };
    
    return @{AVVideoCodecKey : AVVideoCodecH264,    //必须
             AVVideoWidthKey : @(1080.0f),              //必须
             AVVideoHeightKey : @(1920.0f),            //必须
             AVVideoCompressionPropertiesKey : compressionProperties, //压缩
             };
}

- (void)newFrameReadyAtTime:(CMTime)frameTime framebuffer:(CVPixelBufferRef)framebuffer {
    if (!_assetWriter) {
        return;
    }
    
    if (_assetWriter.status == AVAssetWriterStatusUnknown) {
        [JYKVideoContext runSynchronouslyOnQueue:_videoWriterQueue block:^{
            [self.assetWriter startWriting];
            [self.assetWriter startSessionAtSourceTime:frameTime];
        }];
    }
    
    CVPixelBufferRetain(framebuffer);
    CVPixelBufferLockBaseAddress(framebuffer,0);
    
    [JYKVideoContext runAsynchronouslyOnQueue:_videoWriterQueue block:^{
        if (self.assetWriter.status != AVAssetWriterStatusWriting) {
            return;
        }
        
        if (!self.assetWriterVideoInput.readyForMoreMediaData) {
            return;
        }
        
        void(^write)(void) = ^() {
            
            while( !self.assetWriterVideoInput.readyForMoreMediaData) {
                NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:0.1];
                [[NSRunLoop currentRunLoop] runUntilDate:maxDate];
            }
            
            if (self.assetWriterPixelBufferInput &&
                self.assetWriterVideoInput && self.assetWriterVideoInput.readyForMoreMediaData && self.assetWriter.status == AVAssetWriterStatusWriting) {
                if (![self.assetWriterPixelBufferInput appendPixelBuffer:framebuffer withPresentationTime:frameTime]) {
                    NSLog(@"1111111111111");
                }
            } else {
                NSLog(@"Couldn't write a frame");
            }
            CVPixelBufferUnlockBaseAddress(framebuffer, 0);
            CVPixelBufferRelease(framebuffer);
        };
        
        if (self.assetWriter.status == AVAssetWriterStatusWriting) {
            write();
        }
    }];
}

@end

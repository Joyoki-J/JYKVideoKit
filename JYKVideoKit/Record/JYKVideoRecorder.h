//
//  JYKVideoRecorder.h
//  JYKVideoKit
//
//  Created by Joyoki on 2019/2/25.
//  Copyright © 2019年 Joyoki. All rights reserved.
//
//  github: https://github.com/Joyoki-J/JYKVideoKit
//

#import <AVFoundation/AVFoundation.h>

@class JYKPreView;

NS_ASSUME_NONNULL_BEGIN

@interface JYKVideoRecorder : NSObject<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>

@property (nonatomic, readonly) JYKPreView *preView;

- (instancetype)initWithPreView:(JYKPreView *)preView;

- (BOOL)startPreView;
- (BOOL)stopPreView;

- (void)startRecording;
- (void)finishRecordingWithHandler:(void(^)(NSURL *videoURL))handler;

@end

NS_ASSUME_NONNULL_END

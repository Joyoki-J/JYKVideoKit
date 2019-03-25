//
//  JYKVideoWriter.h
//  JYKVideoKit
//
//  Created by Jay on 2019/3/25.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYKVideoWriter : NSObject

- (void)startRecordingWithURL:(NSURL *)newMovieURL;
- (void)finishRecordingWithCompletionHandler:(void (^)(void))handler;

- (void)newFrameReadyAtTime:(CMTime)frameTime framebuffer:(CVPixelBufferRef)framebuffer;

@end

NS_ASSUME_NONNULL_END

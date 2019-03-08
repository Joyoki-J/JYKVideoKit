//
//  JYKVideoContext.m
//  JYKVideoKit
//
//  Created by Jay on 2019/3/8.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import "JYKVideoContext.h"
#import "JYKVideoQueue.h"

#define kJYKSessionQueueIdentifier @"com.joyoki.jykvideokit.session.queue"
#define kJYKVideoQueueIdentifier   @"com.joyoki.jykvideokit.video.queue"
#define kJYKAudioQueueIdentifier   @"com.joyoki.jykvideokit.audio.queue"

@interface JYKVideoContext ()

@property (nonatomic, strong) JYKVideoQueue *queue_session;
@property (nonatomic, strong) JYKVideoQueue *queue_video;
@property (nonatomic, strong) JYKVideoQueue *queue_audio;

@end

@implementation JYKVideoContext

+ (instancetype)sharedContext {
    static JYKVideoContext *context = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        context = [[[JYKVideoContext superclass] alloc] init];
    });
    return context;
}

+ (void)runAsynchronouslyOnQueue:(JYKVideoQueue *)queue block:(void(^)(void))block {
    if ([queue isCurrentQueue]) {
        block();
    } else {
        dispatch_async(queue.contextQueue, block);
    }
}

+ (void)runSynchronouslyOnQueue:(JYKVideoQueue *)queue block:(void(^)(void))block {
    if ([queue isCurrentQueue]) {
        block();
    } else {
        dispatch_sync(queue.contextQueue, block);
    }
}

+ (void)runAsynchronouslyOnSessionQueue:(void(^)(void))block {
    JYKVideoQueue *queue = [JYKVideoContext sharedContext].queue_session;
    [JYKVideoContext runAsynchronouslyOnQueue:queue block:block];
}

+ (void)runSynchronouslyOnSessionQueue:(void(^)(void))block {
    JYKVideoQueue *queue = [JYKVideoContext sharedContext].queue_session;
    [JYKVideoContext runSynchronouslyOnQueue:queue block:block];
}

+ (void)runAsynchronouslyOnVideoQueue:(void(^)(void))block {
    JYKVideoQueue *queue = [JYKVideoContext sharedContext].queue_video;
    [JYKVideoContext runAsynchronouslyOnQueue:queue block:block];
}

+ (void)runSynchronouslyOnVideoQueue:(void(^)(void))block {
    JYKVideoQueue *queue = [JYKVideoContext sharedContext].queue_video;
    [JYKVideoContext runSynchronouslyOnQueue:queue block:block];
}

+ (void)runAsynchronouslyOnAudioQueue:(void(^)(void))block {
    JYKVideoQueue *queue = [JYKVideoContext sharedContext].queue_audio;
    [JYKVideoContext runAsynchronouslyOnQueue:queue block:block];
}

+ (void)runSynchronouslyOnAudioQueue:(void(^)(void))block {
    JYKVideoQueue *queue = [JYKVideoContext sharedContext].queue_audio;
    [JYKVideoContext runSynchronouslyOnQueue:queue block:block];
}

+ (void)runAsynchronouslyOnMainQueue:(void(^)(void))block {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

+ (void)runSynchronouslyOnMainQueue:(void(^)(void))block {
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}


#pragma mark - geters
- (JYKVideoQueue *)queue_session {
    if (!_queue_session) {
        _queue_session = [[JYKVideoQueue alloc] initWithQueueIdentifier:kJYKSessionQueueIdentifier];
    }
    return _queue_session;
}

- (JYKVideoQueue *)queue_video {
    if (!_queue_video) {
        _queue_video = [[JYKVideoQueue alloc] initWithQueueIdentifier:kJYKVideoQueueIdentifier];
    }
    return _queue_video;
}

- (JYKVideoQueue *)queue_audio {
    if (!_queue_audio) {
        _queue_audio = [[JYKVideoQueue alloc] initWithQueueIdentifier:kJYKAudioQueueIdentifier];
    }
    return _queue_audio;
}

@end

//
//  JYKVideoContext.m
//  JYKVideoKit
//
//  Created by Jay on 2019/3/8.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import "JYKVideoContext.h"
#import "JYKContextQueue.h"

#define kJYKSessionQueueIdentifier @"com.joyoki.jykvideokit.session.queue"
#define kJYKVideoQueueIdentifier   @"com.joyoki.jykvideokit.video.queue"
#define kJYKAudioQueueIdentifier   @"com.joyoki.jykvideokit.audio.queue"

@interface JYKVideoContext ()

@property (nonatomic, strong) JYKContextQueue *queue_session;
@property (nonatomic, strong) JYKContextQueue *queue_video;
@property (nonatomic, strong) JYKContextQueue *queue_audio;

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

+ (void)runAsynchronouslyOnQueue:(JYKContextQueue *)queue block:(void(^)(void))block {
    if ([queue isCurrentQueue]) {
        block();
    } else {
        dispatch_async(queue.contextQueue, block);
    }
}

+ (void)runSynchronouslyOnQueue:(JYKContextQueue *)queue block:(void(^)(void))block {
    if ([queue isCurrentQueue]) {
        block();
    } else {
        dispatch_sync(queue.contextQueue, block);
    }
}

+ (void)runAsynchronouslyOnSessionQueue:(void(^)(void))block {
    JYKContextQueue *queue = [JYKVideoContext sharedContext].queue_session;
    [JYKVideoContext runAsynchronouslyOnQueue:queue block:block];
}

+ (void)runSynchronouslyOnSessionQueue:(void(^)(void))block {
    JYKContextQueue *queue = [JYKVideoContext sharedContext].queue_session;
    [JYKVideoContext runSynchronouslyOnQueue:queue block:block];
}

+ (void)runAsynchronouslyOnVideoQueue:(void(^)(void))block {
    JYKContextQueue *queue = [JYKVideoContext sharedContext].queue_video;
    [JYKVideoContext runAsynchronouslyOnQueue:queue block:block];
}

+ (void)runSynchronouslyOnVideoQueue:(void(^)(void))block {
    JYKContextQueue *queue = [JYKVideoContext sharedContext].queue_video;
    [JYKVideoContext runSynchronouslyOnQueue:queue block:block];
}

+ (void)runAsynchronouslyOnAudioQueue:(void(^)(void))block {
    JYKContextQueue *queue = [JYKVideoContext sharedContext].queue_audio;
    [JYKVideoContext runAsynchronouslyOnQueue:queue block:block];
}

+ (void)runSynchronouslyOnAudioQueue:(void(^)(void))block {
    JYKContextQueue *queue = [JYKVideoContext sharedContext].queue_audio;
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


#pragma mark - Get
- (JYKContextQueue *)queue_session {
    if (!_queue_session) {
        _queue_session = [[JYKContextQueue alloc] initWithQueueIdentifier:kJYKSessionQueueIdentifier];
    }
    return _queue_session;
}

- (JYKContextQueue *)queue_video {
    if (!_queue_video) {
        _queue_video = [[JYKContextQueue alloc] initWithQueueIdentifier:kJYKVideoQueueIdentifier];
    }
    return _queue_video;
}

- (JYKContextQueue *)queue_audio {
    if (!_queue_audio) {
        _queue_audio = [[JYKContextQueue alloc] initWithQueueIdentifier:kJYKAudioQueueIdentifier];
    }
    return _queue_audio;
}

@end

//
//  JYKVideoContext.h
//  JYKVideoKit
//
//  Created by Jay on 2019/3/8.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "JYKVideoQueue.h"

@interface JYKVideoContext : NSObject

+ (void)runAsynchronouslyOnQueue:(JYKVideoQueue *)queue block:(void(^)(void))block;
+ (void)runSynchronouslyOnQueue:(JYKVideoQueue *)queue block:(void(^)(void))block;

+ (void)runAsynchronouslyOnSessionQueue:(void(^)(void))block;
+ (void)runSynchronouslyOnSessionQueue:(void(^)(void))block;

+ (void)runAsynchronouslyOnVideoQueue:(void(^)(void))block;
+ (void)runSynchronouslyOnVideoQueue:(void(^)(void))block;

+ (void)runAsynchronouslyOnAudioQueue:(void(^)(void))block;
+ (void)runSynchronouslyOnAudioQueue:(void(^)(void))block;

+ (void)runAsynchronouslyOnMainQueue:(void(^)(void))block;
+ (void)runSynchronouslyOnMainQueue:(void(^)(void))block;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end


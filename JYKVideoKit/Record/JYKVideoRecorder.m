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
#import <AVFoundation/AVFoundation.h>

@interface JYKVideoRecorder ()

@property (nonatomic, strong, readwrite) JYKPreView *preView;

@end

@implementation JYKVideoRecorder

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createPreView];
    }
    return self;
}

- (void)createPreView {
    _preView = [[JYKPreView alloc] init];
}

@end

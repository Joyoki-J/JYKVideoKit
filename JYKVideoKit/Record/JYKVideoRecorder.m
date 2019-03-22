//
//  JYKVideoRecorder.m
//  JYKVideoKit
//
//  Created by Joyoki on 2019/2/25.
//  Copyright © 2019年 Joyoki. All rights reserved.
//
//  github: https://github.com/Joyoki-J/JYKVideoKit
//

#import <AVFoundation/AVFoundation.h>
#import "JYKPreView.h"
#import "JYKVideoRecorder.h"
#import "JYKVideoContext.h"
#import "JYKAssertDefine.h"

@interface JYKVideoRecorder ()
{
    JYKPreView *_preView;
}

@end

@implementation JYKVideoRecorder

- (instancetype)initWithPreView:(JYKPreView *)preView
{
    self = [super init];
    if (self) {
        _preView = preView;
    }
    return self;
}

#pragma mark - Get&Set
- (JYKPreView *)preView {
    return _preView;
}

#pragma mark - Private



#pragma mark - Public
- (BOOL)startPreView {
    
    JYKSafeAssert(_preView, NO);
    AVAuthorizationStatus cameraStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    JYKSafeAssert(cameraStatus != AVAuthorizationStatusDenied, NO);
    AVAuthorizationStatus micphoneStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    JYKSafeAssert(micphoneStatus != AVAuthorizationStatusDenied, NO);
    
    
    return YES;
}

- (BOOL)stopPreView {
    return YES;
}


@end

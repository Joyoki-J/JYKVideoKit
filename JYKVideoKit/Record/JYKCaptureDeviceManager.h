//
//  JYKCaptureDeviceManager.h
//  JYKVideoKit
//
//  Created by Jay on 2019/3/24.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "JYKCommonDefine.h"


NS_ASSUME_NONNULL_BEGIN

@interface JYKCaptureDeviceManager : NSObject

JYK_INIT_UNAVAILABLE

+ (nullable AVCaptureDevice *)videoDeviceWithPosition:(AVCaptureDevicePosition)position;
+ (nullable AVCaptureDevice *)audioDevice;

@end

NS_ASSUME_NONNULL_END

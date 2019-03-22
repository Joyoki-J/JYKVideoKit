//
//  JYKCaptureDevice.h
//  JYKVideoKit
//
//  Created by Jay on 2019/3/22.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "JYKCommonDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYKCaptureDeviceMaker : NSObject

JYK_INIT_UNAVAILABLE

+ (nullable AVCaptureDevice *)devicewwww;

@end

NS_ASSUME_NONNULL_END

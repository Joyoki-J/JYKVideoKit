//
//  JYKCaptureDevice.m
//  JYKVideoKit
//
//  Created by Jay on 2019/3/22.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import "JYKCaptureDevice.h"

@implementation JYKCaptureDeviceMaker

+ (AVCaptureDevice *)devicewwww {
    if (@available(iOS 10.0, *)) {
        AVCaptureDeviceDiscoverySession *session = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[] mediaType:nil position:AVCaptureDevicePositionUnspecified];
        return [session devices][0];
    } else {
        return nil;
    }
}




//+ (AVCaptureDevice *)devicewwww {
//
//    if (@available(iOS 10.0, *)) {
//        AVCaptureDeviceDiscoverySession *session = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[] mediaType:nil position:AVCaptureDevicePositionUnspecified];
//        return [session devices][0];
//    } else {
//
//    }
//    return nil;
//}




@end

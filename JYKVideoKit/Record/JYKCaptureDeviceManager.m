//
//  JYKCaptureDeviceManager.m
//  JYKVideoKit
//
//  Created by Jay on 2019/3/24.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import "JYKCaptureDeviceManager.h"

@implementation JYKCaptureDeviceManager

+ (nullable AVCaptureDevice *)deviceWithDeviceTypes:(NSArray<AVCaptureDeviceType> *)deviceTypes mediaType:(AVMediaType)mediaType position:(AVCaptureDevicePosition)position API_AVAILABLE(ios(10.0)) {
    
    __block AVCaptureDevice *device = nil;
    [deviceTypes enumerateObjectsUsingBlock:^(AVCaptureDeviceType  _Nonnull deviceType, NSUInteger idx, BOOL * _Nonnull stop) {
        device = [AVCaptureDevice defaultDeviceWithDeviceType:deviceType mediaType:mediaType position:position];
        if (device) {
            *stop = YES;
        }
    }];
    return device;
}

+ (nullable AVCaptureDevice *)deviceWithMediaType:(AVMediaType)mediaType position:(AVCaptureDevicePosition)position {
    NSArray<AVCaptureDevice *> *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
    __block AVCaptureDevice *device = nil;
    [devices enumerateObjectsUsingBlock:^(AVCaptureDevice * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (position == obj.position) {
            device = obj;
            *stop = YES;
        }
    }];
    return device;
}

+ (nullable AVCaptureDevice *)videoDeviceWithPosition:(AVCaptureDevicePosition)position {
    AVCaptureDevice *device = nil;
    if (@available(iOS 10.0, *)) {
        NSArray<AVCaptureDeviceType> *deviceTypes;
        if (@available(iOS 10.2, *)) {
            deviceTypes = @[AVCaptureDeviceTypeBuiltInDualCamera,AVCaptureDeviceTypeBuiltInWideAngleCamera];
        } else {
            deviceTypes = @[AVCaptureDeviceTypeBuiltInWideAngleCamera];
        }
        device = [JYKCaptureDeviceManager deviceWithDeviceTypes:deviceTypes mediaType:AVMediaTypeVideo position:position];
    } else {
        device = [JYKCaptureDeviceManager deviceWithMediaType:AVMediaTypeVideo position:position];
    }
    return device;
}

+ (nullable AVCaptureDevice *)audioDevice {
    AVCaptureDevice *device = nil;
    if (@available(iOS 10.0, *)) {
        device = [JYKCaptureDeviceManager deviceWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInMicrophone] mediaType:AVMediaTypeAudio position:AVCaptureDevicePositionUnspecified];
    } else {
        device = [JYKCaptureDeviceManager deviceWithMediaType:AVMediaTypeAudio position:AVCaptureDevicePositionUnspecified];
    }
    return device;
}

@end

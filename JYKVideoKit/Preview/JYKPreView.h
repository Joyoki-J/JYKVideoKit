//
//  JYKPreView.h
//  JYKVideoKit
//
//  Created by Joyoki on 2019/2/25.
//  Copyright © 2019年 Joyoki. All rights reserved.
//
//  github: https://github.com/Joyoki-J/JYKVideoKit
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYKPreView : UIView

@property (nonatomic, strong, readonly) AVCaptureVideoPreviewLayer *previewLayer;

@end

NS_ASSUME_NONNULL_END

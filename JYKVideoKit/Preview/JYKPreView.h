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

NS_ASSUME_NONNULL_BEGIN

@interface JYKPreView : UIView

- (void)render:(CVPixelBufferRef)pixelBuffer;

@end

NS_ASSUME_NONNULL_END

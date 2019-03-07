//
//  JYKVideoRecorder.h
//  JYKVideoKit
//
//  Created by Joyoki on 2019/2/25.
//  Copyright © 2019年 Joyoki. All rights reserved.
//
//  github: https://github.com/Joyoki-J/JYKVideoKit
//

#import <Foundation/Foundation.h>
#import "JYKPreView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JYKVideoRecorder : NSObject

@property (nonatomic, strong, readonly) JYKPreView *preView;

@end

NS_ASSUME_NONNULL_END

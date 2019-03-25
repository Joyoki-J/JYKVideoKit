//
//  JYKContextQueue.h
//  JYKVideoKit
//
//  Created by Jay on 2019/3/8.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYKCommonDefine.h"

@interface JYKContextQueue : NSObject

JYK_INIT_UNAVAILABLE

@property (nonatomic, readonly) dispatch_queue_t contextQueue;

- (instancetype)initWithQueueIdentifier:(NSString *)identifier;

- (BOOL)isCurrentQueue;

@end


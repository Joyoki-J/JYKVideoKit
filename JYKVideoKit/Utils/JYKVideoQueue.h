//
//  JYKVideoQueue.h
//  JYKVideoKit
//
//  Created by Jay on 2019/3/8.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYKVideoQueue : NSObject

- (instancetype)initWithQueueIdentifier:(NSString *)identifier;

@property (nonatomic, readonly) dispatch_queue_t contextQueue;

- (BOOL)isCurrentQueue;

@end


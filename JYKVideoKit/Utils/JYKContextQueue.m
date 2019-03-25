//
//  JYKContextQueue.m
//  JYKVideoKit
//
//  Created by Jay on 2019/3/8.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import "JYKContextQueue.h"

@interface JYKContextQueue ()
{
    dispatch_queue_t _queue;
    
    void *_JYKContextQueueKey;
    
    NSString *_identifier;
}

@end

@implementation JYKContextQueue

- (instancetype)initWithQueueIdentifier:(NSString *)identifier
{
    self = [super init];
    if (self) {
        _identifier = identifier;
        _queue = dispatch_queue_create([identifier UTF8String], DISPATCH_QUEUE_SERIAL);
        _JYKContextQueueKey = &_JYKContextQueueKey;
        dispatch_queue_set_specific(_queue, _JYKContextQueueKey, _JYKContextQueueKey, NULL);
    }
    return self;
}

- (dispatch_queue_t)contextQueue {
    return _queue;
}

- (BOOL)isCurrentQueue {
    return dispatch_get_specific(_JYKContextQueueKey) ? YES : NO;
}

- (void)dealloc
{
    NSLog(@"JYKContextQueue dealloc %@",_identifier);
}

@end

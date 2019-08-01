//
//  JYKViewController+JYK.m
//  JYKVideoKit
//
//  Created by Joyoki on 2019/8/1.
//  Copyright © 2019 Joyoki. All rights reserved.
//

#import "JYKViewController+JYK.h"

@implementation JYKViewController (JYK)

- (void)didFinishRecordingVideo:(NSURL *)videoURL {
    if ([self.jyk_delegate respondsToSelector:@selector(jyk_viewController:didFinishRecordingVideo:)]) {
        [self.jyk_delegate jyk_viewController:self didFinishRecordingVideo:videoURL];
    }
}

@end

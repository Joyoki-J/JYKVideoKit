//
//  JYKViewController+JYK.h
//  JYKVideoKit
//
//  Created by Joyoki on 2019/8/1.
//  Copyright © 2019 Joyoki. All rights reserved.
//

#import <JYKVideoKit/JYKVideoKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYKViewController (JYK)

- (void)didFinishRecordingVideo:(NSURL *)videoURL;

@end

NS_ASSUME_NONNULL_END

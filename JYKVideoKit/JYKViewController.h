//
//  JYKViewController.h
//  JYKVideoKit
//
//  Created by Jay on 2019/3/7.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JYKViewControllerDelegate;

@interface JYKViewController : UINavigationController

@property (nonatomic, weak) id<JYKViewControllerDelegate> jyk_delegate;

@end

@protocol JYKViewControllerDelegate <NSObject>

- (void)jyk_viewController:(JYKViewController *)vc didFinishRecordingVideo:(NSURL *)videoURL;

@end

NS_ASSUME_NONNULL_END

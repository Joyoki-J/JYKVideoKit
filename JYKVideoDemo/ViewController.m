//
//  ViewController.m
//  JYKVideoDemo
//
//  Created by Joyoki on 2019/2/25.
//  Copyright © 2019年 Joyoki. All rights reserved.
//
//  github: https://github.com/Joyoki-J/JYKVideoKit
//

#import "ViewController.h"
#import <JYKVideoKit/JYKVideoKit.h>
#import <AVKit/AVKit.h>

@interface ViewController ()<JYKViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 100, 40);
    btn.layer.borderColor = [UIColor blueColor].CGColor;
    btn.layer.borderWidth = 1.f / [UIScreen mainScreen].scale;
    btn.center = CGPointMake(self.view.center.x, self.view.center.y - 200);
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)onClickAction {
    JYKViewController *vcRecord = [[JYKViewController alloc] init];
    vcRecord.jyk_delegate = self;
    [self presentViewController:vcRecord animated:YES completion:nil];
}

- (void)jyk_viewController:(JYKViewController *)vc didFinishRecordingVideo:(NSURL *)videoURL {
    [vc dismissViewControllerAnimated:YES completion:^{
        [self goToPlayWithURL:videoURL];
    }];
}

- (void)goToPlayWithURL:(NSURL *)url {
    
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
    playerVC.player = [AVPlayer playerWithURL:url];
    playerVC.showsPlaybackControls = YES;
    if (playerVC.readyForDisplay) {
        [playerVC.player play];
    }
    [self.navigationController pushViewController:playerVC animated:YES];
}

@end

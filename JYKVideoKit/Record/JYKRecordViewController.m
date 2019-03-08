//
//  JYKRecordViewController.m
//  JYKVideoKit
//
//  Created by Joyoki on 2019/2/25.
//  Copyright © 2019年 Joyoki. All rights reserved.
//
//  github: https://github.com/Joyoki-J/JYKVideoKit
//

#import "JYKRecordViewController.h"
#import "JYKVideoRecorder.h"
#import "JYKPreView.h"
#import "JYKVideoContext.h"
@interface JYKRecordViewController ()

@property (nonatomic, strong) JYKVideoRecorder *recorder;

@end

@implementation JYKRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubViews];
    
    [self createVideoRecorder];
    
}

- (void)createVideoRecorder {
    _recorder = [[JYKVideoRecorder alloc] init];
    _recorder.preView.frame = self.view.bounds;
    [self.view addSubview:_recorder.preView];
}

#pragma mark - UI
- (void)createSubViews {
    
}

#pragma mark - Actions

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self goBack];
}

#pragma mark - Get&Set

@end

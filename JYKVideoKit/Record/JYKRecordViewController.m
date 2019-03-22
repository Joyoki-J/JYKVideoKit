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
    JYKPreView *preView = [[JYKPreView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:preView atIndex:0];
    _recorder = [[JYKVideoRecorder alloc] initWithPreView:preView];
}

#pragma mark - UI
- (void)createSubViews {
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    [startButton setTitle:@"结束" forState:UIControlStateSelected];
    [startButton addTarget:self action:@selector(onClickStartAction:) forControlEvents:UIControlEventTouchUpInside];
    startButton.frame = CGRectMake(0, 0, 60, 50);
    startButton.center = self.view.center;
    [self.view addSubview:startButton];
}

#pragma mark - Actions
- (void)onClickStartAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self goBack];
}

#pragma mark - Get&Set

@end

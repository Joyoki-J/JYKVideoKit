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

@interface ViewController ()

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
    [self presentViewController:vcRecord animated:YES completion:nil];
}


@end

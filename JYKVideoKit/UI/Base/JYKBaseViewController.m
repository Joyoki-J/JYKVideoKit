//
//  JYKBaseViewController.m
//  JYKVideoKit
//
//  Created by Joyoki on 2019/2/25.
//  Copyright © 2019年 Joyoki. All rights reserved.
//
//  github: https://github.com/Joyoki-J/JYKVideoKit
//

#import "JYKBaseViewController.h"

@interface JYKBaseViewController ()

@end

@implementation JYKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)goBack {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

//
//  JYKViewController.m
//  JYKVideoKit
//
//  Created by Jay on 2019/3/7.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import "JYKViewController.h"
#import "JYKRecordViewController.h"
#import "JYKAssertDefine.h"

@implementation JYKViewController

+ (instancetype)new {
    return [[[self class] alloc] init];
}

- (instancetype)init
{
    JYKRecordViewController *vcRecord = [[JYKRecordViewController alloc] init];
    JYKSafeAssert(vcRecord, nil);
    
    self = [super initWithRootViewController:vcRecord];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarHidden = YES;
}

#pragma mark - Orientation...

-(BOOL)shouldAutorotate {
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

@end

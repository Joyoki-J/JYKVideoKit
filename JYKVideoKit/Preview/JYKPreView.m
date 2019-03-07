//
//  JYKPreView.m
//  JYKVideoKit
//
//  Created by Joyoki on 2019/2/25.
//  Copyright © 2019年 Joyoki. All rights reserved.
//
//  github: https://github.com/Joyoki-J/JYKVideoKit
//

#import "JYKPreView.h"

@interface JYKPreView ()

@property (nonatomic, strong, readwrite) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation JYKPreView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self createPreviewLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self createPreviewLayer];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setupPreviewLayer];
}

- (void)createPreviewLayer {
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] init];
    [self setupPreviewLayer];
    [self.layer addSublayer:_previewLayer];
}

- (void)setupPreviewLayer {
    if (!CGRectEqualToRect(_previewLayer.frame, self.bounds)) {
        _previewLayer.frame = self.bounds;
    }
}

@end

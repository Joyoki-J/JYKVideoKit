//
//  UIView+JYKLayout.h
//  JYKVideoKit
//
//  Created by Jay on 2019/3/8.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JYKLayout)

@property (nonatomic) CGFloat jyk_minX;
@property (nonatomic) CGFloat jyk_minY;
@property (nonatomic) CGFloat jyk_maxX;
@property (nonatomic) CGFloat jyk_maxY;
@property (nonatomic) CGFloat jyk_width;
@property (nonatomic) CGFloat jyk_height;
@property (nonatomic) CGFloat jyk_centerX;
@property (nonatomic) CGFloat jyk_centerY;
@property (nonatomic) CGSize  jyk_size;
@property (nonatomic) CGPoint jyk_origin;

@end

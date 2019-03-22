//
//  UIView+JYKLayout.m
//  JYKVideoKit
//
//  Created by Jay on 2019/3/8.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import "UIView+JYKLayout.h"

@implementation UIView (JYKLayout)

- (void)setJyk_minX:(CGFloat)jyk_minX {
    CGRect frame = self.frame;
    frame.origin.x = jyk_minX;
    self.frame = frame;
}

- (CGFloat)jyk_minX {
    return CGRectGetMinX(self.frame);
}

- (void)setJyk_minY:(CGFloat)jyk_minY {
    CGRect frame = self.frame;
    frame.origin.y = jyk_minY;
    self.frame = frame;
}

- (CGFloat)jyk_minY {
    return CGRectGetMinY(self.frame);
}

- (void)setJyk_maxX:(CGFloat)jyk_maxX {
    CGRect frame = self.frame;
    frame.origin.x = jyk_maxX - CGRectGetWidth(frame);
    self.frame = frame;
}

- (CGFloat)jyk_maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setJyk_maxY:(CGFloat)jyk_maxY {
    CGRect frame = self.frame;
    frame.origin.y = jyk_maxY - CGRectGetHeight(frame);
    self.frame = frame;
}

- (CGFloat)jyk_maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setJyk_width:(CGFloat)jyk_width {
    CGRect frame = self.frame;
    frame.size.width = jyk_width;
    self.frame = frame;
}

- (CGFloat)jyk_width {
    return CGRectGetWidth(self.frame);
}

- (void)setJyk_height:(CGFloat)jyk_height {
    CGRect frame = self.frame;
    frame.size.height = jyk_height;
    self.frame = frame;
}

- (CGFloat)jyk_height {
    return CGRectGetHeight(self.frame);
}

- (void)setJyk_centerX:(CGFloat)jyk_centerX {
    CGPoint center = self.center;
    center.x = jyk_centerX;
    self.center = center;
}

- (CGFloat)jyk_centerX {
    return self.center.x;
}

- (void)setJyk_centerY:(CGFloat)jyk_centerY {
    CGPoint center = self.center;
    center.y = jyk_centerY;
    self.center = center;
}

- (CGFloat)jyk_centerY {
    return self.center.y;
}

- (void)setJyk_size:(CGSize)jyk_size {
    CGRect frame = self.frame;
    frame.size = jyk_size;
    self.frame = frame;
}

- (CGSize)jyk_size {
    return self.frame.size;
}

- (void)setJyk_origin:(CGPoint)jyk_origin {
    CGRect frame = self.frame;
    frame.origin = jyk_origin;
    self.frame = frame;
}

- (CGPoint)jyk_origin {
    return self.frame.origin;
}

@end

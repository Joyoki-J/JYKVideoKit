//
//  UIView+JYKLayout.m
//  JYKVideoKit
//
//  Created by Jay on 2019/3/8.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import "UIView+JYKLayout.h"

@implementation UIView (JYKLayout)

- (void)setJyk_x:(CGFloat)jyk_x {
    CGRect frame = self.frame;
    frame.origin.x = jyk_x;
    self.frame = frame;
}

- (CGFloat)jyk_x {
    return CGRectGetMinX(self.frame);
}

- (void)setJyk_y:(CGFloat)jyk_y {
    CGRect frame = self.frame;
    frame.origin.y = jyk_y;
    self.frame = frame;
}

- (CGFloat)jyk_y {
    return CGRectGetMinY(self.frame);
}

- (void)setJyk_X:(CGFloat)jyk_X {
    CGRect frame = self.frame;
    frame.origin.x = jyk_X - CGRectGetWidth(frame);
    self.frame = frame;
}

- (CGFloat)jyk_X {
    return CGRectGetMaxX(self.frame);
}

- (void)setJyk_Y:(CGFloat)jyk_Y {
    CGRect frame = self.frame;
    frame.origin.y = jyk_Y - CGRectGetHeight(frame);
    self.frame = frame;
}

- (CGFloat)jyk_Y {
    return CGRectGetMaxY(self.frame);
}

- (void)setJyk_w:(CGFloat)jyk_w {
    CGRect frame = self.frame;
    frame.size.width = jyk_w;
    self.frame = frame;
}

- (CGFloat)jyk_w {
    return CGRectGetWidth(self.frame);
}

- (void)setJyk_h:(CGFloat)jyk_h {
    CGRect frame = self.frame;
    frame.size.height = jyk_h;
    self.frame = frame;
}

- (CGFloat)jyk_h {
    return CGRectGetHeight(self.frame);
}

- (void)setJyk_cX:(CGFloat)jyk_cX {
    CGPoint center = self.center;
    center.x = jyk_cX;
    self.center = center;
}

- (CGFloat)jyk_cX {
    return self.center.x;
}

- (void)setJyk_cY:(CGFloat)jyk_cY {
    CGPoint center = self.center;
    center.y = jyk_cY;
    self.center = center;
}

- (CGFloat)jyk_cY {
    return self.center.y;
}

- (void)setJyk_s:(CGSize)jyk_s {
    CGRect frame = self.frame;
    frame.size = jyk_s;
    self.frame = frame;
}

- (CGSize)jyk_s {
    return self.frame.size;
}

- (void)setJyk_o:(CGPoint)jyk_o {
    CGRect frame = self.frame;
    frame.origin = jyk_o;
    self.frame = frame;
}

- (CGPoint)jyk_o {
    return self.frame.origin;
}

@end

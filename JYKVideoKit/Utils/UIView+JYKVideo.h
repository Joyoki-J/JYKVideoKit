//
//  UIView+JYKVideo.h
//  JYKVideoKit
//
//  Created by Jay on 2019/3/7.
//  Copyright © 2019年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JYKVideo)

@property (nonatomic) CGFloat jyk_x;  //min x
@property (nonatomic) CGFloat jyk_y;  //min y
@property (nonatomic) CGFloat jyk_X;  //max x
@property (nonatomic) CGFloat jyk_Y;  //max y
@property (nonatomic) CGFloat jyk_w;  //width
@property (nonatomic) CGFloat jyk_h;  //height
@property (nonatomic) CGFloat jyk_cX; //center x
@property (nonatomic) CGFloat jyk_cY; //center y
@property (nonatomic) CGSize  jyk_s;  //size
@property (nonatomic) CGPoint jyk_o;  //origin

@end


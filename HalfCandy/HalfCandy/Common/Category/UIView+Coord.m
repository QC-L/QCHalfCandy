//
//  UIView+Coord.m
//  HalfCandy
//
//  Created by QC.L on 16/6/5.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "UIView+Coord.h"

@implementation UIView (Coord)
- (void)setOriginX:(CGFloat)originX {
    CGRect rect = self.frame;
    rect.origin.x = originX;
    self.frame = rect;
}

- (CGFloat)originX {
    return self.frame.origin.x;
}

- (void)setOriginY:(CGFloat)originY {
    CGRect rect = self.frame;
    rect.origin.y = originY;
    self.frame = rect;
}

- (CGFloat)originY {
    return self.frame.origin.y;
}

- (void)setDestinationX:(CGFloat)destinationX {
    CGRect rect = self.frame;
    rect.origin.x = destinationX - rect.size.width;
    self.frame = rect;
}

- (CGFloat)destinationX {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setDestinationY:(CGFloat)destinationY {
    CGRect rect = self.frame;
    rect.origin.y = destinationY - rect.size.height;
    self.frame = rect;
}

- (CGFloat)destinationY {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setSize:(CGSize)size {
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX {
    CGRect rect = self.frame;
    rect.origin.x = centerX - rect.size.width / 2;
    self.frame = rect;
}

- (CGFloat)centerX {
    return self.frame.origin.x + self.frame.size.width / 2;
}

- (void)setCenterY:(CGFloat)centerY {
    CGRect rect = self.frame;
    rect.origin.y = centerY - rect.size.height / 2;
    self.frame = rect;
}

- (CGFloat)centerY {
    return self.frame.origin.y + self.frame.size.height / 2;
}

@end

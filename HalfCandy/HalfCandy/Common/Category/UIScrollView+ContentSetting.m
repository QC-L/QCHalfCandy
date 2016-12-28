//
//  UIScrollView+ContentSetting.m
//  HalfCandy
//
//  Created by QC.L on 16/6/7.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "UIScrollView+ContentSetting.h"

@implementation UIScrollView (ContentSetting)
- (void)setQc_top:(CGFloat)qc_top {
    UIEdgeInsets inset = self.contentInset;
    inset.top = qc_top;
    self.contentInset = inset;
}

- (CGFloat)qc_top {
    return self.contentInset.top;
}

- (void)setQc_left:(CGFloat)qc_left {
    UIEdgeInsets inset = self.contentInset;
    inset.left = qc_left;
    self.contentInset = inset;
}

- (CGFloat)qc_left {
    return self.contentInset.left;
}

- (void)setQc_right:(CGFloat)qc_right {
    UIEdgeInsets inset = self.contentInset;
    inset.right = qc_right;
    self.contentInset = inset;
}

- (CGFloat)qc_right {
    return self.contentInset.right;
}

- (void)setQc_bottom:(CGFloat)qc_bottom {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = qc_bottom;
    self.contentInset = inset;
}

- (CGFloat)qc_bottom {
    return self.contentInset.bottom;
}

- (void)setQc_offsetX:(CGFloat)qc_offsetX {
    CGPoint offset = self.contentOffset;
    offset.x = qc_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)qc_offsetX {
    return self.contentOffset.x;
}

- (void)setQc_offsetY:(CGFloat)qc_offsetY {
    CGPoint offset = self.contentOffset;
    offset.y = qc_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)qc_offsetY {
    return self.contentOffset.y;
}

@end

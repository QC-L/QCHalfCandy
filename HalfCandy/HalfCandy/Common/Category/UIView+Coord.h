//
//  UIView+Coord.h
//  HalfCandy
//
//  Created by QC.L on 16/6/5.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Coord)
@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGFloat destinationX;
@property (nonatomic, assign) CGFloat destinationY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@end

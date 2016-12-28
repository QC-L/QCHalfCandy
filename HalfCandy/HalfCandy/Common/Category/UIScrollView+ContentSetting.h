//
//  UIScrollView+ContentSetting.h
//  HalfCandy
//
//  Created by QC.L on 16/6/7.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ContentSetting)
// UIEdgeInsets
@property (nonatomic, assign) CGFloat qc_top;
@property (nonatomic, assign) CGFloat qc_left;
@property (nonatomic, assign) CGFloat qc_right;
@property (nonatomic, assign) CGFloat qc_bottom;
// offset
@property (nonatomic, assign) CGFloat qc_offsetY;
@property (nonatomic, assign) CGFloat qc_offsetX;

@end

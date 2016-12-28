//
//  TopNavgationView.h
//  HalfCandy
//
//  Created by QC.L on 16/6/22.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopNavgationView : UIView
@property (nonatomic, strong) UIButton *imageSearchButton; // 搜索按钮
@property (nonatomic, strong) UIButton *imageSignButton; // 签到按钮
@property (nonatomic, strong) UIButton *longSearchButton; // 长搜索按钮
@property (nonatomic, strong) UIButton *anotherSignButton;

- (void)setSignAndSearchHiddenAnimationWithChangeOffset:(CGFloat)offset
                                              endOffset:(CGFloat)endOffset;

@end

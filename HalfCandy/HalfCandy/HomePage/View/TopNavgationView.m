//
//  TopNavgationView.m
//  HalfCandy
//
//  Created by QC.L on 16/6/22.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "TopNavgationView.h"
#import "Masonry.h"
#import "UIView+Coord.h"
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

static NSString * const kSearchButtonTitle = @"搜索值得买的好物";

static CGFloat kAnimationDuration = 0.2f;

@implementation TopNavgationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createImageSignButton];
        [self createImageSearchButton];
        [self createLongSearchButton];
        [self createAnotherSignButton];
    }
    return self;
}

- (void)createLongSearchButton {
    self.longSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_longSearchButton];
    [_longSearchButton setImage:[UIImage imageNamed:@"hp_longbutton_search"] forState:UIControlStateNormal];
    [_longSearchButton setTitle:kSearchButtonTitle forState:UIControlStateNormal];
    [_longSearchButton setTitleColor:[UIColor colorWithRed:0.753 green:0.741 blue:0.702 alpha:1.000] forState:UIControlStateNormal];
    _longSearchButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _longSearchButton.backgroundColor = [UIColor colorWithWhite:0.949 alpha:1.000];
    WS(weakSelf)
    [_longSearchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.imageSignButton);
        make.width.mas_equalTo(weakSelf.mas_width).multipliedBy(5.0f / 6.0f);
        make.left.mas_equalTo(weakSelf.mas_left).offset(-1000);
        make.height.mas_equalTo(weakSelf.imageSignButton).offset(-5);
    }];
    
}

- (void)createAnotherSignButton {
    self.anotherSignButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_anotherSignButton];
    [_anotherSignButton setImage:[UIImage imageNamed:@"hp_another_sign"] forState:UIControlStateNormal];
    _anotherSignButton.backgroundColor = [UIColor whiteColor];
    _anotherSignButton.hidden = YES;
    WS(weakSelf)
    [_anotherSignButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weakSelf.imageSignButton);
    }];
    
}

- (void)createImageSignButton {
    self.imageSignButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imageSignButton setImage:[UIImage imageNamed:@"hp_sign"] forState:UIControlStateNormal];
    _imageSignButton.backgroundColor = [UIColor whiteColor];
    [self addSubview:_imageSignButton];
    [_imageSignButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-5);
        make.top.mas_equalTo(25);
        make.width.mas_equalTo(_imageSignButton.mas_height);
    }];
}

- (void)createImageSearchButton {
    self.imageSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imageSearchButton setImage:[UIImage imageNamed:@"hp_search"] forState:UIControlStateNormal];
    _imageSearchButton.backgroundColor = [UIColor whiteColor];
    [self addSubview:_imageSearchButton];
    [_imageSearchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(25);
        make.width.mas_equalTo(_imageSearchButton.mas_height);
    }];
}

- (void)showLongButtonAnimation {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [_longSearchButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
        }];
        _anotherSignButton.hidden = NO;
        [self layoutIfNeeded];
    }];
}

- (void)hiddenLongButtonAnimation {
    WS(weakSelf)
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [_longSearchButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.mas_left).offset(-1000);
        }];
        _anotherSignButton.hidden = YES;
        [self layoutIfNeeded];
    }];
}

- (void)setSignAndSearchHiddenAnimationWithChangeOffset:(CGFloat)offset
                                              endOffset:(CGFloat)endOffset {
    CGFloat offsetAlpha = offset / endOffset;
    self.backgroundColor = [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:offsetAlpha];
    _imageSearchButton.alpha = 1 - offsetAlpha;
    _imageSignButton.alpha = 1 - offsetAlpha;
    NSInteger i = offsetAlpha;
    if (i == 1) {
        [self showLongButtonAnimation];
    } else {
        [self hiddenLongButtonAnimation];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _longSearchButton.layer.cornerRadius = _longSearchButton.height / 2;
    _imageSearchButton.layer.cornerRadius = _imageSearchButton.height / 2;
    _imageSignButton.layer.cornerRadius = _imageSignButton.height / 2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

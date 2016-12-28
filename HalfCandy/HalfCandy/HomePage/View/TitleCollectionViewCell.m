//
//  TitleCollectionViewCell.m
//  HalfCandy
//
//  Created by QC.L on 16/6/12.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "TitleCollectionViewCell.h"

@interface TitleCollectionViewCell ()

@end

@implementation TitleCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = self.contentView.bounds;
}
- (void)titleLabelChangeNormal {
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:13];
}
- (void)titleLabelChangeSelect {
    _titleLabel.textColor = [UIColor redColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
}

@end

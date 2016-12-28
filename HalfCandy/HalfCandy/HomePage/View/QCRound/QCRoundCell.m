//
//  QCRoundCell.m
//  Hyatt
//
//  Created by QC.L on 15/5/26.
//  Copyright (c) 2015年 QC.L. All rights reserved.
//

#import "QCRoundCell.h"
#import "UIImageView+WebCache.h"

@interface QCRoundCell ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation QCRoundCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 40)];
        self.imageView.image = [UIImage imageNamed:@"zhanweitu"];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageurl
{
    _imageUrl = [imageurl copy];
    if ([_imageUrl hasPrefix:@"http://"] || [_imageUrl hasPrefix:@"ftp://"] || [_imageUrl hasPrefix:@"https://"]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    } else {
        self.imageView.image = [UIImage imageNamed:imageurl];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 40);
}



@end

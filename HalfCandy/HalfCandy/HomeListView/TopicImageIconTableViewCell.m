//
//  TopicImageIconTableViewCell.m
//  HalfCandy
//
//  Created by QC.L on 16/6/16.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "TopicImageIconTableViewCell.h"
#import "Masonry.h"
#import "Topic.h"
#import "UIImageView+WebCache.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

@interface TopicImageIconTableViewCell ()
@property (nonatomic, strong) UIImageView *backgroundImage;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) UILabel *imageTitleLabel;
@end

@implementation TopicImageIconTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor blackColor];
        WS(weakSelf)
        _backgroundImage = [UIImageView new];
        [self.contentView addSubview:_backgroundImage];
        
        [_backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(1);
            make.bottom.mas_equalTo(-1);
        }];
        
        _blackView = [UIView new];
        _blackView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.3];
        [_backgroundImage addSubview:_blackView];
        [_blackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
        
        _imageTitleLabel = [UILabel new];
        [self.contentView addSubview:_imageTitleLabel];
        _imageTitleLabel.textAlignment = NSTextAlignmentCenter;
        _imageTitleLabel.textColor = [UIColor whiteColor];
        _imageTitleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_imageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(weakSelf.contentView);
            make.left.mas_equalTo(10);
            make.height.mas_equalTo(weakSelf.contentView.mas_height).multipliedBy(1.0f / 4.0f);
        }];
        
    }
    return self;
}

- (void)handleDataWithModel:(id)model {
    Topic *topic = model;
    
    [_backgroundImage sd_setImageWithURL:[NSURL URLWithString:topic.pic]];
    _imageTitleLabel.text = topic.title;
    
//    if (topic.views.length != 0) {
//        [_qc_likeTime setTitle:topic.views forState:UIControlStateNormal];
//        [_qc_likeTime setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
//    } else {
//        [_qc_likeTime setTitle:topic.likes forState:UIControlStateNormal];
//        [_qc_likeTime setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
//    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

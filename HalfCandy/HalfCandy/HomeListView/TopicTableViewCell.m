//
//  TopicTableViewCell.m
//  HalfCandy
//
//  Created by QC.L on 16/6/12.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "TopicTableViewCell.h"
#import "Topic.h"
#import "Masonry.h"
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

@interface TopicTableViewCell ()
@property (nonatomic, strong) UIImageView *qc_backgroundImageView;
@property (nonatomic, strong) UILabel *qc_titleLabel;
@property (nonatomic, strong) UIButton *qc_likeTime;
@end

@implementation TopicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.qc_backgroundImageView = [UIImageView new];
        [self.contentView addSubview:_qc_backgroundImageView];
        WS(ws)
        [self.qc_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.mas_equalTo(0);
            make.height.equalTo(ws.contentView.mas_height).multipliedBy(3.0f / 4.0f);
        }];
        
        self.qc_titleLabel = [UILabel new];
        self.qc_titleLabel.textAlignment = NSTextAlignmentCenter;
        _qc_titleLabel.font = [UIFont systemFontOfSize:15];
        _qc_titleLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_qc_titleLabel];
        [self.qc_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.qc_backgroundImageView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.equalTo(ws.contentView.mas_height).multipliedBy(1.0f / 8.0f);
        }];
        
        
        self.qc_likeTime = [UIButton buttonWithType:UIButtonTypeCustom];
        _qc_likeTime.titleLabel.font = [UIFont systemFontOfSize:13];
        [_qc_likeTime setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        [self.contentView addSubview:_qc_likeTime];
        [self.qc_likeTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.qc_titleLabel.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-5);
            
        }];
        
        
    }
    return self;
}

- (void)handleDataWithModel:(id)model {
    Topic *topic = model;
    
    [_qc_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:topic.pic]];
    _qc_titleLabel.text = topic.title;
    if (topic.views.length != 0) {
        [_qc_likeTime setTitle:topic.views forState:UIControlStateNormal];
        [_qc_likeTime setImage:[UIImage imageNamed:@"hp_eye"] forState:UIControlStateNormal];
    } else {
        [_qc_likeTime setTitle:topic.likes forState:UIControlStateNormal];
        [_qc_likeTime setImage:[UIImage imageNamed:@"hp_like"] forState:UIControlStateNormal];
    }
    
    
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

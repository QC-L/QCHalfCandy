//
//  TitleCollectionViewCell.h
//  HalfCandy
//
//  Created by QC.L on 16/6/12.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLabel;

- (void)titleLabelChangeNormal;
- (void)titleLabelChangeSelect;
@end

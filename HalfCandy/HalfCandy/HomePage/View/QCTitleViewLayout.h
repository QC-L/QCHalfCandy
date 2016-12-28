//
//  QCTitleViewLayout.h
//  HalfCandy
//
//  Created by QC.L on 16/6/10.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QCTitleViewLayoutDelegate <NSObject>
@required
- (CGSize)myCollectionView:(UICollectionView *)collectionView qc_layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface QCTitleViewLayout : UICollectionViewLayout
@property (nonatomic, weak) id<QCTitleViewLayoutDelegate>delegate;
@end

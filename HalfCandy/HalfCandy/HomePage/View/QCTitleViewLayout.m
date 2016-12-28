//
//  QCTitleViewLayout.m
//  HalfCandy
//
//  Created by QC.L on 16/6/10.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCTitleViewLayout.h"
#import "UIView+Coord.h"



@interface QCTitleViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, assign) NSInteger titleWidth;

@end
// 实现Attributes
@implementation QCTitleViewLayoutAttributes

// 重写拷贝协议
- (id)copyWithZone:(NSZone *)zone
{
    QCTitleViewLayoutAttributes *layoutAttribute = (QCTitleViewLayoutAttributes *)[super copyWithZone:zone];
    layoutAttribute.titleWidth = self.titleWidth;
    return layoutAttribute;
}
// 重写比较对象的方法
- (BOOL)isEqual:(id)object
{
    QCTitleViewLayoutAttributes *layoutAttribute;
    if ((layoutAttribute = object)) {
        // 如果高度相等
        if (layoutAttribute.titleWidth == self.titleWidth) {
            // 返回判断两对象的值
            return [super isEqual:object];
        }
    }
    return false;
}

@end

@interface QCTitleViewLayout ()
@property (nonatomic, strong) NSMutableArray *attributesArray;
@property (nonatomic, assign) CGFloat itemsWidth;
@end

@implementation QCTitleViewLayout

- (NSMutableArray *)attributesArray {
    if (_attributesArray == nil) {
        self.attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

+ (Class)layoutAttributesClass {
    return [QCTitleViewLayoutAttributes class];
}
- (void)prepareLayout {
    self.collectionView.showsHorizontalScrollIndicator = NO;
    if (self.attributesArray.count != 0) {
        [self.attributesArray removeAllObjects];
    }
    _itemsWidth = 0;
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:index];
        [self.attributesArray addObject:att];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    QCTitleViewLayoutAttributes *attributes = [QCTitleViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGSize size;
    if (self.delegate && [self.delegate respondsToSelector:@selector(myCollectionView:qc_layout:sizeForItemAtIndexPath:)]) {
         size = [self.delegate myCollectionView:self.collectionView qc_layout:self sizeForItemAtIndexPath:indexPath];
    }
    
    CGFloat x = _itemsWidth;
    CGFloat y = 0;
    _itemsWidth += size.width;
    attributes.frame = CGRectMake(x, y, size.width, size.height);
    attributes.titleWidth = size.width;
    
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(_itemsWidth, 0);
}
@end

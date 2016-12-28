//
//  QCRound.m
//  Hyatt
//
//  Created by QC.L on 15/5/25.
//  Copyright (c) 2015年 QC.L. All rights reserved.
//

#import "QCRound.h"

#import "QCRoundCell.h"



static NSString * const kCollectionView = @"reuse";

#define kWidth [UIScreen mainScreen].bounds.size.width
static NSInteger kCollectionSection = 50;

@interface QCRound () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, copy) void (^ configureCell)(QCRoundCell *cell, id model);
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end


@implementation QCRound

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:_flowLayout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.pagingEnabled = YES;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[QCRoundCell class] forCellWithReuseIdentifier:kCollectionView];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, frame.size.width / 2, 30)];
        self.pageControl.center = CGPointMake(frame.size.width / 2, frame.size.height - 60);
        [self addSubview:self.pageControl];
        
        [self addTimer];

        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _pageControl.frame = CGRectMake(0, 0, self.frame.size.width / 2, 30);
    _pageControl.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 60);
}

- (void)configureCellBlock:(void (^)(QCRoundCell *cell, id model))configureCell
{
    self.configureCell = configureCell;
    [self.collectionView reloadData];
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.imageArr[(NSUInteger)indexPath.row];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QCRoundCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kCollectionView forIndexPath:indexPath];
    id model = [self itemAtIndexPath:indexPath];
    if (self.configureCell) {
        self.configureCell(cell, model);
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArr.count;
}

- (void)setImageArr:(NSArray *)imageArr
{
    
    _imageArr = [imageArr copy];
    
    self.pageControl.numberOfPages = _imageArr.count;
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:kCollectionSection / 2] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
}

- (void)addTimer
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(scrollNext) userInfo:nil repeats:YES];
    // NSRunLoop持有NSTimer, 保证安全
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;
}


- (void)removeTimer
{
    // 将NSTimer释放(release操作)
    [self.timer invalidate];
    // 置空
    self.timer = nil;
}

- (NSIndexPath *)returnIndexPath
{
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    currentIndexPath = [NSIndexPath indexPathForRow:currentIndexPath.row inSection:kCollectionSection / 2];

    [self.collectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];

    return currentIndexPath;
}

- (void)scrollNext
{
    if (self.imageArr.count == 0) {
        return;
    }
    NSIndexPath *indexPath = [self returnIndexPath];
    NSInteger item = indexPath.row + 1;
    NSInteger section = indexPath.section;
    if (item == _imageArr.count) {
        item = 0;
        section++;
    }
    self.pageControl.currentPage = item;
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:item inSection:section];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = (NSInteger)(scrollView.contentOffset.x / (kWidth - 20)) % self.imageArr.count;
    self.pageControl.currentPage = page;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return kCollectionSection;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickedIndexPath:)]) {
        [self.delegate clickedIndexPath:indexPath];
    }
}

@end

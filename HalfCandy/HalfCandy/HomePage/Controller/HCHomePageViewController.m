//
//  HCHomePageViewController.m
//  HalfCandy
//
//  Created by QC.L on 16/5/26.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "HCHomePageViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "Masonry.h"

#import "UIView+Coord.h"
#import "UIScrollView+ContentSetting.h"

#import "HomeListViewController.h"
#import "QCTitleViewLayout.h"
#import "QCViewControllerFlowLayout.h"
#import "TopicImageIconTableViewCell.h"
#import "TitleCollectionViewCell.h"
#import "QCRound.h"
#import "TopNavgationView.h"

#import "QCNetwork.h"
#import "QCHomeRequest.h"

#import "HomePageRecommend.h"
#import "HomePageData.h"
#import "Banner.h"
#import "Category_Element.h"
#import "Topic.h"



#define kQCLArc4randomColor [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1]
static CGFloat kImageHeightProportion = 240.0 / 667.0;

@interface HCHomePageViewController () <UITableViewDelegate, QCTitleViewLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) QCTitleViewLayout *titleViewFlowLayout;
@property (nonatomic, strong) UICollectionView *titleView;
@property (nonatomic, strong) UICollectionView *backgroundView;
@property (nonatomic, strong) NSMutableArray *hometablelistVCArray;
@property (nonatomic, strong) QCRound *roundImage;
@property (nonatomic, assign) CGFloat roundImageOffset;
@property (nonatomic, assign) CGFloat tableViewOffset;
@property (nonatomic, strong) NSIndexPath *currentIndex;
@property (nonatomic, strong) NSIndexPath *currentVCIndex;
@property (nonatomic, strong) QCNetworkManager *networkManager;
@property (nonatomic, strong) HomePageRecommend *recommend;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, strong) NSMutableArray *homepageTopic;
@property (nonatomic, strong) TopNavgationView *nagationView;




@end

@implementation HCHomePageViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _networkManager = [QCNetworkManager defaultManager];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _networkManager = [QCNetworkManager defaultManager];
}

#pragma - mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    [self createMainBody];
    [self createBackGroundScrollView];
    [self createNavgation];
    [self createCirclePic];
    [self createPageTitle];
    [self receiveData];
}


#pragma - mark networking
- (void)receiveData {

    QCHomeRequest *request = [[QCHomeRequest alloc] init];
    request.requestUrl = [request recommendIndex];
    [request setRequestPage:@"0" pagesize:@"20" idsOrId:nil];
    [_networkManager sendGetRequest:request completionHandler:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (error) {
            return;
        }
        self.recommend = [HomePageRecommend mj_objectWithKeyValues:responseObject];
        // 设置轮播图
        _roundImage.imageArr = self.recommend.data.banner;
        [_roundImage configureCellBlock:^(QCRoundCell *cell, Banner *model) {
            cell.imageUrl = model.photo;
        }];
        // 设置标题
        self.titleArray = [NSMutableArray arrayWithArray:self.recommend.data.category_element];
        Category_Element *categroy = [[Category_Element alloc] init];
        categroy.title = @"最新";
        [_titleArray insertObject:categroy atIndex:0];
        
        HomeListViewController *currentPage = self.childViewControllers[_currentVCIndex.row];
        self.homepageTopic = [NSMutableArray arrayWithArray:self.recommend.data.topic];
        
        [currentPage.homeListTableView beginUpdates];
        currentPage.homeListTableView.tableHeaderView = currentPage.headerView;
        [currentPage.homeListTableView endUpdates];
        [currentPage.homeListTableView.mj_header endRefreshing];

        self.currentIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        self.currentVCIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        [_titleView reloadData];
        [_backgroundView reloadData];
        [_backgroundView scrollToItemAtIndexPath:_currentIndex atScrollPosition:0 animated:NO];
        [_titleView setContentOffset:CGPointMake(0, 0)];
        
    }];
}

#pragma - mark createSubviews
- (void)createNavgation {
    self.nagationView = [[TopNavgationView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_nagationView];
    _nagationView.backgroundColor = [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:0];
    [_nagationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
}

- (void)createBackGroundScrollView {
    QCViewControllerFlowLayout *flow = [[QCViewControllerFlowLayout alloc] init];
    flow.itemSize = self.view.bounds.size;
    self.backgroundView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flow];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    _backgroundView.dataSource = self;
    _backgroundView.delegate = self;
    [self.view addSubview:_backgroundView];
    _backgroundView.bounces = NO;
    _backgroundView.pagingEnabled = YES;
    [_backgroundView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"vcCell"];
}

- (void)createCirclePic {
    self.roundImage = [[QCRound alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height * kImageHeightProportion)];
    _roundImageOffset = self.roundImage.height - (64 + 40);
}

- (void)createPageTitle {
    self.titleViewFlowLayout = [[QCTitleViewLayout alloc] init];
    _titleViewFlowLayout.delegate = self;
    self.selectView = [UIView new];
    _selectView.backgroundColor = [UIColor redColor];
    self.titleView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.roundImage.height - 40, self.view.width, 40) collectionViewLayout:_titleViewFlowLayout];
    _titleView.backgroundColor = [UIColor whiteColor];
    _titleView.delegate = self;
    _titleView.dataSource = self;
    [self.view addSubview:_titleView];
    [_titleView addSubview:_selectView];
    [_titleView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:@"titleCell"];
}

- (void)createMainBody {
    for (int i = 0; i < 2; i++) {
        HomeListViewController *vc = [[HomeListViewController alloc] init];
        [self addChildViewController:vc];
    }
}

#pragma - mark titleViewLayoutDelegate
- (CGSize)myCollectionView:(UICollectionView *)collectionView qc_layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.titleArray.count != 0) {
        Category_Element *element = self.titleArray[indexPath.row];
        CGRect rect = [element.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, collectionView.height) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil];
        
        return CGSizeMake(rect.size.width + 20, 40);
    }
    return CGSizeZero;
}

#pragma - mark CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_titleView == collectionView) {
        TitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
        Category_Element *element = self.titleArray[indexPath.row];
        cell.titleLabel.text = element.title;
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"vcCell" forIndexPath:indexPath];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == _backgroundView) {
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        HomeListViewController *vc = self.childViewControllers[indexPath.row % 2];
        vc.view.size = self.view.size;
        vc.homeListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self receiveData];
        }];
        if (_currentVCIndex.row  == indexPath.row % 2) {
            vc.homeListTableView.tableHeaderView = _roundImage;
        } else {
            vc.homeListTableView.tableHeaderView = vc.headerView;
        }
        vc.homeListTableView.delegate = self;
        if (indexPath.row == 0) {
            vc.homeListArray = self.homepageTopic;
        } else {
            vc.element = self.titleArray[indexPath.row];
        }
        vc.homeListTableView.qc_offsetY = _tableViewOffset;
        [cell.contentView addSubview:vc.view];
    }
    if (_titleView == collectionView) {
        TitleCollectionViewCell *titleCell = (TitleCollectionViewCell *)cell;
        if (_currentIndex.row == indexPath.row) {
            _selectView.frame = CGRectMake(0, 40 - 6, 30, 3);
            _selectView.centerX = cell.centerX;
            [titleCell titleLabelChangeSelect];
        } else {
            [titleCell titleLabelChangeNormal];
        }
    }
}

#pragma - mark collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeListViewController *list = self.childViewControllers[_currentVCIndex.row];
    if (_currentIndex.row == indexPath.row || list.homeListTableView.mj_header.isRefreshing || _backgroundView == collectionView) {
        return;
    }
    NSLog(@"%ld", _currentVCIndex.row);
    [self titleLabelChangeNormalColor:_currentIndex];
    [self selectViewChangeFrameWithIndexPath:indexPath];
    [self homeListViewControllerChangeHeaderNormal:_currentVCIndex];
    NSIndexPath *currentVCIndex = [NSIndexPath indexPathForRow:indexPath.row % 2 inSection:0];
    NSLog(@"%ld", currentVCIndex.row);
//    [self homeListViewControllerChangeHeaderCurrent:currentVCIndex];
    HomeListViewController *vc = self.childViewControllers[currentVCIndex.row];
    vc.homeListTableView.qc_offsetY = _tableViewOffset;
    _currentIndex = indexPath;
    _currentVCIndex = currentVCIndex;
    [_titleView scrollToItemAtIndexPath:_currentIndex atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [_backgroundView scrollToItemAtIndexPath:_currentIndex atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma - mark changeTitleLabelColor
- (TitleCollectionViewCell *)titleLabelChangeNormalColor:(NSIndexPath *)indexPath {
    TitleCollectionViewCell *cell = (TitleCollectionViewCell *)[_titleView cellForItemAtIndexPath:indexPath];
    [cell titleLabelChangeNormal];
    return cell;
}

- (TitleCollectionViewCell *)titleLabelChangeSelectColor:(NSIndexPath *)indexPath {
    TitleCollectionViewCell *cell = (TitleCollectionViewCell *)[_titleView cellForItemAtIndexPath:indexPath];
    [cell titleLabelChangeSelect];
    return cell;
}

- (void)selectViewChangeFrameWithIndexPath:(NSIndexPath *)indexPath {
    TitleCollectionViewCell *titleSelectCell = [self titleLabelChangeSelectColor:indexPath];
    [UIView animateWithDuration:0.4 animations:^{
        _selectView.centerX = titleSelectCell.centerX;
    }];
}

#pragma - mark scrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    HomeListViewController *vc = self.childViewControllers[_currentVCIndex.row];
    if (vc.homeListTableView.mj_header.isRefreshing) {
        _backgroundView.scrollEnabled = NO;
    } else {
        _backgroundView.scrollEnabled = YES;
    }
    if (scrollView == _backgroundView) {
        if (_backgroundView.isDragging) {
            _roundImage.originY = -_tableViewOffset;
            [self.view insertSubview:_roundImage belowSubview:_nagationView];
        }
        
    }
    if ([scrollView isMemberOfClass:[UITableView class]]) {
        _tableViewOffset = scrollView.qc_offsetY;
        if (_tableViewOffset >= _roundImageOffset + 4) {
            _tableViewOffset = _roundImageOffset + 4;
        }
        // 标题悬浮
        if (scrollView.qc_offsetY <= _roundImageOffset) {
            [_nagationView setSignAndSearchHiddenAnimationWithChangeOffset:scrollView.qc_offsetY endOffset:_roundImageOffset];
            _titleView.transform = CGAffineTransformMakeTranslation(0, -scrollView.qc_offsetY);
        } else {
            [_nagationView setSignAndSearchHiddenAnimationWithChangeOffset:_roundImageOffset endOffset:_roundImageOffset];
            _titleView.transform = CGAffineTransformMakeTranslation(0, -_roundImageOffset);
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _backgroundView) {
        // 计算当前页数
        NSInteger currentIndex = scrollView.contentOffset.x / self.view.bounds.size.width;
        // 计算当前下标
        NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];
        // 计算当前vc下标
        NSIndexPath *currentVCIndexPath = [NSIndexPath indexPathForRow:currentIndex % 2 inSection:0];
        // 改变以前记录的vc下标对应的vc tableView的样式
        [self homeListViewControllerChangeHeaderNormal:_currentVCIndex];
        // 记录下标
        self.currentVCIndex = currentVCIndexPath;
        // 改变新的vc对应的tableView的样式
        [self homeListViewControllerChangeHeaderCurrent:currentVCIndexPath];
        [_titleView performBatchUpdates:^{
            // 改变标题样式
            [self titleLabelChangeNormalColor:_currentIndex];
            [self selectViewChangeFrameWithIndexPath:currentIndexPath];
            _currentIndex = currentIndexPath;
            
        } completion:^(BOOL finished) {
            [_titleView scrollToItemAtIndexPath:_currentIndex atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }];
    }
}

- (HomeListViewController *)homeListViewControllerChangeHeaderNormal:(NSIndexPath *)indexPath {
    HomeListViewController *normalVC = self.childViewControllers[indexPath.row];
    [normalVC.homeListTableView beginUpdates];
    normalVC.homeListTableView.tableHeaderView = normalVC.headerView;
    [normalVC.homeListTableView endUpdates];
    return normalVC;
}

- (HomeListViewController *)homeListViewControllerChangeHeaderCurrent:(NSIndexPath *)indexPath {
    HomeListViewController *currentVC = self.childViewControllers[indexPath.row];
    [currentVC.homeListTableView beginUpdates];
    currentVC.homeListTableView.tableHeaderView = _roundImage;
    [currentVC.homeListTableView endUpdates];
    return currentVC;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

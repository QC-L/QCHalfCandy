//
//  HomeListViewController.m
//  HalfCandy
//
//  Created by QC.L on 16/6/7.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "HomeListViewController.h"
#import "UIScrollView+ContentSetting.h"
#import "UIView+Coord.h"
#import "BaseTableViewCell.h"
#import "CellFactory.h"
#import "Category_Element.h"
#import "QCHomeRequest.h"
#import "QCNetworkManager.h"
#import "Topic.h"
#import "HomePageData.h"
#import "MJExtension.h"

static CGFloat kImageHeightProportion = 240.0 / 667.0;

@interface HomeListViewController ()<UITableViewDataSource>
@property (nonatomic, strong) NSMutableDictionary *allDataDic;
@property (nonatomic, strong) QCNetworkManager *networkManager;
@end

@implementation HomeListViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _allDataDic = [NSMutableDictionary dictionary];
        _networkManager = [QCNetworkManager defaultManager];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.homeListTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.homeListTableView.dataSource = self;
    [self.view addSubview:self.homeListTableView];
    self.homeListTableView.tableFooterView = [UIView new];
    self.homeListTableView.separatorStyle = NO;
    
    [self.homeListTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.height * kImageHeightProportion)];
    _headerView.backgroundColor = [UIColor clearColor];
    _homeListTableView.tableHeaderView = _headerView;
    _homeListTableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.view.height * kImageHeightProportion, 0, 0, 0);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_homeListArray.count != 0) {
        return _homeListArray.count;
    }
    return 10;
    
}

- (void)setElement:(Category_Element *)element {
    _element = element;
    self.homeListArray = [_allDataDic objectForKey:element.title];
    if (self.homeListArray.count == 0) {
        QCHomeRequest *request = [QCHomeRequest new];
        request.requestUrl = [request valueForKey:element.type];
        [request setRequestPage:@"0" pagesize:@"20" idsOrId:_element.extend];
        [_networkManager sendGetRequest:request completionHandler:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
            if (error) {
                return;
            }
            NSDictionary *data = responseObject[@"data"];
            HomePageData *hompageData = [HomePageData mj_objectWithKeyValues:data];
            NSMutableArray *array = [NSMutableArray arrayWithArray:hompageData.topic];
            [_allDataDic setObject:array forKey:element.title];
            self.homeListArray = array;
        }];
    }  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.homeListArray.count == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        return cell;
    }
    id model = self.homeListArray[indexPath.row];
    NSString *cellReuse = [CellFactory getCellPrefix:model];
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuse];
    if (!cell) {
        cell = [CellFactory createCellWithModel:model];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell handleDataWithModel:model];
    return cell;
}

- (void)setHomeListArray:(NSArray *)homeListArray {
    _homeListArray = homeListArray;
    Topic *topic = [_homeListArray firstObject];
    if (topic && [topic.type isEqualToString:@"3"]) {
        self.homeListTableView.rowHeight = self.view.width * 1 / 2;
    } else {
        self.homeListTableView.rowHeight = self.view.width * 2 / 3;
    }
    [self.homeListTableView reloadData];
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

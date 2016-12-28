//
//  HomeListViewController.h
//  HalfCandy
//
//  Created by QC.L on 16/6/7.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Category_Element;

@interface HomeListViewController : UIViewController
@property (nonatomic, strong) UITableView *homeListTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSArray *homeListArray;
@property (nonatomic, strong) Category_Element *element;

@end

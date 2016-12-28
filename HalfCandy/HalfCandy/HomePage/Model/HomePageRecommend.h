//
//  HomePageRecommend.h
//  HalfCandy
//
//  Created by QC.L on 16/06/09
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "BaseModel.h"

@class HomePageData,Append_Extend,Category_Element,Topic,Channel,User,Video,Pics,Firstpage_Element,Banner;

@interface HomePageRecommend : BaseModel

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger ts;

@property (nonatomic, strong) HomePageData *data;

@property (nonatomic, copy) NSString *msg;

@end
//
//  HomePageData.h
//  HalfCandy
//
//  Created by QC.L on 16/06/09
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "BaseModel.h"

@class Append_Extend,Category_Element,Topic,Channel,User,Video,Pics,Firstpage_Element,Banner;

@interface HomePageData : BaseModel

@property (nonatomic, strong) NSArray *category_element;

@property (nonatomic, strong) NSArray *topic_rec;

@property (nonatomic, strong) NSArray *topic;

@property (nonatomic, strong) NSArray<Firstpage_Element *> *firstpage_element;

@property (nonatomic, strong) Append_Extend *append_extend;

@property (nonatomic, strong) NSArray *banner;

@end
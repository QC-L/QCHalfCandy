//
//  Insert_Element.h
//  HalfCandyTests
//
//  Created by QC.L on 16/06/16
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "BaseModel.h"

@class Category_Element;

@interface Insert_Element : BaseModel

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSArray<Category_Element *> *element_list;

@end
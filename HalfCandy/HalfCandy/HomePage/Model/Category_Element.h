//
//  Category_Element.h
//  HalfCandy
//
//  Created by QC.L on 16/06/09
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "BaseModel.h"

@interface Category_Element : BaseModel

@property (nonatomic, copy) NSString *extend;

@property (nonatomic, copy) NSString *parent_id;

@property (nonatomic, copy) NSString *sub_title;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger is_show_icon;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *topic_type;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *product_type;

@property (nonatomic, assign) NSInteger index;

@end
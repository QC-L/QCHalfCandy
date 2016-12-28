//
//  User.h
//  HalfCandy
//
//  Created by QC.L on 16/06/09
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "BaseModel.h"

@interface User : BaseModel

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger is_official;

@property (nonatomic, copy) NSString *avatar;

@end
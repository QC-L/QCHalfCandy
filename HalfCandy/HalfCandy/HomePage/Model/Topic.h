//
//  Topic.h
//  HalfCandy
//
//  Created by QC.L on 16/06/09
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//


#import "BaseModel.h"
@class Channel,User,Video,Pics;

@interface Topic : BaseModel

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, strong) User *user;

@property (nonatomic, strong) NSArray<Pics *> *pics;

@property (nonatomic, strong) Video *video;

@property (nonatomic, strong) Channel *channel;

@property (nonatomic, copy) NSString *likes;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, assign) BOOL is_show_like;

@property (nonatomic, assign) BOOL islike;

@property (nonatomic, copy) NSString *update_time;

@property (nonatomic, copy) NSString *views;

@end
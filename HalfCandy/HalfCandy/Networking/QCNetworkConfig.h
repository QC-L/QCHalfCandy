//
//  QCNeworkConfig.h
//  HalfCandy
//
//  Created by QC.L on 16/6/8.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QCNetworkConfig : NSObject
+ (QCNetworkConfig *)defaultConfig;

@property (nonatomic, strong) NSString *app_id;
@property (nonatomic, strong) NSString *app_installtime;
@property (nonatomic, strong) NSString *app_versions;
@property (nonatomic, strong) NSString *channel_name;
@property (nonatomic, strong) NSString *client_id;
@property (nonatomic, strong) NSString *client_secret;
@property (nonatomic, strong) NSString *device_token;
@property (nonatomic, strong) NSString *last_get_time;
@property (nonatomic, strong) NSString *oauth_token;
@property (nonatomic, strong) NSString *os_versions;
@property (nonatomic, strong) NSString *screensize;
@property (nonatomic, strong) NSString *track_device_info;
@property (nonatomic, strong) NSString *track_deviceid;
@property (nonatomic, strong) NSString *track_user_id;
@property (nonatomic, strong) NSString *v;

@end

//
//  QCNeworkConfig.m
//  HalfCandy
//
//  Created by QC.L on 16/6/8.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCNetworkConfig.h"

@implementation QCNetworkConfig

+ (QCNetworkConfig *)defaultConfig {
    static QCNetworkConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[QCNetworkConfig alloc] init];
    });
    return config;
}

- (NSString *)app_id {
    return @"com.jzyd.BanTang";
}

- (NSString *)app_installtime {
    return @"1452829287";
}

- (NSString *)app_versions {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

- (NSString *)channel_name {
    return @"appStore";
}

- (NSString *)client_id {
    return @"bt_app_ios";
}

- (NSString *)client_secret {
    return @"9c1e6634ce1c5098e056628cd66a17a5";
}

- (NSString *)device_token {
    return @"971121628322223ddb1b780d545044b0ee12c87be70c1ac0fabfb5e73a3fd61b";
}

- (NSString *)last_get_time {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f", time];
}

- (NSString *)oauth_token {
    return @"1ce893064ac1f99e534de9c9b4157351";
}

- (NSString *)os_versions {
    return [[[UIDevice currentDevice] systemVersion] description];;
}

- (NSString *)screensize {
    CGFloat width = [UIScreen mainScreen].scale * [UIScreen mainScreen].bounds.size.width;
    return [NSString stringWithFormat:@"%.0f", width];
}

- (NSString *)track_device_info {
    return @"iPhone8,1";
}

- (NSString *)track_deviceid {
    return @"BCB2EA84-CD19-400F-A6CC-7FD0A67432C5";
}

- (NSString *)track_user_id {
    return @"2159297";
}

- (NSString *)v {
    return @"14";
}

@end

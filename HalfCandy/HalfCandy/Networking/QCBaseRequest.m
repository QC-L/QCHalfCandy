//
//  QCRequest.m
//  HalfCandy
//
//  Created by QC.L on 16/6/8.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCBaseRequest.h"

@implementation QCBaseRequest

- (NSString *)baseUrl {
    return @"http://open3.bantangapp.com";
}


- (void)setRequestUrl:(NSString *)requestUrl {
    _requestUrl = [[[self baseUrl] stringByAppendingString:requestUrl] copy];
}


@end

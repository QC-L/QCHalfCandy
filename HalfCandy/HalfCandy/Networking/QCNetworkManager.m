//
//  QCNetwork.m
//  HalfCandy
//
//  Created by QC.L on 16/6/8.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCNetworkManager.h"
#import "AFNetworking.h"
#import "QCBaseRequest.h"

@implementation QCNetworkManager
+ (QCNetworkManager *)defaultManager {
    static QCNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[QCNetworkManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _opertionQueue = [[NSOperationQueue alloc] init];
//        _opertionQueue.maxConcurrentOperationCount = 1;
        
    }
    return self;
}

- (NSURLSessionDataTask *)sendGetRequest:(QCBaseRequest *)request
                       completionHandler:(CompletionHandler)completionHandler; {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLSessionDataTask *task = [manager GET:request.requestUrl parameters:request.body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(task, responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(task, nil, error);
    }];
    
    
    
    return task;
}
- (NSURLSessionDataTask *)sendPostRequest:(QCBaseRequest *)request
                        completionHandler:(CompletionHandler)completionHandler; {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *task = [manager POST:request.requestUrl parameters:request.body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(task, responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(task, nil, error);
    }];
    return task;
}


@end

//
//  QCNetwork.h
//  HalfCandy
//
//  Created by QC.L on 16/6/8.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QCBaseRequest;

typedef void (^Success)(NSURLSessionDataTask *task, id responseObject);
typedef void (^Failure)(NSURLSessionDataTask *task, NSError *error);
typedef void (^CompletionHandler)(NSURLSessionDataTask *task, id responseObject, NSError *error);

@interface QCNetworkManager : NSObject

@property (nonatomic, strong) NSOperationQueue *opertionQueue;

+ (QCNetworkManager *)defaultManager;
- (NSURLSessionDataTask *)sendGetRequest:(QCBaseRequest *)request
                       completionHandler:(CompletionHandler)completionHandler;
- (NSURLSessionDataTask *)sendPostRequest:(QCBaseRequest *)request
                        completionHandler:(CompletionHandler)completionHandler;;
@end

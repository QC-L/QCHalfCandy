//
//  QCRequest.h
//  HalfCandy
//
//  Created by QC.L on 16/6/8.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCBaseRequest : NSObject
@property (nonatomic, copy) NSString *baseUrl;
@property (nonatomic, copy) NSString *requestUrl;
@property (nonatomic, strong) NSMutableDictionary *body;
@end

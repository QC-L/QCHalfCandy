//
//  QCHomeRequest.h
//  HalfCandy
//
//  Created by QC.L on 16/6/8.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCBaseRequest.h"

@interface QCHomeRequest : QCBaseRequest

@property (nonatomic, copy) NSString *recommendIndex;
@property (nonatomic, copy) NSString *topic_list;
@property (nonatomic, copy) NSString *topic_news;
@property (nonatomic, copy) NSString *topic_viedo;
@property (nonatomic, copy) NSString *topic_scene;

- (void)setRequestPage:(NSString *)page
              pagesize:(NSString *)pagesize
                   idsOrId:(NSString *)idsOrId;

@end

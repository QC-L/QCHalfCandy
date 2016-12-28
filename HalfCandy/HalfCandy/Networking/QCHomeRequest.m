//
//  QCHomeRequest.m
//  HalfCandy
//
//  Created by QC.L on 16/6/8.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "QCHomeRequest.h"
#import "MJExtension.h"
#import "QCNetworkConfig.h"

@implementation QCHomeRequest


- (NSString *)recommendIndex {
    return @"/recommend/index";
}

- (NSString *)topic_list {
    return @"/topics/topic/listByIds";
}

- (NSString *)topic_news {
    return @"/topics/news/listByAll";
}

- (NSString *)topic_viedo {
    return @"/topics/video/listByAll";
}

- (NSString *)topic_scene {
    return @"/topics/topic/listByScene";
}

- (void)setRequestPage:(NSString *)page
              pagesize:(NSString *)pagesize
                   idsOrId:(NSString *)idsOrId {
    QCNetworkConfig *config = [QCNetworkConfig defaultConfig];
    NSDictionary *dic = [config mj_keyValues];
    self.body = [NSMutableDictionary dictionaryWithDictionary:dic];
    [self.body setObject:page forKey:@"page"];
    [self.body setObject:pagesize forKey:@"pagesize"];
    if (idsOrId) {
        if (idsOrId.length > 5) {
            [self.body setObject:idsOrId forKey:@"ids"];
        } else {
            [self.body setObject:idsOrId forKey:@"id"];
        }
    }
    
}


@end

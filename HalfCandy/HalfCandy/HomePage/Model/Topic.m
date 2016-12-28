//
//  Topic.m
//  HalfCandy
//
//  Created by QC.L on 16/06/09
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "Topic.h"
#import "Pics.h"

@implementation Topic

+ (NSDictionary *)objectClassInArray{
    return @{@"pics" : [Pics class]};
}

@end

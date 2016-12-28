//
//  HomePageData.m
//  HalfCandy
//
//  Created by QC.L on 16/06/09
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "HomePageData.h"
#import "Category_Element.h"
#import "Topic.h"
#import "Firstpage_Element.h"
#import "Banner.h"

@implementation HomePageData

+ (NSDictionary *)objectClassInArray{
    return @{@"category_element" : [Category_Element class], @"topic" : [Topic class], @"firstpage_element" : [Firstpage_Element class], @"banner" : [Banner class]};
}

@end

//
//  CellFactory.m
//  HalfCandy
//
//  Created by QC.L on 16/6/12.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "CellFactory.h"
#import "BaseTableViewCell.h"
#import "BaseModel.h"
#import "Topic.h"
@implementation CellFactory

+ (NSString *)getCellPrefix:(id)model {
    NSString *cellPrefix = nil;
    if ([model isKindOfClass:[Topic class]]) {
        Topic *topic = model;
        cellPrefix = NSStringFromClass([model class]);
        if ([topic.type isEqualToString:@"3"]) {
            cellPrefix = [cellPrefix stringByAppendingString:@"ImageIcon"];
        }
    }
    cellPrefix = [cellPrefix stringByAppendingString:@"TableViewCell"];
    return cellPrefix;
}

+ (BaseTableViewCell *)createCellWithModel:(BaseModel *)model {
    NSString *cellPrefix = [self getCellPrefix:model];
    Class cls = NSClassFromString(cellPrefix);
    BaseTableViewCell *cell = [[cls alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellPrefix];
    return cell;
}
@end

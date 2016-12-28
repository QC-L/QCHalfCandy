//
//  CellFactory.h
//  HalfCandy
//
//  Created by QC.L on 16/6/12.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseTableViewCell,BaseModel;
@interface CellFactory : NSObject
+ (NSString *)getCellPrefix:(id)model;
+ (BaseTableViewCell *)createCellWithModel:(BaseModel *)model;
@end

//
//  ITTModel.h
//  AiXinDemo
//
//  Created by shaofa on 14-2-17.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PoolDatagridModel : NSObject

@property(nonatomic, assign)int number1;
@property(nonatomic, assign)int number2;
@property(nonatomic, assign)int number3;
@property(nonatomic, assign)BOOL isUp;

- (NSComparisonResult)compareNum1:(PoolDatagridModel *)model;
- (NSComparisonResult)compareNum2:(PoolDatagridModel *)model;
- (NSComparisonResult)compareNum3:(PoolDatagridModel *)model;

@end

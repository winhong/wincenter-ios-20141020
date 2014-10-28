//
//  VmMigrateTargetsVO.m
//  WinCenter
//
//  Created by huadi on 14/10/28.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmMigrateTargetsVO.h"

@implementation VmMigrateTargetsVO
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"VmMigrateTargetVO" forKeyPath:@"propertyArrayMap.targets"];
    }
    return self;
}
@end

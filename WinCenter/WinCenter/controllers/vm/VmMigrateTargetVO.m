//
//  VmMigrateHostsVO.m
//  WinCenter
//
//  Created by huadi on 14/10/28.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmMigrateTargetVO.h"


@implementation VmMigrateTargetVO
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"VmMigrateTargetHostVO" forKeyPath:@"propertyArrayMap.hosts"];
    }
    return self;
}
@end

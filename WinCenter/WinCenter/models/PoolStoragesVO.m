//
//  PoolStorageVO.m
//  WinCenter
//
//  Created by huadi on 14/11/6.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "PoolStoragesVO.h"

@implementation PoolStoragesVO
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"PoolStorageVO" forKeyPath:@"propertyArrayMap.storages"];
    }
    return self;
}
@end

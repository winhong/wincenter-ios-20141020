//
//  PoolListResult.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-17.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "PoolListResult.h"

@implementation PoolListResult
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"PoolVO" forKeyPath:@"propertyArrayMap.resourcePools"];
    }
    return self;
}
@end

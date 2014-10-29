//
//  IpPoolsListResult.m
//  WinCenter
//
//  Created by 黄茂坚 on 14/10/28.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "IpPoolsListResult.h"

@implementation IpPoolsListResult

-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"IpPoolsVO" forKeyPath:@"propertyArrayMap.ipPools"];
    }
    return self;
}

@end

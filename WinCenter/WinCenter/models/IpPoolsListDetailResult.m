//
//  IpPoolsListDetailResult.m
//  WinCenter
//
//  Created by 黄茂坚 on 14/10/29.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "IpPoolsListDetailResult.h"

@implementation IpPoolsListDetailResult

-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"IpPoolsListDetail" forKeyPath:@"propertyArrayMap.ipList"];
    }
    return self;
}

@end

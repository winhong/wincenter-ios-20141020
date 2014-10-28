//
//  NetworkIpVmListResult.m
//  WinCenter
//
//  Created by 黄茂坚 on 14/10/28.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "NetworkIpVmListResult.h"

@implementation NetworkIpVmListResult

-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"NetworkIpVmVO" forKeyPath:@"propertyArrayMap.vms"];
    }
    return self;
}

@end

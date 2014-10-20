//
//  HostNetworkListResult.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-26.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "HostNetworkListResult.h"

@implementation HostNetworkListResult
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"HostNetworkVO" forKeyPath:@"propertyArrayMap.networks"];
    }
    return self;
}
@end

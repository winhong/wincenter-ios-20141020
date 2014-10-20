//
//  VmNetworkListResult.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-26.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmNetworkListResult.h"

@implementation VmNetworkListResult
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"VmNetworkVO" forKeyPath:@"propertyArrayMap.nics"];
    }
    return self;
}
@end

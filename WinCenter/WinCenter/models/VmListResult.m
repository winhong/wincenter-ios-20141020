//
//  VmListResult.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-18.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmListResult.h"

@implementation VmListResult
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"VmVO" forKeyPath:@"propertyArrayMap.vms"];
    }
    return self;
}
@end

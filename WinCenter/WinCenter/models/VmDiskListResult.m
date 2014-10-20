//
//  VmDiskListResult.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-26.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmDiskListResult.h"

@implementation VmDiskListResult
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"VmDiskVO" forKeyPath:@"propertyArrayMap.volumes"];
    }
    return self;
}
@end

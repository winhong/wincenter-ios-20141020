//
//  HostListResult.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-17.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "HostListResult.h"

@implementation HostListResult
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"HostVO" forKeyPath:@"propertyArrayMap.hosts"];
    }
    return self;
}
@end

//
//  HostNicListResult.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-26.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "HostNicListResult.h"

@implementation HostNicListResult
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"HostNicVO" forKeyPath:@"propertyArrayMap.pnis"];
    }
    return self;
}
@end

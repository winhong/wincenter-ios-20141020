//
//  NetworkListResult.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-18.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "NetworkListResult.h"

@implementation NetworkListResult

-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"networkVO" forKeyPath:@"propertyArrayMap.networks"];
    }
    return self;
}

@end

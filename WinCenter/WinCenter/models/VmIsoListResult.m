//
//  VmIsoListResult.m
//  WinCenter
//
//  Created by 黄茂坚 on 14/11/7.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmIsoListResult.h"

@implementation VmIsoListResult


-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"VmIsoVO" forKeyPath:@"propertyArrayMap.isos"];
    }
    return self;
}

@end

//
//  WarningInfoListResult.m
//  WinCenter-iPad
//
//  Created by 黄茂坚 on 14-9-29.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "WarningInfoListResult.h"

@implementation WarningInfoListResult

-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"WarningInfoVO" forKeyPath:@"propertyArrayMap.alarms"];
    }
    return self;
}

@end

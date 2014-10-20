//
//  ControlRecordListResult.m
//  WinCenter-iPad
//
//  Created by 黄茂坚 on 14-9-29.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "ControlRecordListResult.h"

@implementation ControlRecordListResult

-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"ControlRecordVO" forKeyPath:@"propertyArrayMap.tasks"];
    }
    return self;
}

@end

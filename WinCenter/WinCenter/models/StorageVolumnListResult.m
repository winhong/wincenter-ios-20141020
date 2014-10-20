//
//  StorageVolumnListResult.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-26.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "StorageVolumnListResult.h"

@implementation StorageVolumnListResult
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"StorageVolumnVO" forKeyPath:@"propertyArrayMap.resultList"];
    }
    return self;
}
@end

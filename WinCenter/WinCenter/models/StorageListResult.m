//
//  storageListResult.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-18.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "StorageListResult.h"

@implementation StorageListResult
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"StorageVO" forKeyPath:@"propertyArrayMap.resultList"];
    }
    return self;
}
@end

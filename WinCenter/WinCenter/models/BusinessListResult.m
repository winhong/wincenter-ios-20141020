//
//  BusinessListResult.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-18.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "BusinessListResult.h"

@implementation BusinessListResult
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"BusinessVO" forKeyPath:@"propertyArrayMap.resultList"];
    }
    return self;
}

@end

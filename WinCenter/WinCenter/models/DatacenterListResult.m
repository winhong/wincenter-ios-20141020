//
//  DatacenterListResult.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-17.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "DatacenterListResult.h"

@implementation DatacenterListResult
-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"DatacenterVO" forKeyPath:@"propertyArrayMap.dataCenters"];
    }
    return self;
}
@end

//
//  BusDomainsListResult.m
//  WinCenter
//
//  Created by 黄茂坚 on 14/10/31.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "BusDomainsListResult.h"

@implementation BusDomainsListResult

-(id)init {
    self = [super init];
    if (self) {
        [self setValue:@"BusDomainsVO" forKeyPath:@"propertyArrayMap.busDomains"];
    }
    return self;
}

@end

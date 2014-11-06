//
//  PoolElasticInfo.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-28.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "PoolElasticInfo.h"

@implementation PoolElasticInfo

- (NSString*)intervalTime_text{
    NSString *result = [self.intervalTime stringByReplacingOccurrencesOfString:@"," withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"D" withString:@"天"];
    result = [result stringByReplacingOccurrencesOfString:@"H" withString:@"小时"];
    result = [result stringByReplacingOccurrencesOfString:@"M" withString:@"分钟"];
    return result;
}
- (NSString*)balancingModeStr{
    NSString *str = [NSString new];
    if ([self.balancingMode isEqualToString:@"WLB"]) {
        str = @"负载均衡";
    }else{
        str = self.balancingMode;
    }
    return str;
}

@end

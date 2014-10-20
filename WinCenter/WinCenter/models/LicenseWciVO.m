//
//  LicenseWciVO.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-29.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "LicenseWciVO.h"

@implementation LicenseWciVO

-(NSString*) IcType_text{
    NSDictionary *stateDict = @{@"0":@"试用", @"1":@"永久"};
    
    NSString *result = [stateDict valueForKey:self.IcType];
    if((result==nil) || [result isEqualToString:@""]){
        result = self.IcType;
    }
    return result;
    
//    return [stateDict valueForKey:self.IcType];
}


@end

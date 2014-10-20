//
//  RemoteObject.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-25.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "RemoteObject.h"

@implementation RemoteObject

+(void)setCurrentDatacenterVO:(DatacenterVO*)datacenterVO{
    NSData *datacenterVOData = [NSKeyedArchiver archivedDataWithRootObject:datacenterVO];
    [[NSUserDefaults standardUserDefaults] setObject:datacenterVOData forKey:@"CurrentDatacenterVO"];
}

+(DatacenterVO *)getCurrentDatacenterVO{
    NSData *datacenterVOData = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentDatacenterVO"];
    return (DatacenterVO*)[NSKeyedUnarchiver unarchiveObjectWithData:datacenterVOData];
}

@end

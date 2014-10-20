//
//  vmNetworkVO.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-29.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "VmNetworkVO.h"

@implementation VmNetworkVO

- (NSString*)type_text{
    NSDictionary *dict = @{
                           @"EXTERNAL":@"外部网络",
                           @"INTERNAL":@"内部网络"
                           };
    
    NSString *result = [dict valueForKey:self.type];
    if((result==nil) || [result isEqualToString:@""]){
        result = @"其他";
    }
    return result;
}


@end

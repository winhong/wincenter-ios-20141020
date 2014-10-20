
//
//  vmDiskVO.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-29.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "VmDiskVO.h"

@implementation VmDiskVO

- (NSString*)type_text{
    NSDictionary *dict = @{
                                @"SYSTEM":@"系统盘",
                                @"USER":@"数据盘"
                                };
    
    NSString *result = [dict valueForKey:self.type];
    if((result==nil) || [result isEqualToString:@""]){
        result = @"其他";
    }
    return result;
}

@end

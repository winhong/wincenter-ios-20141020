//
//  StorageVolumnVO.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-26.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "StorageVolumnVO.h"

@implementation StorageVolumnVO


- (NSString*)vmNames_text{
    NSString *result = [self.vmNames stringByReplacingOccurrencesOfString:@"[" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"]" withString:@""];
    return result;
}
- (NSString*)isASnapshot_text{
    return [self.isASnapshot isEqualToString:@"true"] ? @"是" : @"否";
}
- (NSString*)state_text{
    NSDictionary *dict = @{
                           @"OK":@"可用",
                           @"USING":@"已使用",
                           @"MOUNT":@"已挂载",
                           @"UNMOUNT":@"未挂载",
                           @"MIGRATING":@"迁移中",
                           @"DELETING":@"删除中",
                           @"RESIZING":@"扩展中",
                           @"PLUGING":@"挂载中",
                           @"UNPLUGING":@"卸载中"
                           };
    
    NSString *result = [dict valueForKey:self.state];
    if((result==nil) || [result isEqualToString:@""]){
        result = self.state;
    }
    return result;
}

- (UIColor *)state_color{
    NSDictionary *dict = @{
                           @"OK":PNGreen,
                           @"USING":PNYellow,
                           @"MOUNT":PNBlue,
                           @"UNMOUNT":[UIColor lightGrayColor],
                           @"MIGRATING":PNBlue,
                           @"DELETING":PNBlue,
                           @"RESIZING":PNBlue,
                           @"PLUGING":PNBlue,
                           @"UNPLUGING":PNBlue
                           };
    
    UIColor *result = [dict valueForKey:self.state];
    if((self.state==nil) || [self.state isEqualToString:@""]){
        result = PNBlue;
    }
    return result;
}

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

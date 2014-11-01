
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
@end

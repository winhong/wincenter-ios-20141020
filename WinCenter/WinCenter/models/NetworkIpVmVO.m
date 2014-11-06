//
//  NetworkIpVmVO.m
//  WinCenter
//
//  Created by 黄茂坚 on 14/10/28.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "NetworkIpVmVO.h"

@implementation NetworkIpVmVO

- (NSString*)state_text{
    NSDictionary *stateDict = @{
                                @"OK":@"运行中",
                                @"EXECUTING":@"部署中",
                                @"CREATED":@"待部署",
                                @"STARTING":@"正在启动",
                                @"STOPPED":@"已关机",
                                @"STOPPING":@"关机中",
                                @"DELETEING":@"删除中",
                                @"RESIZING":@"调整中",
                                @"RESTARTING":@"重启中",
                                @"CONVERTING":@"转换中",
                                @"RESUMEING":@"恢复中",
                                @"SUSPENDING":@"挂起中",
                                @"SUSPENDED":@"挂起",
                                @"UNKNOWN":@"未知",
                                @"CONVERTING":@"转换中",
                                @"RELOCATING":@"迁移中",
                                @"BACKUPING":@"备份中",
                                @"RESTORING":@"还原中",
                                @"SNAPSHOT_ADDING":@"创建快照中",
                                @"SNAPSHOT_DELING":@"删除快照中",
                                @"SNAPSHOT_RECOVERING":@"快照还原中",
                                @"RENAMEING":@"修改名称中",
                                @"EXPORTING":@"导出中",
                                @"UN_MOUNTING_ISO":@"弹出iso中",
                                @"MOUNTING_ISO":@"挂载iso中",
                                @"CLONING":@"正在克隆",
                                @"SAVE_AS_TEMPLATE":@"另存为模板中"
                                };
    
    NSString *result = [stateDict valueForKey:[self.state uppercaseString]];
    if((result==nil) || [result isEqualToString:@""]){
        result = self.state;
    }
    return result;
}

- (UIColor *)state_color{
    if([self.state isEqualToString:@"OK"]){
        return PNGreen;
    }else if([self.state isEqualToString:@"STOPPED"]){
        return [UIColor lightGrayColor];
    }else{
        return PNBlue;
    }
}

@end

//
//  HostNicVO.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-27.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "HostNicVO.h"

@implementation HostNicVO

-(NSString*)duplex_text{
    return [self.duplex isEqualToString:@"FULL"] ? @"全双工" : @"半双工";
}

-(NSString*) linkState_image{
    if([self.linkState isEqualToString:@"CONNECTED"]){
        return @"网络连接-链接";
    }else if([self.linkState isEqualToString:@"DISCONNECTED"]){
        return @"网络连接-断开链接";
    }else{
        return @"网络连接-部分链接";
    }
}

@end

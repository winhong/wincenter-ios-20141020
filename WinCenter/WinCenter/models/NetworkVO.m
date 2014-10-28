//
//  NetworkVO.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-28.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "NetworkVO.h"

@implementation NetworkVO

-(NSString*) state_text{
    if([self.state isEqualToString:@"CONNECTED"]){
        return @"已连接";
    }else if([self.state isEqualToString:@"FREE"]){
        return @"可用";
    }else if([self.state isEqualToString:@"IN_USED"]){
        return @"在用";
    }else{
        return @"其他";
    }
}

-(NSString*) linkState_image{
    if([self.linkState isEqualToString:@"CONNECTED"]){
        return @"链接";
    }else if([self.linkState isEqualToString:@"DISCONNECTED"]){
        return @"断开链接";
    }else{
        return @"部分链接";
    }
}

@end

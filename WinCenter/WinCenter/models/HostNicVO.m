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
    if([self.linkeState isEqualToString:@"Up"]){
        return @"链接";
    }else if([self.linkeState isEqualToString:@"Detach"]){
        return @"断开链接";
    }else{
        return @"部分链接";
    }
}

@end

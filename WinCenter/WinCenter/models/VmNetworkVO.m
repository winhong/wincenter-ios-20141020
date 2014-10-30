//
//  vmNetworkVO.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-29.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "VmNetworkVO.h"

@implementation VmNetworkVO

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

-(UIColor*) state_color{
    if([self.state isEqualToString:@"CONNECTED"]){
        return PNGreen;
    }else if([self.state isEqualToString:@"FREE"]){
        return PNBlue;
    }else if([self.state isEqualToString:@"IN_USED"]){
        return PNYellow;
    }else{
        return PNBlue;
    }
}

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

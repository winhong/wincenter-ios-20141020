//
//  NetworkIpVmVO.h
//  WinCenter
//
//  Created by 黄茂坚 on 14/10/28.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkIpVmVO : NSObject

@property NSString *name;
@property NSString *ip;
@property NSString *state;

-(NSString*) state_text;

@end

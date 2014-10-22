//
//  HostSubStateVO.h
//  WinCenter
//
//  Created by huadi on 14/10/20.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostSubStateVO : NSObject

@property int OK;
@property int DISCONNECT;
@property int other;
-(int)total;
@end

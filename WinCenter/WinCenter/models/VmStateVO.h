//
//  VmState.h
//  WinCenter
//
//  Created by huadi on 14/10/21.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VmStateVO : NSObject

@property int OK;
@property int other;
@property int STOPPED;
-(int)total;
@end

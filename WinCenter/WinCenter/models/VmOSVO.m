//
//  VmOS.m
//  WinCenter
//
//  Created by huadi on 14/10/21.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmOSVO.h"

@implementation VmOSVO

-(int)total{
    return self.Windows+self.Linux;
}

@end

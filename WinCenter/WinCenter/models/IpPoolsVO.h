//
//  IpPoolsVO.h
//  WinCenter
//
//  Created by 黄茂坚 on 14/10/28.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IpPoolsVO : NSObject

@property NSString *segment;
@property int total;
@property int usable;
@property int used;
@property int ipPoolId;
@property NSString *vlanIdList;
@end

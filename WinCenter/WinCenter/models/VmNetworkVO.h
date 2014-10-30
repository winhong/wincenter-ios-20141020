//
//  vmNetworkVO.h
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-29.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VmNetworkVO : NSObject
@property int nicId;
@property NSString *name;
@property NSString *state;
@property NSString *type;
@property NSString *ip;
@property NSString *macAddr;
@property int vlanId;


- (NSString*)type_text;
- (NSString*)state_text;
- (UIColor *)state_color;

@end

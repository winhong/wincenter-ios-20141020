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

@property NSString *type;
@property NSString *ip;
@property NSString *macAddr;
@property int vlanId;

@property NSString *state;

- (NSString*)type_text;

@end

//
//  HostNicVO.h
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-27.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostNicVO : NSObject


@property NSString *name;
@property NSString *duplex;
@property NSString *macAddress;
@property int speed;//Mbit/s
@property int mtu;//Byte
@property NSString *vendor;
@property NSString *device;
@property NSString *linkState;

-(NSString*)duplex_text;
-(NSString*) linkState_image;

@end

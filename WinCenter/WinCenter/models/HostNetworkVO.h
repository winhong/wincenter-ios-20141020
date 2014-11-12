//
//  HostNetworkVO.h
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-27.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostNetworkVO : NSObject

@property NSString *name;
@property NSString *linkState;
@property NSString *state;
@property NSString *pniName;
@property NSString *vlanId;
@property NSString *type;

-(NSString*) state_text;
- (UIColor *)state_color;
-(NSString*) linkState_image;
@end

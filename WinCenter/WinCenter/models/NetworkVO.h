//
//  NetworkVO.h
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-28.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkVO : NSObject

@property NSString *name;
@property NSString *vlanId;
@property NSString *state;
@property NSString *linkState;

-(NSString*) state_text;
-(NSString*) linkState_image;
-(UIColor*) state_color;

@end

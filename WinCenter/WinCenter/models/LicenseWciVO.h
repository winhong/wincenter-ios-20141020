//
//  LicenseWciVO.h
//  WinCenter-iPad
//
//  Created by huadi on 14-9-29.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LicenseWciVO : NSObject
@property NSString *custName;
@property NSString *orgName;
@property NSString *email;
@property NSString *phone;
@property NSString *IcType;
@property int IcNum;

-(NSString*) IcType_text;

@end

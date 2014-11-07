//
//  VmIsoVO.h
//  WinCenter
//
//  Created by 黄茂坚 on 14/11/7.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VmIsoVO : NSObject

@property NSString *isoName;
@property float isoSize;
@property NSString *status;
@property NSString *path;

- (NSString*)state_text;
- (UIColor *)state_color;
- (float)isoSize_value;
- (NSString*)isoSize_unit;

@end

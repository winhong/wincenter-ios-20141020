//
//  StorageVolumnVO.h
//  WinCenter-iPad
//
//  Created by huadi on 14-9-26.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageVolumnVO : NSObject

@property NSString *name;
@property NSString *shared;
@property float size;
@property NSString *state;
@property NSString *isASnapshot;
@property NSString *type;
@property NSString *vmNames;
@property NSString *storagePoolName;

- (NSString*)vmNames_text;
- (NSString*)isASnapshot_text;
- (NSString*)state_text;
- (UIColor *)state_color;
- (NSString*)type_text;
@end

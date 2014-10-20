//
//  vmDiskVO.h
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-29.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VmDiskVO : NSObject

@property NSString *name;
@property NSString *type;
@property NSString *storagePoolName;
@property int size;

- (NSString*)type_text;

@end

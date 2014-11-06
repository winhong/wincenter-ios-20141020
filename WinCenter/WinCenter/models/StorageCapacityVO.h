//
//  StorageCapacityVO.h
//  WinCenter
//
//  Created by huadi on 14/10/21.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageCapacityVO : NSObject

@property float usedStorage;
@property float availStorage;

- (float)usedStorage_value;
- (NSString*)usedStorage_unit;
- (float)availStorage_value;
- (NSString*)availStorage_unit;

@end

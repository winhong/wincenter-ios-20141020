//
//  StorageShareVO.h
//  WinCenter
//
//  Created by huadi on 14/10/21.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageTotalVO : NSObject

@property float true_field;
@property float false_field;

- (float)totalStorage_value;
- (NSString*)totalStorage_unit;
- (float)shareStorage_value;
- (NSString*)shareStorage_unit;
- (float)localStorage_value;
- (NSString*)localStorage_unit;

@end

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
@property int vlanCount;
@property NSString *ipRange;
@property int ipCount;
@property int ipUnusedCount;

@end

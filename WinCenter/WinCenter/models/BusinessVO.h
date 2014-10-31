//
//  BusinessVO.h
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-28.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessVO : RemoteObject

@property int busId;
@property int busDomainId;
@property NSString *name;
@property NSString *managerId;
@property NSString *createTime;
@property NSString *createUser;
@property NSString *desc;
@property int vmNum;
@property NSArray *wceBusVms;
@property NSString *sysSrc;

- (void) getBusinessVOAsync:(FetchObjectCompletionBlock)completeBlock;
- (void) getBusinessVmListAsync:(FetchObjectCompletionBlock)completeBlock referTo:(NSMutableArray*)referList;

@end

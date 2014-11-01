//
//  BusDomainsVO.h
//  WinCenter
//
//  Created by 黄茂坚 on 14/10/31.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusDomainsVO : NSObject

@property NSString *busDomainName;
@property int busDomainId;

- (void) getBusinessListAsync:(FetchObjectCompletionBlock)completionBlock referTo:(NSMutableArray*)referList;

@end

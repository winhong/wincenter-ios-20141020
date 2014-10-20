//
//  ITTSegement.h
//  AiXinDemo
//
//  Created by shaofa on 14-2-17.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PoolDatagridArrow.h"
@interface PoolDatagridSegement : UIControl

@property(nonatomic, retain)NSArray *items;
@property(nonatomic, assign)int selectedIndex;
@property(nonatomic, assign)ArrowStates currentState;

-(id)initWithItems:(NSArray *)items;

@end

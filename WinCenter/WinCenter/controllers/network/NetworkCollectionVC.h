//
//  NetworkInsideVC.h
//  wincenterDemo01
//
//  Created by huadi on 14-8-15.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkCollectionVC : UITableViewController
@property IpPoolsVO *ipPoolVO;
@property NetworkVO *network;
@property BOOL isExternal;
-(void)reloadData;
-(void)clearData;
@property BOOL isDetailPagePushed;
@end

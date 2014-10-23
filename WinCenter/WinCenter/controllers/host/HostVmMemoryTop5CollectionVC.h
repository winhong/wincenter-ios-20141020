//
//  HostVmMemoryTop5CollectionVC.h
//  WinCenter
//
//  Created by huadi on 14/10/23.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HostVmMemoryTop5CollectionVC : UICollectionViewController

@property HostVO *hostVO;
@property NSArray *vmList;
@property NSMutableArray *vmList_sorted;

@end

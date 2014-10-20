//
//  BusinessVmCollectionVC.h
//  WinCenter-iPad
//
//  Created by apple on 14-10-9.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessVmCollectionVC : UICollectionViewController

@property BusinessVO *businessVO;
@property NSArray *dataList;
@property BOOL isDetailPagePushed;

@end

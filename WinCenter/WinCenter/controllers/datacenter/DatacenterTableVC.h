//
//  DatacenterPopVC.h
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-29.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DashboardTableVC;

@protocol DatacenterTableVCDelegate
- (void)didFinished:(DatacenterVO *)vo;
@end

@interface DatacenterTableVC : UITableViewController

@property DatacenterVO *selectedDatacenterVO;
@property (weak, nonatomic) id <DatacenterTableVCDelegate> delegate;

@end

//
//  VmMigrateSelectHostListVC.h
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-27.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol VmMigrateSelectHostListVCDelegate
- (void)didSelecteded:(VmMigrateTargetHostVO *)vo;
@end


@interface VmMigrateSelectHostListVC : UITableViewController

@property VmVO *vmVO;
@property VmMigrateTargetsVO *vmMigrateTargets;

@property (weak, nonatomic) id <VmMigrateSelectHostListVCDelegate> delegate;


@end

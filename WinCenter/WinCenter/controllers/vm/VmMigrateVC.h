//
//  VmMigrateVC.h
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-27.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VmMigrateSelectHostListVC.h"

@interface VmMigrateVC : UITableViewController<VmMigrateSelectHostListVCDelegate>
@property VmVO *vmVO;

@end

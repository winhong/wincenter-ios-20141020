//
//  StorageContainerVC.h
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "MasterContainerVC.h"

@interface StorageContainerVC : MasterContainerVC

@property StorageVO *storageVO;

@property (weak, nonatomic) IBOutlet UIButton *buttonTask;
@property BOOL hasDiskPage;
@end

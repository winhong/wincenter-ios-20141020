//
//  HostContainerVC.h
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "MasterContainerVC.h"

@interface HostContainerVC : MasterContainerVC

@property HostVO *hostVO;

@property (weak, nonatomic) IBOutlet UIButton *btnCreateVM;
@property (weak, nonatomic) IBOutlet UIButton *buttonTask;

@end

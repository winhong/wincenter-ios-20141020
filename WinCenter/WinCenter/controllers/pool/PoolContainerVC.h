//
//  PoolContainerVC.h
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "MasterContainerVC.h"

@interface PoolContainerVC : MasterContainerVC

@property PoolVO *poolVO;

@property (weak, nonatomic) IBOutlet UIButton *buttonTask;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

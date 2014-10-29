//
//  VmContainerVC.h
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "MasterContainerVC.h"
#import "RRCircularMenu.h"

@interface VmContainerVC : MasterContainerVC<UIActionSheetDelegate, RRCircularMenuDelegate>{
    RRCircularMenu *menu;
    UITapGestureRecognizer *tap;
}

@property VmVO *vmVO;
@property (weak, nonatomic) IBOutlet UIView *vmControlButtons;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnStart;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnStop;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnRestart;
@property (weak, nonatomic) IBOutlet UIButton *btnMigrate;

@property (weak, nonatomic) IBOutlet UIButton *btnOperation;
@property (weak, nonatomic) IBOutlet UIButton *buttonTask;

@property (weak, nonatomic) IBOutlet UILabel *ipLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *runningTime;

@property BOOL hasPerformancePage;
@property (weak, nonatomic) IBOutlet UILabel *name;


@end

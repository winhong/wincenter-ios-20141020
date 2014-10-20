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
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UIButton *btnStop;
@property (weak, nonatomic) IBOutlet UIButton *btnRestart;
@property (weak, nonatomic) IBOutlet UIButton *btnMigrate;

@property (weak, nonatomic) IBOutlet UIButton *btnOperation;
@property (weak, nonatomic) IBOutlet UIButton *buttonTask;

@property BOOL hasPerformancePage;

@end

//
//  PopOptionsPasswordVC.h
//  WinCenter
//
//  Created by huadi on 14/10/28.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserVO.h"

@interface PopOptionsPasswordVC : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *passwordOld;
@property (weak, nonatomic) IBOutlet UITextField *passwordNew;
@property (weak, nonatomic) IBOutlet UITextField *passwordRepeat;

@property UserVO *user;

@end

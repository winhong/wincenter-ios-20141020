//
//  PopOptionsUserInfoVC.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-28.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "PopOptionsUserInfoVC.h"

@interface PopOptionsUserInfoVC ()

@property UserVO *userVO;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UILabel *roleName;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *mobilephone;

@end

@implementation PopOptionsUserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UserVO getUserVOAsync:^(id object, NSError *error) {
        self.userVO = object;
        [self refresh];
    }];
}

-(void)refresh{
    self.name.text = self.userVO.name;
    if (self.name.text.length > 31) {
        self.name.font = [UIFont systemFontOfSize:16.0f];
    }
    self.account.text = self.userVO.account;
    self.roleName.text = [self.userVO roleName_text];
    self.email.text = self.userVO.email;
    self.mobilephone.text = self.userVO.mobilephone;
}


@end

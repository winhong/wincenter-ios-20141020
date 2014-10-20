//
//  ipSetVC.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-27.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "LoginSettingVC.h"

@interface LoginSettingVC ()
@property (weak, nonatomic) IBOutlet UITextField *ipAddress;

@end

@implementation LoginSettingVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ipAddress.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"SERVER_ROOT"];
    [self.ipAddress becomeFirstResponder];
}

- (IBAction)close:(id)sender {
    [self.ipAddress resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)done:(id)sender {
    [[NSUserDefaults standardUserDefaults] setValue:self.ipAddress.text forKey:@"SERVER_ROOT"];
    [self.ipAddress resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

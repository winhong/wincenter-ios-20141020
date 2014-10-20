//
//  LoginTableVC.m
//  WinCenter-iPhone
//
//  Created by apple on 14-10-9.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "LoginTableVC.h"
#import "VWWWaterView.h"
#import <AFViewShaker/AFViewShaker.h>

@interface LoginTableVC ()
@property NSArray *datacenters;
@property AFViewShaker *viewShaker;
@end

@implementation LoginTableVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.userName becomeFirstResponder];
    CGRect rect = [[UIScreen mainScreen] bounds];
    self.tableView.backgroundView = [[UIView alloc] initWithFrame:rect];
    self.tableView.backgroundView.backgroundColor = [UIColor clearColor];
    
    //波纹
    VWWWaterView *waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(0, 200, rect.size.width, rect.size.height)];
    waterView.currentWaterColor = [UIColor colorWithHexString:@"#48a8d0"];
    waterView.currentLinePointY = 250;
    waterView.waterWidth = 1024;
    waterView.waterHeight = 5;
    waterView.speed = 0.03;
    [self.tableView.backgroundView addSubview:waterView];
    
    waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(0, 200, rect.size.width, rect.size.height)];
    waterView.currentWaterColor = [UIColor colorWithHexString:@"#6ebedf"];
    waterView.currentLinePointY = 280;
    waterView.waterWidth = 1024;
    waterView.waterHeight = 7;
    waterView.speed = -0.045;
    [self.tableView.backgroundView addSubview:waterView];
    
    waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(0, 200, rect.size.width, rect.size.height)];
    waterView.currentWaterColor = [UIColor colorWithHexString:@"#b4e8fe"];
    waterView.currentLinePointY = 310;
    waterView.waterWidth = 1024;
    waterView.waterHeight = 9;
    waterView.speed = 0.0375;
    [self.tableView.backgroundView addSubview:waterView];
    
    self.viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[self.userName, self.password]];
    
}
- (IBAction)exitInput:(id)sender {
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)enjoyAction:(id)sender {
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
    
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"isDemo"];
    [[NSUserDefaults standardUserDefaults] setValue:@"SUCCESS" forKey:@"LOGIN_STATE"];
    [self toLogin];
}

- (IBAction)loginAction:(id)sender {
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
    
    NSString *msg = @"";
    if ([self.userName.text isEqualToString:@""]) {
        msg = @"用户名不能为空！";
    }else if([self.password.text isEqualToString:@""]){
        msg = @"密码不能为空！";
    }
    
    if ([msg isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"isDemo"];
        
        [LoginVO login:self.userName.text withPassword:self.password.text withSucceedBlock:^(NSError *error){
            [self toLogin];
        } withFailedBlock:^(NSError *error){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录提示" message:@"用户名或密码错误！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }];
    }else{
        //UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //[alert show];
        [self.viewShaker shake];
    }
}

- (void) toLogin{
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Datacenter" bundle:nil] instantiateViewController:@"DashboardTableVCNav"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)backToLogin:(UIStoryboardSegue*)segue{
    
}

@end

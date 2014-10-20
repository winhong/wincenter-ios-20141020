//
//  LoginVC.m
//  wincenterDemo01
//
//  Created by huadi on 14-8-20.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "LoginVC.h"
#import "UserListResult.h"
#import "MasterContainerVC.h"
#import "VWWWaterView.h"

@interface LoginVC ()
@property NSArray *datacenters;
@end

@implementation LoginVC

- (void)viewDidLayoutSubviews{
    self.formScrollView.contentSize = CGSizeMake(687, 768);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.themeName!=nil){
        [[NSUserDefaults standardUserDefaults] setObject:self.themeName forKey:@"Storyboard_Theme"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Storyboard_Theme"];
    }
    // Do any additional setup after loading the view.
    
    //[self.userName becomeFirstResponder];
    
    //波纹
    CGRect rect = [[UIScreen mainScreen] bounds];
    VWWWaterView *waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(0, 280, rect.size.width, rect.size.height)];
    waterView.currentWaterColor = [UIColor colorWithHexString:@"#48a8d0"];
    waterView.currentLinePointY = 250;
    waterView.waterWidth = 1024;
    waterView.waterHeight = 5;
    waterView.speed = 0.03;
    [self.view addSubview:waterView];
    
    waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(0, 280, rect.size.width, rect.size.height)];
    waterView.currentWaterColor = [UIColor colorWithHexString:@"#6ebedf"];
    waterView.currentLinePointY = 280;
    waterView.waterWidth = 1024;
    waterView.waterHeight = 7;
    waterView.speed = -0.045;
    [self.view addSubview:waterView];
    
    waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(0, 280, rect.size.width, rect.size.height)];
    waterView.currentWaterColor = [UIColor colorWithHexString:@"#b4e8fe"];
    waterView.currentLinePointY = 310;
    waterView.waterWidth = 1024;
    waterView.waterHeight = 9;
    waterView.speed = 0.0375;
    [self.view addSubview:waterView];
    
    waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(0, 280, rect.size.width, rect.size.height)];
    waterView.currentWaterColor = [UIColor colorWithHexString:@"#ffffff"];
    waterView.currentLinePointY = 350;
    waterView.waterWidth = 1024;
    waterView.waterHeight = 11;
    waterView.speed = -0.04;
    [self.view addSubview:waterView];
    
    [self.view bringSubviewToFront: self.formScrollView];
    
}
- (IBAction)exitInput:(id)sender {
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
    [self.ip resignFirstResponder];
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
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

- (void) toLogin{

    
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Datacenter" bundle:nil] instantiateInitialViewController];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)backToLogin:(UIStoryboardSegue*)segue{
    
}

@end

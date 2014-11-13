//
//  LoginTableVC.m
//  WinCenter-iPhone
//
//  Created by apple on 14-10-9.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "LoginVC.h"
#import "VWWWaterView.h"
#import <AFViewShaker/AFViewShaker.h>

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UITableViewCell *cell0;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell1;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell2;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell3;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell4;
@property NSArray *datacenters;
@property AFViewShaker *viewShaker;
@end

@implementation LoginVC

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.userName.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"USER_NAME"];
    //self.password.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"PASSWORD"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.ipAddress.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"SERVER_ROOT"];
    //[self.userName becomeFirstResponder];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.cell0.backgroundColor = [UIColor clearColor];
        self.cell1.backgroundColor = [UIColor clearColor];
        self.cell2.backgroundColor = [UIColor clearColor];
        self.cell3.backgroundColor = [UIColor clearColor];
        self.cell4.backgroundColor = [UIColor clearColor];
        UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
        
        [backView addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginbg"]]];
        
        //波纹
        CGRect rect = [[UIScreen mainScreen] bounds];
        VWWWaterView *waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(0, 280, rect.size.width, rect.size.height)];
        waterView.currentWaterColor = [UIColor colorWithHexString:@"#48a8d0"];
        waterView.currentLinePointY = 250;
        waterView.waterWidth = 1024;
        waterView.waterHeight = 5;
        waterView.speed = 0.03;
        [backView addSubview:waterView];
        
        waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(0, 280, rect.size.width, rect.size.height)];
        waterView.currentWaterColor = [UIColor colorWithHexString:@"#6ebedf"];
        waterView.currentLinePointY = 280;
        waterView.waterWidth = 1024;
        waterView.waterHeight = 7;
        waterView.speed = -0.045;
        [backView addSubview:waterView];
        
        waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(0, 280, rect.size.width, rect.size.height)];
        waterView.currentWaterColor = [UIColor colorWithHexString:@"#b4e8fe"];
        waterView.currentLinePointY = 310;
        waterView.waterWidth = 1024;
        waterView.waterHeight = 9;
        waterView.speed = 0.0375;
        [backView addSubview:waterView];
        
        waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(0, 280, rect.size.width, rect.size.height)];
        waterView.currentWaterColor = [UIColor colorWithHexString:@"#ffffff"];
        waterView.currentLinePointY = 350;
        waterView.waterWidth = 1024;
        waterView.waterHeight = 11;
        waterView.speed = -0.04;
        [backView addSubview:waterView];
        
        self.tableView.backgroundView = backView;
        
    }else{
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
    }
    
    self.viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[self.ipAddress, self.userName, self.password]];
    
//    [self.userName addTarget:self action:@selector(nextOnKeyboardUserName:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    [self.userName addTarget:self action:@selector(nextOnKeyboardUserName:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
}

- (IBAction)exitAddress:(id)sender {
    if(((UITextField*)sender).returnKeyType==UIReturnKeyNext){
        [self.userName becomeFirstResponder];
    }else{
        [self.ipAddress resignFirstResponder];
    }
}
- (IBAction)exitUsername:(id)sender {
    if(((UITextField*)sender).returnKeyType==UIReturnKeyNext){
        [self.password becomeFirstResponder];
    }else{
        [self.userName resignFirstResponder];
    }
}
- (IBAction)exitPassword:(id)sender {
    if(((UITextField*)sender).returnKeyType==UIReturnKeyDone){
        [self loginAction:nil];
    }else{
        [self.password resignFirstResponder];
    }
}

- (IBAction)exitInput:(id)sender {
    [self.ipAddress resignFirstResponder];
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)nextOnKeyboard:(UITextField *)sender{
    if (sender == self.userName) {
        [self.password becomeFirstResponder];
    }else if (sender == self.ipAddress){
        [self.userName becomeFirstResponder];
    }else{
        [sender resignFirstResponder];
    }
    
}
- (IBAction)enjoyAction:(id)sender {
    [self.ipAddress resignFirstResponder];
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
    
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"isDemo"];
    [[NSUserDefaults standardUserDefaults] setValue:@"SUCCESS" forKey:@"LOGIN_STATE"];
    [self toLogin];
}


- (IBAction)loginAction:(id)sender {
    [self.ipAddress resignFirstResponder];
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
    
    NSString *msg = @"";
    self.ipAddress.text = [self.ipAddress.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.userName.text = [self.userName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.password.text = [self.password.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([self.ipAddress.text isEqualToString:@""]) {
        msg = @"服务器地址不能为空！";
    }else if ([self.userName.text isEqualToString:@""]) {
        msg = @"用户名不能为空！";
    }else if([self.password.text isEqualToString:@""]){
        msg = @"密码不能为空！";
    }
    
    
    
    if ([msg isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults] setValue:self.ipAddress.text forKey:@"SERVER_ROOT"];
        [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"isDemo"];
        
        [LoginVO login:self.userName.text withPassword:self.password.text withSucceedBlock:^(NSError *error){
            [[NSUserDefaults standardUserDefaults] setValue:self.userName.text forKey:@"USER_NAME"];
            [[NSUserDefaults standardUserDefaults] setValue:self.password.text forKey:@"PASSWORD"];
            
            [LicenseVO checkLicenseAsync:^(id object, NSError *error) {
                LicenseCheckVO *checkVO = object;
                if(checkVO.errorState!=6 && checkVO.errorState!=11){
                    [self toLogin];
                }else{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录提示" message:@"许可证检查失败或许可证数量不足！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
            }];
            
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
    
//    self.userName.text = @"";
    self.password.text = @"";
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Datacenter" bundle:nil] instantiateInitialViewController];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:vc animated:YES completion:nil];

    }else{
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Datacenter" bundle:nil] instantiateViewController:@"DashboardTableVCNav"];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (IBAction)backToLogin:(UIStoryboardSegue*)segue{
    
}

@end

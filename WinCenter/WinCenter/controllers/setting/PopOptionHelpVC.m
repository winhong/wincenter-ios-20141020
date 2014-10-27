//
//  PopOptionHelpVC.m
//  WinCenter
//
//  Created by fengzj on 14/10/27.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "PopOptionHelpVC.h"

@interface PopOptionHelpVC ()

@end

@implementation PopOptionHelpVC

- (void)viewDidLoad {
    self.url = [NSURL URLWithString:@"https://192.168.213.147:8090/pages/help/helpWord.htm"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

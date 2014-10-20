//
//  Big3RevenueViewController.m
//  WinCenter-iPhone
//
//  Created by apple on 14-10-15.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "Big3RevenueViewController.h"
#import "Example4.h"

@interface Big3RevenueViewController ()

@end

@implementation Big3RevenueViewController

- (void)viewDidLoad {
    Example4 *example = [[Example4 alloc] init];
    [self setFrd3dBarChartDelegate:example];
    [self setUseCylinders:YES];
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
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

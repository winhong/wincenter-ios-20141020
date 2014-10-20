//
//  SimpleChartViewController.m
//  WinCenter-iPhone
//
//  Created by apple on 14-10-15.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "SimpleChartViewController.h"
#import "Example3.h"

@interface SimpleChartViewController ()

@end

@implementation SimpleChartViewController

- (void)viewDidLoad {
    Example3 *example3 = [[Example3 alloc] init];
    [example3 regenerateValues];
    [self setFrd3dBarChartDelegate:example3];
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

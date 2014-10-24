//
//  ClickThroughRatesViewController.m
//  FRD3DBarChart
//
//  Created by Sebastien Windal on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ClickThroughRatesViewController.h"
#import "FRD3DBarChartViewController.h"
#import "Example2.h"

@interface ClickThroughRatesViewController ()

@property (nonatomic,strong) Example2 *example;
@end

@implementation ClickThroughRatesViewController
@synthesize example = _example;
- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    self.example = [[Example2 alloc] init];
    self.example.dataSet = kExample2DataSetFacebook;
    self.frd3dBarChartDelegate = self.example;
    
    [super viewDidLoad];
    
    [self updateChartAnimated:NO animationDuration:0.0 options:0];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
- (IBAction)segmentAction:(id)sender {
    if(((UISegmentedControl*)sender).selectedSegmentIndex==0){
        [self facebookAction:nil];
    }else{
        [self twitterAction:nil];
    }
}

- (IBAction)facebookAction:(id)sender {
    [self.example setDataSet:kExample2DataSetFacebook];
    [self updateChartAnimated:YES animationDuration:1.0 options:kUpdateChartOptionsDoNotUpdateLegends];
}

- (IBAction)twitterAction:(id)sender {
    [self.example setDataSet:kExample2DataSetTwitter];
    [self updateChartAnimated:YES animationDuration:1.0 options:kUpdateChartOptionsDoNotUpdateLegends];
}

@end

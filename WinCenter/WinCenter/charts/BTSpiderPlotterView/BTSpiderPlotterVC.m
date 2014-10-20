//
//  ViewController.m
//  BTSpiderPlotterViewExample
//
//  Created by Byte on 10/14/13.
//  Copyright (c) 2013 Byte. All rights reserved.
//

#import "BTSpiderPlotterVC.h"

@interface BTSpiderPlotterVC ()

@end

@implementation BTSpiderPlotterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *valueDictionary = @{@"Design": @"6",
                                      @"Display Life": @"8",
                                      @"Camera" : @"5",
                                      @"Reception": @"3",
                                      @"Performance" : @"7",
                                      @"Software": @"6",
                                      @"Battery Life" : @"2",
                                      @"Ecosystem": @"4"};
    
    BTSpiderPlotterView *spiderView = [[BTSpiderPlotterView alloc] initWithFrame:self.view.frame valueDictionary:valueDictionary];
    spiderView.plotColor = [UIColor colorWithRed:.8 green:.4 blue:.3 alpha:.7];
    [self.view addSubview:spiderView];
    
}

@end

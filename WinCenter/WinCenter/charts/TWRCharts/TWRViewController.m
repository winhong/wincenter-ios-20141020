//
//  TWRViewController.m
//  ChartJS
//
//  Created by Michelangelo Chasseur on 21/04/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import "TWRViewController.h"
#import "TWRChart.h"

@interface TWRViewController ()

@property TWRChartView *lineChart;
@property TWRChartView *barChart;
@property TWRChartView *pieChart;
@property (weak, nonatomic) IBOutlet UIView *lineContainer;
@property (weak, nonatomic) IBOutlet UIView *barContainer;
@property (weak, nonatomic) IBOutlet UIView *pieContainer;

@end

@implementation TWRViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.lineChart = [[TWRChartView alloc] initWithFrame:self.lineContainer.bounds];
    self.lineChart.backgroundColor = [UIColor clearColor];
    [self.lineContainer addSubview:self.lineChart];
    [self.lineContainer setUserInteractionEnabled:false];
    
    self.barChart = [[TWRChartView alloc] initWithFrame:self.barContainer.bounds];
    self.barChart.backgroundColor = [UIColor clearColor];
    [self.barContainer addSubview:self.barChart];
    [self.barContainer setUserInteractionEnabled:false];
    
    self.pieChart = [[TWRChartView alloc] initWithFrame:self.pieContainer.bounds];
    self.pieChart.backgroundColor = [UIColor clearColor];
    [self.pieContainer addSubview:self.pieChart];
    [self.pieContainer setUserInteractionEnabled:false];
    
    [self refresh:nil];
}
- (IBAction)refresh:(id)sender {
    [self loadLineChart];
    [self loadBarChart];
    [self loadPieChart];
}

/**
*  Loads a bar chart using native code
*/
- (void)loadBarChart {
    // Build chart data
    TWRDataSet *dataSet1 = [[TWRDataSet alloc] initWithDataPoints:@[@10, @15, @5, @15, @5]
                                                        fillColor:[[UIColor orangeColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor orangeColor]];

    TWRDataSet *dataSet2 = [[TWRDataSet alloc] initWithDataPoints:@[@5, @10, @5, @15, @10]
                                                        fillColor:[[UIColor redColor] colorWithAlphaComponent:0.5]
                                                      strokeColor:[UIColor redColor]];

    NSArray *labels = @[@"A", @"B", @"C", @"D", @"E"];
    TWRBarChart *bar = [[TWRBarChart alloc] initWithLabels:labels
                                                  dataSets:@[dataSet1, dataSet2]
                                                  animated:YES];
    // Load data
    [self.barChart loadBarChart:bar];
}

/**
*  Loads a line chart using native code
*/
- (void)loadLineChart {
    // Build chart data
    TWRDataSet *dataSet1 = [[TWRDataSet alloc] initWithDataPoints:@[@10, @15, @5, @15, @5]];
    TWRDataSet *dataSet2 = [[TWRDataSet alloc] initWithDataPoints:@[@5, @10, @5, @15, @10]];

    NSArray *labels = @[@"A", @"B", @"C", @"D", @"E"];

    TWRLineChart *line = [[TWRLineChart alloc] initWithLabels:labels
                                                     dataSets:@[dataSet1, dataSet2]
                                                     animated:YES];
    // Load data
    [self.lineChart  loadLineChart:line];
}

/**
*  Loads a pie / doughnut chart using native code
*/
- (void)loadPieChart {
    // Values
    NSArray *values = @[@20, @30, @15, @5];

    // Colors
    UIColor *color1 = [UIColor colorWithHue:0.5 saturation:0.6 brightness:0.6 alpha:1.0];
    UIColor *color2 = [UIColor colorWithHue:0.6 saturation:0.6 brightness:0.6 alpha:1.0];
    UIColor *color3 = [UIColor colorWithHue:0.7 saturation:0.6 brightness:0.6 alpha:1.0];
    UIColor *color4 = [UIColor colorWithHue:0.8 saturation:0.6 brightness:0.6 alpha:1.0];
    NSArray *colors = @[color1, color2, color3, color4];

    // Doughnut Chart
    TWRCircularChart *pieChart = [[TWRCircularChart alloc] initWithValues:values
                                                                   colors:colors
                                                                     type:TWRCircularChartTypeDoughnut
                                                                 animated:YES];

    // You can even leverage callbacks when chart animation ends!
    [self.pieChart  loadCircularChart:pieChart withCompletionHandler:^(BOOL finished) {
        if (finished) {
            NSLog(@"Animation finished!!!");
        }
    }];
}

@end

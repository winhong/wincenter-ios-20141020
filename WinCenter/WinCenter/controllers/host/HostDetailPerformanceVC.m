//
//  HostDetailPerformanceVC.m
//  wincenterDemo01
//
//  Created by huadi on 14-8-15.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "HostDetailPerformanceVC.h"

@interface HostDetailPerformanceVC ()
@property (weak, nonatomic) IBOutlet UIView *cpuPNChartArea;
@property (weak, nonatomic) IBOutlet UIView *memoryPNChartArea;
@property (weak, nonatomic) IBOutlet UIView *netPNChartArea;

@end

@implementation HostDetailPerformanceVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(20, 50, 1123, 130.0)];
    [lineChart setBackgroundColor:[UIColor clearColor]];
    [lineChart setXLabels:@[@"07-18 16:18",@"07-18 16:18",@"07-18 16:18",@"07-18 16:18",@"07-18 16:18"]];
    
    // Line Chart No.1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    
    lineChart.chartData = @[data01, data02];
    [lineChart strokeChart];
    [self.cpuPNChartArea addSubview:lineChart];
    
    PNLineChart * lineChart2 = [[PNLineChart alloc] initWithFrame:CGRectMake(20, 50, 1123, 130.0)];
    [lineChart2 setBackgroundColor:[UIColor clearColor]];
    [lineChart2 setXLabels:@[@"07-18 16:18",@"07-18 16:18",@"07-18 16:18",@"07-18 16:18",@"07-18 16:18"]];
    
    // Line Chart No.1
    NSArray * data03Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data03 = [PNLineChartData new];
    data03.color = PNFreshGreen;
    data03.itemCount = lineChart2.xLabels.count;
    data03.getData = ^(NSUInteger index) {
        CGFloat yValue = [data03Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data04Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data04 = [PNLineChartData new];
    data04.color = PNTwitterColor;
    data04.itemCount = lineChart2.xLabels.count;
    data04.getData = ^(NSUInteger index) {
        CGFloat yValue = [data04Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    
    lineChart2.chartData = @[data03, data04];
    [lineChart2 strokeChart];
    [self.memoryPNChartArea addSubview:lineChart2];
    
    PNLineChart * lineChart3 = [[PNLineChart alloc] initWithFrame:CGRectMake(20, 50, 1123, 130.0)];
    [lineChart3 setBackgroundColor:[UIColor clearColor]];
    [lineChart3 setXLabels:@[@"07-18 16:18",@"07-18 16:18",@"07-18 16:18",@"07-18 16:18",@"07-18 16:18"]];
    
    // Line Chart No.1
    NSArray * data05Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data05 = [PNLineChartData new];
    data05.color = PNFreshGreen;
    data05.itemCount = lineChart3.xLabels.count;
    data05.getData = ^(NSUInteger index) {
        CGFloat yValue = [data05Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data06Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data06 = [PNLineChartData new];
    data06.color = PNTwitterColor;
    data06.itemCount = lineChart3.xLabels.count;
    data06.getData = ^(NSUInteger index) {
        CGFloat yValue = [data06Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    
    lineChart3.chartData = @[data05, data06];
    [lineChart3 strokeChart];
    [self.netPNChartArea addSubview:lineChart3];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

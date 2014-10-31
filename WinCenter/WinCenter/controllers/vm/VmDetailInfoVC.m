//
//  VmDetailShowVC.m
//  wincenterDemo01
//
//  Created by huadi on 14-8-21.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmDetailInfoVC.h"
#import <NZAlertView/NZAlertView.h>

@interface VmDetailInfoVC ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *osType;
@property (weak, nonatomic) IBOutlet UILabel *isInstalledTool;
@property (weak, nonatomic) IBOutlet UILabel *runningTime;
@property (weak, nonatomic) IBOutlet UILabel *vcpu;
@property (weak, nonatomic) IBOutlet UILabel *memoryType;
@property (weak, nonatomic) IBOutlet UIImageView *isDynamicMemWce;
@property (weak, nonatomic) IBOutlet UILabel *memory;
@property (weak, nonatomic) IBOutlet UILabel *snopshotNum;
@property (weak, nonatomic) IBOutlet UIImageView *osType_image;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *vmIp;
@property (weak, nonatomic) IBOutlet UIImageView *noDynamicCpu_img;
@property (weak, nonatomic) IBOutlet UIImageView *isDynamicCpu_img;
@property (weak, nonatomic) IBOutlet UIImageView *isDynamicMemWce_img;
@property (weak, nonatomic) IBOutlet UIImageView *noDynamicMemWce_img;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *cpuPNChartArea;
@property (weak, nonatomic) IBOutlet UIView *memoryPNChartArea;
@property (weak, nonatomic) IBOutlet UIView *netPNChartArea;
@property (weak, nonatomic) IBOutlet UIView *storagePNChartArea;

@end

@implementation VmDetailInfoVC

- (void)viewDidLayoutSubviews{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if(self.scrollView){
            self.scrollView.frame = [[UIScreen mainScreen] bounds];
            self.scrollView.contentSize = CGSizeMake(320, 1000);
        }
    }
}

- (IBAction)testAction:(id)sender {
    // There are several ways to init, just look at the class header
    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleSuccess
                                                      title:@"Alert View"
                                                    message:@"This is an alert example."
                                                   delegate:nil];
    
    [alert setTextAlignment:NSTextAlignmentCenter];
    
    [alert show];
    
    // or
    
    [alert showWithCompletion:^{
        NSLog(@"Alert with completion handler");
    }];
}

- (void)viewDidLoad
{
    for(UILabel *label in self.allLabels){
        label.text = @"";
    }
    
    self.view.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
    
    for(UIView *subView in self.cpuPNChartArea.subviews){
        [subView removeFromSuperview];
    }
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(20, 40, 680, 110.0)];
    [lineChart setBackgroundColor:[UIColor clearColor]];
    [lineChart setXLabels:@[@"07-18 16:18",@"07-18 16:18",@"07-18 16:18",@"07-18 16:18",@"07-18 16:18"]];
    
    // Line Chart No.1F
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
    
    
    for(UIView *subView in self.memoryPNChartArea.subviews){
        [subView removeFromSuperview];
    }
    PNLineChart * lineChart2 = [[PNLineChart alloc] initWithFrame:CGRectMake(20, 40, 680, 110.0)];
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
    
    
    for(UIView *subView in self.netPNChartArea.subviews){
        [subView removeFromSuperview];
    }
    PNLineChart * lineChart3 = [[PNLineChart alloc] initWithFrame:CGRectMake(20, 40, 680, 110.0)];
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
    
    
    for(UIView *subView in self.storagePNChartArea.subviews){
        [subView removeFromSuperview];
    }
    PNLineChart * lineChart4 = [[PNLineChart alloc] initWithFrame:CGRectMake(20, 40, 680, 110.0)];
    [lineChart4 setBackgroundColor:[UIColor clearColor]];
    [lineChart4 setXLabels:@[@"07-18 16:18",@"07-18 16:18",@"07-18 16:18",@"07-18 16:18",@"07-18 16:18"]];
    
    // Line Chart No.1
    NSArray * data07Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data07 = [PNLineChartData new];
    data07.color = PNFreshGreen;
    data07.itemCount = lineChart4.xLabels.count;
    data07.getData = ^(NSUInteger index) {
        CGFloat yValue = [data07Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data08Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data08 = [PNLineChartData new];
    data08.color = PNTwitterColor;
    data08.itemCount = lineChart4.xLabels.count;
    data08.getData = ^(NSUInteger index) {
        CGFloat yValue = [data08Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    
    lineChart4.chartData = @[data07, data08];
    [lineChart4 strokeChart];
    [self.storagePNChartArea addSubview:lineChart4];
    
    [self reloadData];
}

-(void)reloadData{
    [self.vmVO getVmVOAsync:^(id object, NSError *error) {
        self.vmVO = object;
        [self refresh];
    }];
}
- (void)refresh{
    self.vmIp.text = self.vmVO.ip;
    if(self.vmVO.ip == nil){
        self.vmIp.text = @"(尚未配置ip)";
    }
    self.name.text = self.vmVO.name;
    self.status.text = [self.vmVO state_text];
    self.status.textColor = [self.vmVO state_color];
    self.osType.text = self.vmVO.osType;
    if(self.vmVO.osType == nil){
        self.osType.text = @"(尚未安装)";
    }
    self.isInstalledTool.text = [self.vmVO isInstallTools_text];
    self.runningTime.text = [NSString stringWithFormat:@"%d", self.vmVO.runTime];
    self.vcpu.text = [NSString stringWithFormat:@"%d", self.vmVO.vcpu];
    //self.isDynamicCPU
    self.memoryType.text = [self.vmVO memoryType_text];
    //self.isDynamicMemWce
    self.memory.text = [NSString stringWithFormat:@"%d", self.vmVO.memory];
    //self.snopshotNum.text
    self.osType_image.image = [UIImage imageNamed:[self.vmVO osType_imageName_big]];
    if(self.isDynamicCpu_img){
        self.isDynamicCpu_img.hidden = ![self.vmVO isDynamicCpu_img];
    }
    if(self.noDynamicCpu_img){
        self.noDynamicCpu_img.hidden = [self.vmVO isDynamicCpu_img];
    }
    if(self.isDynamicMemWce_img){
        self.isDynamicMemWce_img.hidden = ![self.vmVO isDynamicMemWce_img];
    }
    if(self.noDynamicMemWce_img){
        self.noDynamicMemWce_img.hidden = [self.vmVO isDynamicMemWce_img];
    }
}

@end

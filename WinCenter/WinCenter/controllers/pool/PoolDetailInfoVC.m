//
//  PoolDetailBaseinfoVC.m
//  wincenterDemo01
//
//  Created by huadi on 14-8-21.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "PoolDetailInfoVC.h"
#import "PoolVO.h"


@interface PoolDetailInfoVC ()

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *hostCount;
@property (weak, nonatomic) IBOutlet UILabel *vmCount;
@property (weak, nonatomic) IBOutlet UILabel *cpuUnitCount;
@property (weak, nonatomic) IBOutlet UILabel *cpuUnitUsedCount;
@property (weak, nonatomic) IBOutlet UILabel *cpuUnitUnusedCount;
@property (weak, nonatomic) IBOutlet UILabel *cpuRatio;

@property (weak, nonatomic) IBOutlet UILabel *memorySize;
@property (weak, nonatomic) IBOutlet UILabel *memoryUsedSize;
@property (weak, nonatomic) IBOutlet UILabel *memoryUnusedSize;
@property (weak, nonatomic) IBOutlet UILabel *memoryRatio;

@property (weak, nonatomic) IBOutlet UILabel *storageSize;
@property (weak, nonatomic) IBOutlet UILabel *storageUsedSize;
@property (weak, nonatomic) IBOutlet UILabel *storageUnusedSize;
@property (weak, nonatomic) IBOutlet UILabel *storageRatio;

@property (weak, nonatomic) IBOutlet UILabel *haErrorHostCount;
@property (weak, nonatomic) IBOutlet UILabel *haSignalPool;

@property (weak, nonatomic) IBOutlet UILabel *elasticModel;
@property (weak, nonatomic) IBOutlet UILabel *cpuLoadBalancing;
@property (weak, nonatomic) IBOutlet UILabel *memeryLoadBalancing;
@property (weak, nonatomic) IBOutlet UILabel *intervalTime;
@property (weak, nonatomic) IBOutlet UILabel *nextCheckTime;
@property (weak, nonatomic) IBOutlet UIView *cpuChartGroup;
@property (weak, nonatomic) IBOutlet UIImageView *cpuChart;
@property (weak, nonatomic) IBOutlet UIView *memoryChartGroup;
@property (weak, nonatomic) IBOutlet UIImageView *memeryChart;
@property (weak, nonatomic) IBOutlet UIView *storageChartGroup;
@property (weak, nonatomic) IBOutlet UIImageView *storageChart;
@property (weak, nonatomic) IBOutlet UILabel *vType;
@property (weak, nonatomic) IBOutlet UILabel *vVersion;
@property (weak, nonatomic) IBOutlet UILabel *vDate;
@property (weak, nonatomic) IBOutlet UIView *haInfo;

@property (weak, nonatomic) IBOutlet UIView *elastic_Info;
@property (weak, nonatomic) IBOutlet UILabel *haDisable;

@property (weak, nonatomic) IBOutlet UILabel *elasticDisable;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation PoolDetailInfoVC

- (void)viewDidLayoutSubviews{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if(self.scrollView){
            self.scrollView.frame = [[UIScreen mainScreen] bounds];
            self.scrollView.contentSize = CGSizeMake(320, 1500);
        }
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.circleChart strokeChart];
    [self.circleChart2 strokeChart];
    [self.circleChart3 strokeChart];
}

- (void)viewDidLoad
{
    for(UILabel *label in self.allLabels){
        label.text = @"";
    }

    self.view.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
    [self.scrollView addHeaderWithCallback:^{
        [self reloadData];
    }];
    // Do any additional setup after loading the view.
    [self reloadData];
}

- (IBAction)refreshAction:(id)sender {
    [self.scrollView headerBeginRefreshing];
}

-(void)reloadData{
    
    [self.poolVO getPoolElasticAsync:^(id object, NSError *error) {
        self.elasticInfo = object;
        [self.poolVO getPoolVOAsync:^(id object, NSError *error) {
            self.poolVO = object;
            [self.poolVO getHaMaxHostFailuresAsync:^(id object, NSError *error) {
                self.maxHostFailures = object;
                [self.poolVO getHaInfoAsync:^(id object, NSError *error) {
                    self.haInfoVO = object;
                    [self refreshMainInfo];
                    [self refreshElasticInfo];
                    [self.scrollView headerEndRefreshing];
                }];
            }];
        }];
        
    }];
}

- (void)refreshMainInfo{
    self.name.text = [NSString stringWithFormat:@"%@", self.poolVO.resourcePoolName];
    self.hostCount.text = [NSString stringWithFormat:@"%d", self.poolVO.hostNumber];
    self.vmCount.text = [NSString stringWithFormat:@"%d", self.poolVO.vmNumber];
    self.vType.text = self.poolVO.hypervisor;
    self.vVersion.text = self.poolVO.productVersion;
    self.vDate.text = [self.poolVO versionDate_text];
    

    self.cpuUnitCount.text = [NSString stringWithFormat:@"%.2f%@", [self.poolVO totalCpu_value],[self.poolVO totalCpu_unit]];
    self.cpuUnitUsedCount.text = [NSString stringWithFormat:@"%.2f%@", [self.poolVO usedCpu_value],[self.poolVO usedCpu_unit]];
    self.cpuUnitUnusedCount.text = [NSString stringWithFormat:@"%.2f%@", [self.poolVO availCpu_value],[self.poolVO availCpu_unit]];
    self.cpuRatio.text = [NSString stringWithFormat:@"%.0f%%", [self.poolVO cpuRatio]];
    
    self.memorySize.text = [NSString stringWithFormat:@"%.2fGB", self.poolVO.totalMemory/1024.0];
    self.memoryUsedSize.text = [NSString stringWithFormat:@"%.2fGB", (self.poolVO.totalMemory-self.poolVO.availMemory)/1024.0];
    self.memoryUnusedSize.text = [NSString stringWithFormat:@"%.2fGB", self.poolVO.availMemory/1024.0];
    self.memoryRatio.text = [NSString stringWithFormat:@"%.0f%%", (self.poolVO.totalMemory-self.poolVO.availMemory)/self.poolVO.totalMemory*100];
    
    self.storageSize.text = [NSString stringWithFormat:@"%.2f%@", [self.poolVO totalStorage_value],[self.poolVO totalStorage_unit]];
    self.storageUsedSize.text = [NSString stringWithFormat:@"%.2f%@", [self.poolVO usedStorage_value],[self.poolVO usedStorage_unit]];
    self.storageUnusedSize.text = [NSString stringWithFormat:@"%.2f%@", [self.poolVO availStorage_value],[self.poolVO availStorage_unit]];
    self.storageRatio.text = [NSString stringWithFormat:@"%.0f%%", (self.poolVO.totalStorage-self.poolVO.availStorage)/self.poolVO.totalStorage*100];
    
    if ([self.haInfoVO.haEnabled isEqualToString:@"true"]) {
        self.haInfo.hidden = NO;
        self.haErrorHostCount.text = [NSString stringWithFormat:@"%d",self.maxHostFailures.maxHostFailures];
        self.haSignalPool.text = self.haInfoVO.haStorageOriginalId == nil ? @"无" :self.haInfoVO.haStorageOriginalId;
    }else{
        self.haDisable.hidden = NO;
        self.haInfo.hidden = YES;
    }
    
    
    //圈图
    for(UIView *subView in self.cpuChartGroup.subviews){
        [subView removeFromSuperview];
    }
    self.circleChart = [[PNCircleChart alloc] initWithFrame:self.cpuChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:[self.poolVO cpuRatio]] andClockwise:YES andShadow:YES];
    self.circleChart.backgroundColor = [UIColor clearColor];
    self.circleChart.strokeColor = [UIColor clearColor];
    self.circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;
    self.circleChart.circle.lineCap = kCALineCapSquare;
    self.circleChart.lineWidth = @11.0f;
    [self.circleChart setStrokeColor:[UIColor colorWithRed:89.0/255 green:203.0/255 blue:92/255 alpha:1]];
    [self.circleChart strokeChart];
    [self.cpuChartGroup addSubview:self.circleChart];
    
    
    for(UIView *subView in self.memoryChartGroup.subviews){
        [subView removeFromSuperview];
    }
    self.circleChart2 = [[PNCircleChart alloc] initWithFrame:self.memoryChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:[self.poolVO memoryRatio]] andClockwise:YES andShadow:YES];
    self.circleChart2.backgroundColor = [UIColor clearColor];
    self.circleChart2.strokeColor = [UIColor clearColor];
    self.circleChart2.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;
    self.circleChart2.circle.lineCap = kCALineCapSquare;
    self.circleChart2.lineWidth = @11.0f;
    [self.circleChart2 setStrokeColor:[UIColor colorWithRed:89.0/255 green:203.0/255 blue:92/255 alpha:1]];
    [self.circleChart2 strokeChart];
    [self.memoryChartGroup addSubview:self.circleChart2];
    
    for(UIView *subView in self.storageChartGroup.subviews){
        [subView removeFromSuperview];
    }
    self.circleChart3 = [[PNCircleChart alloc] initWithFrame:self.storageChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:[self.poolVO storageRatio]] andClockwise:YES andShadow:YES];
    self.circleChart3.backgroundColor = [UIColor clearColor];
    self.circleChart3.strokeColor = [UIColor clearColor];
    self.circleChart3.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    self.circleChart3.circle.lineCap = kCALineCapSquare;//直角填充
    self.circleChart3.lineWidth = @11.0f;//线宽度
    [self.circleChart3 setStrokeColor:[UIColor colorWithRed:89.0/255 green:203.0/255 blue:92/255 alpha:1]];//已使用填充颜色
    [self.circleChart3 strokeChart];
    [self.storageChartGroup addSubview:self.circleChart3];
    
}
- (void)refreshElasticInfo{
    if (!(self.elasticInfo.balancingMode)) {
        self.elastic_Info.hidden = YES;
        self.elasticDisable.hidden = NO;
    }else{
        self.elasticDisable.hidden = YES;
        self.elastic_Info.hidden = NO;
        self.elasticModel.text = [self.elasticInfo balancingModeStr];
        self.cpuLoadBalancing.text = [NSString stringWithFormat:@"%.0f%%", self.elasticInfo.cpuThreshold*100];
        self.memeryLoadBalancing.text = [NSString stringWithFormat:@"%.0f%%", self.elasticInfo.memThreshold*100];
        self.intervalTime.text = [self.elasticInfo intervalTime_text];
        self.nextCheckTime.text = [self.elasticInfo.nextStartTime stringByReplacingOccurrencesOfString:@" 000" withString:@""];
    }

}

@end

//
//  HostDetailBaseinfoVC.m
//  wincenterDemo01
//
//  Created by huadi on 14-8-15.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "HostDetailInfoVC.h"
#import "HostVmMemoryTop5CollectionVC.h"

@interface HostDetailInfoVC ()
@property (weak, nonatomic) IBOutlet UILabel *virtualMachineNum;
@property (weak, nonatomic) IBOutlet UILabel *networkNum;
@property (weak, nonatomic) IBOutlet UILabel *startRunTime;
@property (weak, nonatomic) IBOutlet UILabel *virtualInfo;
@property (weak, nonatomic) IBOutlet UILabel *virtualDate;
@property (weak, nonatomic) IBOutlet UILabel *cpuSpeed;
@property (weak, nonatomic) IBOutlet UILabel *model;
@property (weak, nonatomic) IBOutlet UILabel *vendor;
@property (weak, nonatomic) IBOutlet UILabel *cpuSlots;
@property (weak, nonatomic) IBOutlet UILabel *cpu;
@property (weak, nonatomic) IBOutlet UILabel *activeMachineNum;
@property (weak, nonatomic) IBOutlet UILabel *top5MemorySize;
@property (weak, nonatomic) IBOutlet UILabel *top5UnUsedMemory;
@property (weak, nonatomic) IBOutlet UIProgressView *memoryTopProgressbar;

@property (weak, nonatomic) IBOutlet UILabel *cpuUnitCount;
@property (weak, nonatomic) IBOutlet UILabel *cpuUnitUsedCount;
@property (weak, nonatomic) IBOutlet UILabel *cpuUnitUnusedCount;
@property (weak, nonatomic) IBOutlet UILabel *cpuRatio;
@property (weak, nonatomic) IBOutlet UIView *cpuChartGroup;


@property (weak, nonatomic) IBOutlet UILabel *memorySize;
@property (weak, nonatomic) IBOutlet UILabel *memoryUsedSize;
@property (weak, nonatomic) IBOutlet UILabel *memoryUnusedSize;
@property (weak, nonatomic) IBOutlet UILabel *memoryRatio;
@property (weak, nonatomic) IBOutlet UIView *memoryChartGroup;

@property (weak, nonatomic) IBOutlet UILabel *storageSize;
@property (weak, nonatomic) IBOutlet UILabel *storageUsedSize;
@property (weak, nonatomic) IBOutlet UILabel *storageUnusedSize;
@property (weak, nonatomic) IBOutlet UILabel *storageRatio;
@property (weak, nonatomic) IBOutlet UIView *storageChartGroup;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIImageView *osType;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property HostVmMemoryTop5CollectionVC *top5VC;
@end

@implementation HostDetailInfoVC

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"toTop5CollectionView"]){
        self.top5VC = segue.destinationViewController;
        self.top5VC.hostVO = self.hostVO;
    }
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor clearColor];
    for(UILabel *label in self.allLabels){
        label.text = @"";
    }
    [super viewDidLoad];
    [self.scrollView addHeaderWithCallback:^{
        [self reloadData];
    }];
    [self reloadData];
    self.network_count =0;
}

- (IBAction)refreshAction:(id)sender {
    [self.scrollView headerBeginRefreshing];
}

- (void)reloadData{
    [self.hostVO getHostVOAsync:^(id object, NSError *error) {
        self.hostVO = object;
        [self.hostVO getActivityVmAsync:^(id object, NSError *error) {
            self.activityVm = object;
            [self.hostVO getHostNetworkListAllAsync:^(id object, NSError *error) {
                self.hostNetworkList = object;
                self.network_count = 0;
                for (HostNetworkVO *hostNetworkVO in self.hostNetworkList.networks) {
                    if ([hostNetworkVO.type isEqualToString:@"EXTERNAL"] || [hostNetworkVO.type isEqualToString:@"INTERNAL"]) {
                        self.network_count += 1;
                    }
                }
                [self refreshMainInfo];
                if(![self.hostVO.state isEqualToString:@"DISCONNECT"]){
                    [self.hostVO getHostStatVOAsync:^(id object, NSError *error) {
                            self.statVO = object;
                            [self refreshStatInfo];
                            [self.scrollView headerEndRefreshing];
                            self.parentViewController.parentViewController.navigationItem.rightBarButtonItem.enabled = true;
                        }];
   
                }else{
                    self.statVO = [HostStatVO new];
                    [self refreshStatInfo];
                    [self.scrollView headerEndRefreshing];
                    self.parentViewController.parentViewController.navigationItem.rightBarButtonItem.enabled = true;
                }
            }];
            
        }];
    }];
}

- (void)refreshMainInfo{
    self.name.text = [NSString stringWithFormat:@"%@", self.hostVO.hostName];
    self.virtualMachineNum.text = [NSString stringWithFormat:@"%d", self.hostVO.virtualMachineNum];
    self.activeMachineNum.text = [NSString stringWithFormat:@"%d", self.activityVm.OK];
    self.networkNum.text = [NSString stringWithFormat:@"%d", self.network_count];
    self.startRunTime.text = [NSString stringWithFormat:@"%d", self.hostVO.startRunTime];
    self.virtualInfo.text = [NSString stringWithFormat:@"%@ %@", self.hostVO.virtualSoftware, self.hostVO.virtualVersion];
    self.virtualDate.text = [NSString stringWithFormat:@"%@", self.hostVO.versionDate];
    self.cpuSpeed.text = [NSString stringWithFormat:@"%dMHz", self.hostVO.cpuSpeed];
    self.model.text = [NSString stringWithFormat:@"%@", [self.hostVO.model stringByReplacingOccurrencesOfString:@"    " withString:@""]];
    self.vendor.text = [NSString stringWithFormat:@"%@", self.hostVO.vendor];
    self.cpuSlots.text = [NSString stringWithFormat:@"%d颗", self.hostVO.cpuSlots];
    self.cpu.text = [NSString stringWithFormat:@"%d个", self.hostVO.cpu];
    
}
- (void)refreshStatInfo{

    self.cpuUnitCount.text = [NSString stringWithFormat:@"%.2f%@", [self.statVO totalCpu_value],[self.statVO totalCpu_unit]];
    self.cpuUnitUsedCount.text = [NSString stringWithFormat:@"%.2f%@", [self.statVO usedCpu_value],[self.statVO usedCpu_unit]];

    self.cpuUnitUnusedCount.text = [NSString stringWithFormat:@"%.2f%@", [self.statVO availCpu_value],[self.statVO availCpu_unit]];
    self.cpuRatio.text = [NSString stringWithFormat:@"%.0f%%", self.statVO.cpuUsedPer*100];
    
    self.memorySize.text = [NSString stringWithFormat:@"%.2fGB", self.statVO.totalMem/1024.0];
    self.memoryUsedSize.text = [NSString stringWithFormat:@"%.2fGB", (self.statVO.totalMem-self.statVO.freeMem)/1024.0];
    self.memoryUnusedSize.text = [NSString stringWithFormat:@"%.2fGB", self.statVO.freeMem/1024.0];
    self.memoryRatio.text = [NSString stringWithFormat:@"%.0f%%", (self.statVO.totalMem-self.statVO.freeMem)/self.statVO.totalMem*100];
    self.top5MemorySize.text = [NSString stringWithFormat:@"%.2fGB", self.statVO.totalMem/1024.0];
    self.top5UnUsedMemory.text = [NSString stringWithFormat:@"%.2fGB", self.statVO.freeMem/1024.0];
    self.memoryTopProgressbar.progress = (self.statVO.totalMem - self.statVO.freeMem)/self.statVO.totalMem;
    
    self.storageSize.text = [NSString stringWithFormat:@"%.2f%@", [self.statVO totalStorage_value],[self.statVO totalStorage_unit]];
    self.storageUsedSize.text = [NSString stringWithFormat:@"%.2f%@", [self.statVO usedStorage_value],[self.statVO usedStorage_unit]];
    self.storageUnusedSize.text = [NSString stringWithFormat:@"%.2f%@", [self.statVO availStorage_value],[self.statVO availStorage_unit]];
    self.storageRatio.text = [NSString stringWithFormat:@"%.0f%%", self.statVO.usedStorage/self.statVO.totalStorage*100];
    
    //圈图
    for(UIView *subView in self.cpuChartGroup.subviews){
        [subView removeFromSuperview];
    }
    self.circleChart = [[PNCircleChart alloc] initWithFrame:self.cpuChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:[self.statVO cpuRatio]] andClockwise:YES andShadow:YES];
    self.circleChart.backgroundColor = [UIColor clearColor];
    self.circleChart.strokeColor = [UIColor clearColor];
    if (self.statVO.cpuTotal == 0) {
        self.circleChart.circleBG.strokeColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1].CGColor;
    }else{
        self.circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    }
    self.circleChart.circle.lineCap = kCALineCapSquare;
    self.circleChart.lineWidth = @7.0f;
    [self.circleChart setStrokeColor:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1]];
    [self.circleChart strokeChart];
    [self.cpuChartGroup addSubview:self.circleChart];
    
    for(UIView *subView in self.memoryChartGroup.subviews){
        [subView removeFromSuperview];
    }
    self.circleChart2 = [[PNCircleChart alloc] initWithFrame:self.memoryChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:[self.statVO memoryRatio]] andClockwise:YES andShadow:YES];
    self.circleChart2.backgroundColor = [UIColor clearColor];
    self.circleChart2.strokeColor = [UIColor clearColor];
    if (self.statVO.totalMem == 0) {
        self.circleChart2.circleBG.strokeColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1].CGColor;
    }else{
        self.circleChart2.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    }
    self.circleChart2.circle.lineCap = kCALineCapSquare;
    self.circleChart2.lineWidth = @7.0f;
    [self.circleChart2 setStrokeColor:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1]];
    [self.circleChart2 strokeChart];
    [self.memoryChartGroup addSubview:self.circleChart2];
    
    for(UIView *subView in self.storageChartGroup.subviews){
        [subView removeFromSuperview];
    }
    self.circleChart3 = [[PNCircleChart alloc] initWithFrame:self.storageChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:[self.statVO storageRatio]] andClockwise:YES andShadow:YES];
    self.circleChart3.backgroundColor = [UIColor clearColor];
    self.circleChart3.strokeColor = [UIColor clearColor];
    if (self.statVO.totalStorage == 0) {
        self.circleChart3.circleBG.strokeColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1].CGColor;
    }else{
        self.circleChart3.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    }
    self.circleChart3.circle.lineCap = kCALineCapSquare;
    self.circleChart3.lineWidth = @7.0f;
    [self.circleChart3 setStrokeColor:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1]];
    [self.circleChart3 strokeChart];
    [self.storageChartGroup addSubview:self.circleChart3];

}


@end

//
//  DatacenterDetailInfoVC.m
//  wincenterDemo01
//
//  Created by apple on 14-9-1.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "DatacenterDetailInfoVC.h"
#import "MasterContainerVC.h"

@interface DatacenterDetailInfoVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *cpuChartGroup;
@property (weak, nonatomic) IBOutlet UIView *memoryChartGroup;
@property (weak, nonatomic) IBOutlet UIView *storageChartGroup;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;

@property DatacenterStatWinserver *datacenterStatWinserver;
@property UIPopoverController *popover;
@end

@implementation DatacenterDetailInfoVC

- (void)viewDidLayoutSubviews{
    if(self.scrollView){
        self.scrollView.contentSize = CGSizeMake(275, 420);
    }
}

//-(void)viewDidAppear:(BOOL)animated{
    //[super viewDidAppear:animated];
    
    //[self.circleChart strokeChart];
    //[self.circleChart2 strokeChart];
    //[self.circleChart3 strokeChart];
//}

- (void)viewDidLoad{
    for(UILabel *label in self.allLabels){
        label.text = @"";
    }
    [super viewDidLoad];
    [self refresh];
}

- (void)refresh{
    [self switchButtonSelected:0];
    
    [[RemoteObject getCurrentDatacenterVO] getDatacenterStatWinserverVOAsync:^(id object, NSError *error) {
        self.datacenterStatWinserver = object;
        [self refreshMainInfo];
        
        [[RemoteObject getCurrentDatacenterVO] getBusinessListAsync:^(NSArray *allRemote, NSError *error) {
            self.datacenterStatWinserver.appNumber = (int) allRemote.count;
            [self refreshMainInfo2];
        }];
        
        [[RemoteObject getCurrentDatacenterVO] getPoolListAsync:^(NSArray *allRemote, NSError *error) {
            for(PoolVO *poolVO in allRemote){
                [poolVO getPoolVOSync:^(id object, NSError *error) {
                    self.datacenterStatWinserver.totalCpu += ((PoolVO *)object).totalCpu;
                    self.datacenterStatWinserver.totalMemory += ((PoolVO *)object).totalMemory;
                    self.datacenterStatWinserver.totalStorage += ((PoolVO *)object).totalStorage;
                    self.datacenterStatWinserver.availCpu += ((PoolVO *)object).availCpu;
                    self.datacenterStatWinserver.availMemory += ((PoolVO *)object).availMemory;
                    self.datacenterStatWinserver.availStorage += ((PoolVO *)object).availStorage;
                    
                   
                }];
            }
            [self refreshMainInfo3];
        }];
    }];
}
- (void)refreshMainInfo2{
    self.businessCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.appNumber];

}
- (void)refreshMainInfo{
    self.poolCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.resPoolNumber];
    self.hostCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.hostNubmer];
    self.vmCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.vmNumber];
    self.dissociateHostNumber.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.dissociateHostNumber];
}

- (void)refreshMainInfo3{
    self.name.title = [RemoteObject getCurrentDatacenterVO].name;
    self.cpuUnitCount.text = [NSString stringWithFormat:@"%.2fGHz",self.datacenterStatWinserver.totalCpu/1000.0];
    self.cpuUnitCount2.text = [NSString stringWithFormat:@"%.2fGHz",self.datacenterStatWinserver.totalCpu/1000.0];
    self.cpuUsedCount.text = [NSString stringWithFormat:@"%.2fGHz",(self.datacenterStatWinserver.totalCpu-self.datacenterStatWinserver.availCpu)/1000.0];
    self.cpuUnitUnusedCount.text = [NSString stringWithFormat:@"%.2fGHz",self.datacenterStatWinserver.availCpu/1000.0];
    self.cpuUsedInfo.text = [NSString stringWithFormat:@"已用%.2fGHz  还剩%.2fGHz",(self.datacenterStatWinserver.totalCpu-self.datacenterStatWinserver.availCpu)/1000.0,self.datacenterStatWinserver.availCpu/1000.0];
    self.cpuProgress.progress = self.datacenterStatWinserver.cpuRatio/100.0;
    self.cpuProgress.tintColor = [self.datacenterStatWinserver cpuRatioColor];
    
    self.memerySize.text = [NSString stringWithFormat:@"%.2fG",self.datacenterStatWinserver.totalMemory/1024.0];
    self.memerySize2.text = [NSString stringWithFormat:@"%.2fG",self.datacenterStatWinserver.totalMemory/1024.0];
    self.memeryUsedSize.text = [NSString stringWithFormat:@"%.2fG",(self.datacenterStatWinserver.totalMemory-self.datacenterStatWinserver.availMemory)/1024.0];
    self.memoryUnusedSize.text = [NSString stringWithFormat:@"%.2fG",self.datacenterStatWinserver.availMemory/1024.0];
    self.memeryUsedInfo.text = [NSString stringWithFormat:@"已用%.2fG  还剩%.2fG",(self.datacenterStatWinserver.totalMemory-self.datacenterStatWinserver.availMemory)/1024.0,self.datacenterStatWinserver.availMemory/1024.0];
    self.memoryProgress.progress = self.datacenterStatWinserver.memoryRatio/100.0;
    self.memoryProgress.tintColor = [self.datacenterStatWinserver memoryRatioColor];
    
    self.storageSize.text = [NSString stringWithFormat:@"%.2fT",self.datacenterStatWinserver.totalStorage/1024.0];
    self.storageSize2.text = [NSString stringWithFormat:@"%.2fT",self.datacenterStatWinserver.totalStorage/1024.0];
    self.storageUsedSize.text = [NSString stringWithFormat:@"%.2fT",(self.datacenterStatWinserver.totalStorage-self.datacenterStatWinserver.availStorage)/1024.0];
    self.storageUnusedSize.text = [NSString stringWithFormat:@"%.2fT",self.datacenterStatWinserver.availStorage/1024.0];
    self.storageUsedInfo.text = [NSString stringWithFormat:@"已用%.2fT  还剩%.2fT",(self.datacenterStatWinserver.totalStorage-self.datacenterStatWinserver.availStorage)/1024.0,self.datacenterStatWinserver.availStorage/1024.0];
    self.storageProgress.progress = self.datacenterStatWinserver.storageRatio/100.0;
    self.storageProgress.tintColor = [self.datacenterStatWinserver storageRatioColor];
    
    //圈图
    self.circleChart = [[PNCircleChart alloc] initWithFrame:self.cpuChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:[self.datacenterStatWinserver cpuRatio]] andClockwise:YES andShadow:YES];
    self.circleChart.backgroundColor = [UIColor clearColor];
    self.circleChart.strokeColor = [UIColor clearColor];
    //self.circleChart.countingLabel.hidden = YES;
    self.circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    self.circleChart.circle.lineCap = kCALineCapSquare;//直角填充
    self.circleChart.lineWidth = @11.0f;//线宽度
    [self.circleChart setStrokeColor:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1]];//已使用填充颜色
    [self.circleChart strokeChart];
    [self.cpuChartGroup addSubview:self.circleChart];
    
    
    self.circleChart2 = [[PNCircleChart alloc] initWithFrame:self.memoryChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:[self.datacenterStatWinserver memoryRatio]] andClockwise:YES andShadow:YES];
    self.circleChart2.backgroundColor = [UIColor clearColor];
    self.circleChart2.strokeColor = [UIColor clearColor];
    self.circleChart2.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    self.circleChart2.circle.lineCap = kCALineCapSquare;//直角填充
    self.circleChart2.lineWidth = @11.0f;//线宽度
    [self.circleChart2 setStrokeColor:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1]];//已使用填充颜色
//    [circleChart2 setStrokeColor:[self.datacenterStatWinserver memoryRatioColor]];
    [self.circleChart2 strokeChart];
    [self.memoryChartGroup addSubview:self.circleChart2];
    
    self.circleChart3 = [[PNCircleChart alloc] initWithFrame:self.storageChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:[self.datacenterStatWinserver storageRatio]] andClockwise:YES andShadow:YES];
    self.circleChart3.backgroundColor = [UIColor clearColor];
    self.circleChart3.strokeColor = [UIColor clearColor];
    self.circleChart3.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    self.circleChart3.circle.lineCap = kCALineCapSquare;//直角填充
    self.circleChart3.lineWidth = @11.0f;//线宽度
    [self.circleChart3 setStrokeColor:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1]];//已使用填充颜色
//    [circleChart3 setStrokeColor:[self.datacenterStatWinserver storageRatioColor]];
    [self.circleChart3 strokeChart];
    [self.storageChartGroup addSubview:self.circleChart3];
    
    
}

- (IBAction)switchPageVC:(id)sender {
    [self switchButtonSelected:((UIView*)sender).tag];
    
    [((MasterContainerVC *)self.parentViewController) switchPageVC:((UIView*)sender).tag];
    
}
- (void)switchButtonSelected:(NSInteger)index{
    self.button1.selected = NO;
    self.button2.selected = NO;
    self.button3.selected = NO;
    self.button4.selected = NO;
    self.button5.selected = NO;
    self.button6.selected = NO;
    
    switch(index){
        case 0: self.button1.selected = YES; break;
        case 1: self.button2.selected = YES; break;
        case 2: self.button3.selected = YES; break;
        case 3: self.button4.selected = YES; break;
        case 4: self.button5.selected = YES; break;
        case 5: self.button6.selected = YES; break;
    }
}

-(IBAction)showWarningInfoVC:(id)sender{
    if(self.popover!=nil){
        [self.popover dismissPopoverAnimated:NO];
    }
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Warning" bundle:nil] instantiateInitialViewController];
    self.popover = [[UIPopoverController alloc] initWithContentViewController:vc];
    UIBarButtonItem *button = (UIBarButtonItem*)sender;
    [self.popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

-(IBAction)showControlRecordVC:(id)sender{
    if(self.popover!=nil){
        [self.popover dismissPopoverAnimated:NO];
    }
    UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
    self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    UIBarButtonItem *button = (UIBarButtonItem*)sender;
    [self.popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

@end

//
//  DatacenterDetailInfoVC.m
//  wincenterDemo01
//
//  Created by apple on 14-9-1.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "DatacenterDetailInfoVC.h"
#import "MasterContainerVC.h"
#import "DashboardVC.h"
#import "RootVC.h"

@interface DatacenterDetailInfoVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;

@property (weak, nonatomic) IBOutlet UIView *cpuChartGroup;
@property (weak, nonatomic) IBOutlet UIView *memoryChartGroup;
@property (weak, nonatomic) IBOutlet UIView *storageChartGroup;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;

@property DatacenterStatWinserver *datacenterStatWinserver;
@property UIPopoverController *popover;
@end

@implementation DatacenterDetailInfoVC

- (IBAction)showMenu:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width,1000);
        self.topScrollView.contentSize = CGSizeMake(1750, self.topScrollView.frame.size.height);
        self.bottomScrollView.contentSize = CGSizeMake(1750, self.bottomScrollView.frame.size.height);
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
    
    self.gotoDashboardBusiness.enabled = false;
    self.gotoDashboardHost.enabled = false;
    self.gotoDashboardHostOther.enabled = false;
    self.gotoDashboardPool.enabled = false;
    self.gotoDashboardStorage.enabled = false;
    self.gotoDashboardVM.enabled = false;
    
    [UserVO getUserVOAsync:^(id object, NSError *error) {
        UserVO *user = object;
        switch (user.role) {
            case 1:{
                self.gotoDashboardBusiness.enabled = true;
                self.gotoDashboardHost.enabled = true;
                self.gotoDashboardHostOther.enabled = true;
                self.gotoDashboardPool.enabled = true;
                self.gotoDashboardStorage.enabled = true;
                self.gotoDashboardVM.enabled = true;
                
                break;
            }
            case 2:{
                self.gotoDashboardBusiness.enabled = false;
                self.gotoDashboardHost.enabled = true;
                self.gotoDashboardHostOther.enabled = true;
                self.gotoDashboardPool.enabled = true;
                self.gotoDashboardStorage.enabled = true;
                self.gotoDashboardVM.enabled = true;
                
                break;
            }
            case 3:{
                self.gotoDashboardBusiness.enabled = true;
                self.gotoDashboardHost.enabled = false;
                self.gotoDashboardHostOther.enabled = false;
                self.gotoDashboardPool.enabled = false;
                self.gotoDashboardStorage.enabled = false;
                self.gotoDashboardVM.enabled = false;
                
                break;
            }
            default:
                break;
        }
    }];
    
    
    [self.scrollView addHeaderWithCallback:^{
        [self refresh];
    }];
    [self refresh];
}

- (IBAction)refreshAction:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = false;
    [self.scrollView headerBeginRefreshing];
}

- (void)refresh{
    [self switchButtonSelected:0];
    
    [[RemoteObject getCurrentDatacenterVO] getDatacenterVOAsync:^(id object, NSError *error) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            if(!self.navigationItem.leftBarButtonItem){
                self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
            }
            self.navigationItem.leftBarButtonItem.title = ((DatacenterVO *)object).name;
        }else{
            if(!self.navigationItem.leftBarButtonItem){
                self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showMenu:)];
            }
        }

        self.datacenterStatWinserver = [DatacenterStatWinserver new];
        [[RemoteObject getCurrentDatacenterVO] getDatacenterStatWinserverVOAsync:^(id object, NSError *error) {
            self.datacenterStatWinserver = object;
            
            [[RemoteObject getCurrentDatacenterVO] getBusinessListAsync:^(id object, NSError *error) {
                self.datacenterStatWinserver.appNumber = (int) ((BusinessListResult*)object).resultList.count;
                
                self.datacenterStatWinserver.totalCpu = 0;
                self.datacenterStatWinserver.totalMemory = 0;
                self.datacenterStatWinserver.totalStorage = 0;
                self.datacenterStatWinserver.availCpu = 0;
                self.datacenterStatWinserver.availMemory = 0;
                self.datacenterStatWinserver.availStorage = 0;
                [[RemoteObject getCurrentDatacenterVO] getPoolListAsync:^(id object, NSError *error) {
                    for(PoolVO *poolVO in ((PoolListResult*)object).resourcePools){
                        [poolVO getPoolVOSync:^(id object, NSError *error) {
                            self.datacenterStatWinserver.totalCpu += ((PoolVO *)object).totalCpu;
                            self.datacenterStatWinserver.totalMemory += ((PoolVO *)object).totalMemory;
                            self.datacenterStatWinserver.totalStorage += ((PoolVO *)object).totalStorage;
                            self.datacenterStatWinserver.availCpu += ((PoolVO *)object).availCpu;
                            self.datacenterStatWinserver.availMemory += ((PoolVO *)object).availMemory;
                            self.datacenterStatWinserver.availStorage += ((PoolVO *)object).availStorage;
                        }];
                    }
                    [[RemoteObject getCurrentDatacenterVO] getHostListAsync:^(id object, NSError *error) {
                        for(HostVO *hostVO in ((HostListResult*)object).hosts){
                            if (!(hostVO.resourcePoolId)) {
                                self.datacenterStatWinserver.totalCpu += hostVO.cpuSpeed;
                                self.datacenterStatWinserver.totalMemory += hostVO.memory;
                                self.datacenterStatWinserver.totalStorage += hostVO.storage;
                                self.datacenterStatWinserver.availCpu += hostVO.availCpu;
                                self.datacenterStatWinserver.availMemory += hostVO.availMemory;
                                self.datacenterStatWinserver.availStorage += hostVO.availStorage;
                            }
                        }
                        
                        [self refreshMainInfo];
                        [self refreshMainInfo2];
                        [self refreshMainInfo3];
                        
                        [self.scrollView headerEndRefreshing];
                        self.navigationItem.rightBarButtonItem.enabled = true;

                        
                    }];
                }];
            }];
        }];
    }];
}
- (void)refreshMainInfo2{
    self.businessCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.appNumber];

}
- (void)refreshMainInfo{
    self.poolCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.resPoolNumber];
    self.hostCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.hostNubmer-self.datacenterStatWinserver.dissociateHostNumber];
    self.vmCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.vmNumber];
    self.dissociateHostNumber.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.dissociateHostNumber];
}

- (void)refreshMainInfo3{
    self.cpuUnitCount.text = [NSString stringWithFormat:@"%.2f%@",[self.datacenterStatWinserver totalCpu_value],[self.datacenterStatWinserver totalCpu_unit]];
    self.cpuUnitCount2.text = [NSString stringWithFormat:@"%.2f%@",[self.datacenterStatWinserver totalCpu_value],[self.datacenterStatWinserver totalCpu_unit]];
    self.cpuUsedCount.text = [NSString stringWithFormat:@"%.2f%@",[self.datacenterStatWinserver usedCpu_value],[self.datacenterStatWinserver usedCpu_unit]];
    self.cpuUnitUnusedCount.text = [NSString stringWithFormat:@"%.2f%@",[self.datacenterStatWinserver availCpu_value],[self.datacenterStatWinserver availCpu_unit]];
    self.cpuUsedInfo.text = [NSString stringWithFormat:@"已用%.2f%@  还剩%.2f%@",[self.datacenterStatWinserver usedCpu_value],[self.datacenterStatWinserver usedCpu_unit],[self.datacenterStatWinserver availCpu_value],[self.datacenterStatWinserver availCpu_unit]];
    
    self.cpuProgress.progress = self.datacenterStatWinserver.cpuRatio/100.0;
    self.cpuProgress.tintColor = [self.datacenterStatWinserver cpuRatioColor];
    
    self.memerySize.text = [NSString stringWithFormat:@"%.2fGB",self.datacenterStatWinserver.totalMemory/1024.0];
    self.memerySize2.text = [NSString stringWithFormat:@"%.2fGB",self.datacenterStatWinserver.totalMemory/1024.0];
    self.memeryUsedSize.text = [NSString stringWithFormat:@"%.2fGB",(self.datacenterStatWinserver.totalMemory-self.datacenterStatWinserver.availMemory)/1024.0];
    self.memoryUnusedSize.text = [NSString stringWithFormat:@"%.2fGB",self.datacenterStatWinserver.availMemory/1024.0];
    self.memeryUsedInfo.text = [NSString stringWithFormat:@"已用%.2fGB  还剩%.2fGB",(self.datacenterStatWinserver.totalMemory-self.datacenterStatWinserver.availMemory)/1024.0,self.datacenterStatWinserver.availMemory/1024.0];
    
    self.memoryProgress.progress = self.datacenterStatWinserver.memoryRatio/100.0;
    self.memoryProgress.tintColor = [self.datacenterStatWinserver memoryRatioColor];
    
    self.storageSize.text = [NSString stringWithFormat:@"%.2f%@",[self.datacenterStatWinserver totalStorage_value],[self.datacenterStatWinserver totalStorage_unit]];
    self.storageSize2.text = [NSString stringWithFormat:@"%.2f%@",[self.datacenterStatWinserver totalStorage_value],[self.datacenterStatWinserver totalStorage_unit]];
    self.storageUsedSize.text = [NSString stringWithFormat:@"%.2f%@",[self.datacenterStatWinserver usedStorage_value],[self.datacenterStatWinserver usedStorage_unit]];
    self.storageUnusedSize.text = [NSString stringWithFormat:@"%.2f%@",[self.datacenterStatWinserver availStorage_value],[self.datacenterStatWinserver availStorage_unit]];
    self.storageUsedInfo.text = [NSString stringWithFormat:@"已用%.2f%@  还剩%.2f%@",[self.datacenterStatWinserver usedStorage_value],[self.datacenterStatWinserver usedStorage_unit],[self.datacenterStatWinserver availStorage_value],[self.datacenterStatWinserver availStorage_unit]];
                                 
    self.storageProgress.progress = self.datacenterStatWinserver.storageRatio/100.0;
    self.storageProgress.tintColor = [self.datacenterStatWinserver storageRatioColor];
    
    //圈图
    for(UIView *subView in self.cpuChartGroup.subviews){
        [subView removeFromSuperview];
    }
    if ([self.datacenterStatWinserver cpuRatio]) {
        self.circleChart = [[PNCircleChart alloc] initWithFrame:self.cpuChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:[self.datacenterStatWinserver cpuRatio]] andClockwise:YES andShadow:YES];
    }else{
        self.circleChart = [[PNCircleChart alloc] initWithFrame:self.cpuChartGroup.bounds andTotal:@100 andCurrent:0 andClockwise:YES andShadow:YES];
    }
    
    self.circleChart.backgroundColor = [UIColor clearColor];
    self.circleChart.strokeColor = [UIColor clearColor];
    //self.circleChart.countingLabel.hidden = YES;
    if (self.datacenterStatWinserver.totalCpu == 0) {
        self.circleChart.circleBG.strokeColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1].CGColor;
    }else{
        self.circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    }
    self.circleChart.circle.lineCap = kCALineCapSquare;//直角填充
    self.circleChart.lineWidth = @11.0f;//线宽度
    [self.circleChart setStrokeColor:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1]];//已使用填充颜色
    [self.circleChart strokeChart];
    [self.cpuChartGroup addSubview:self.circleChart];
    
    for(UIView *subView in self.memoryChartGroup.subviews){
        [subView removeFromSuperview];
    }
    if ([self.datacenterStatWinserver memoryRatio]) {
        self.circleChart2 = [[PNCircleChart alloc] initWithFrame:self.memoryChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:[self.datacenterStatWinserver memoryRatio]] andClockwise:YES andShadow:YES];
    }else{
        self.circleChart2 = [[PNCircleChart alloc] initWithFrame:self.memoryChartGroup.bounds andTotal:@100 andCurrent:0 andClockwise:YES andShadow:YES];
    }
    
    self.circleChart2.backgroundColor = [UIColor clearColor];
    self.circleChart2.strokeColor = [UIColor clearColor];
    if (self.datacenterStatWinserver.totalMemory == 0) {
        self.circleChart2.circleBG.strokeColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1].CGColor;
    }else{
        self.circleChart2.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    }
    self.circleChart2.circle.lineCap = kCALineCapSquare;//直角填充
    self.circleChart2.lineWidth = @11.0f;//线宽度
    [self.circleChart2 setStrokeColor:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1]];//已使用填充颜色
//    [circleChart2 setStrokeColor:[self.datacenterStatWinserver memoryRatioColor]];
    [self.circleChart2 strokeChart];
    [self.memoryChartGroup addSubview:self.circleChart2];
    
    for(UIView *subView in self.storageChartGroup.subviews){
        [subView removeFromSuperview];
    }
    
    if ([self.datacenterStatWinserver storageRatio]) {
        self.circleChart3 = [[PNCircleChart alloc] initWithFrame:self.storageChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:[self.datacenterStatWinserver storageRatio]] andClockwise:YES andShadow:YES];
    }else{
        self.circleChart3 = [[PNCircleChart alloc] initWithFrame:self.storageChartGroup.bounds andTotal:@100 andCurrent:0 andClockwise:YES andShadow:YES];
    }
    self.circleChart3.backgroundColor = [UIColor clearColor];
    self.circleChart3.strokeColor = [UIColor clearColor];
    self.circleChart3.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    self.circleChart3.circle.lineCap = kCALineCapSquare;//直角填充
    self.circleChart3.lineWidth = @11.0f;//线宽度
    if (self.datacenterStatWinserver.totalStorage == 0) {
        self.circleChart3.circleBG.strokeColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1].CGColor;
    }else{
        self.circleChart3.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    }
//    [circleChart3 setStrokeColor:[self.datacenterStatWinserver storageRatioColor]];
    [self.circleChart3 setStrokeColor:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1]];//已使用填充颜色
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Warning" bundle:nil] instantiateInitialViewController];
        UIViewController *vc = [[nav childViewControllers] firstObject];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if(self.popover!=nil){
            [self.popover dismissPopoverAnimated:NO];
        }
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Warning" bundle:nil] instantiateInitialViewController];
        self.popover = [[UIPopoverController alloc] initWithContentViewController:vc];
        UIBarButtonItem *button = (UIBarButtonItem*)sender;
        [self.popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

-(IBAction)showControlRecordVC:(id)sender{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
        UIViewController *vc = [[nav childViewControllers] firstObject];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if(self.popover!=nil){
            [self.popover dismissPopoverAnimated:NO];
        }
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
        self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
        UIBarButtonItem *button = (UIBarButtonItem*)sender;
        [self.popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}
- (IBAction)gotoDashboard:(id)sender {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [((RootVC*)self.frostedViewController) showTab:((UIButton*)sender).tag];
    }else{
        DashboardVC *vc = (DashboardVC*)self.parentViewController.parentViewController.parentViewController;
        [vc.tabBarVC setSelectedIndex:((UIButton*)sender).tag];
        [vc.menuVC setSelectedItemIndex:((UIButton*)sender).tag];
    }
}
@end

//
//  PoolCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "HostDashboardVC.h"
#import "HostContainerVC.h"
#import "HostDashboardCell.h"
#import "HostDashboardHeader.h"

@interface HostDashboardVC ()

@property DatacenterStatWinserver *datacenterStatWinserver;
@property HostSubStateVO *hostStatWinserver;

@end

@implementation HostDashboardVC

-(void)reloadData{

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
        
        [[RemoteObject getCurrentDatacenterVO] getDatacenterStatWinserverVOAsync:^(id object, NSError *error) {
            
            self.datacenterStatWinserver = object;
            
            [[RemoteObject getCurrentDatacenterVO] getHostSubVOAsync:^(id object, NSError *error) {
                self.hostStatWinserver = object;
                
                if(self.poolVO){
                    [self.poolVO getHostListAsync:^(id object, NSError *error) {
                        NSUInteger recordTotal = ((HostListResult*)object).hosts.count;
                        
                        [self.poolVO getHostListAsync:^(id object, NSError *error) {
                            [self.dataList addObjectsFromArray:((HostListResult*)object).hosts];
                            
                            [self.collectionView headerEndRefreshing];
                            if(self.dataList.count >= recordTotal){
                                [self.collectionView footerFinishingLoading];
                            }else{
                                [self.collectionView footerEndRefreshing];
                            }
                            [self.collectionView reloadData];
                            self.navigationItem.rightBarButtonItem.enabled = true;
                        } referTo:self.dataList];
                    }];
                }else if(self.isOutofPool){
                    //游离物理主机
                    [[RemoteObject getCurrentDatacenterVO] getHostListAsync:^(id object, NSError *error) {
                        NSMutableArray *hostOfPoolList = [NSMutableArray new];
                        for (HostVO *host in ((HostListResult*)object).hosts) {
                            if (!(host.resourcePoolId)) {
                                [hostOfPoolList addObject: host];
                            }
                        }
                        [self.dataList addObjectsFromArray:hostOfPoolList];
                        
                        [self.collectionView headerEndRefreshing];
                        [self.collectionView footerFinishingLoading];
                        [self.collectionView reloadData];
                        self.navigationItem.rightBarButtonItem.enabled = true;
                    }];
                }else{
                    [[RemoteObject getCurrentDatacenterVO] getHostListAsync:^(id object, NSError *error) {
                        NSUInteger recordTotal = ((HostListResult*)object).hosts.count;
                        
                        [[RemoteObject getCurrentDatacenterVO] getHostListAsync:^(id object, NSError *error) {
                            [self.dataList addObjectsFromArray:((HostListResult*)object).hosts];
                            
                            [self.collectionView headerEndRefreshing];
                            if(self.dataList.count >= recordTotal){
                                [self.collectionView footerFinishingLoading];
                            }else{
                                [self.collectionView footerEndRefreshing];
                            }
                            [self.collectionView reloadData];
                            self.navigationItem.rightBarButtonItem.enabled = true;
                        } referTo:self.dataList];
                    }];
                }
            }];
        }];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HostDashboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HostDashboardCell" forIndexPath:indexPath];
    
    if(self.dataList.count==0) return cell;
    
    HostVO *hostVO = (HostVO *) self.dataList[indexPath.row];
    cell.title.text = hostVO.hostName;
    cell.ip.text = hostVO.ip;
    if(hostVO.ip == nil){
        cell.ip.text = @"无法获取网络";
        cell.ip.textColor = [UIColor lightGrayColor];
    }else{
        cell.ip.textColor = [UIColor blackColor];
    }
    cell.vmCount.text = [NSString stringWithFormat:@"%d",hostVO.virtualMachineNum ];
    cell.storageSize.text = [NSString stringWithFormat:@"%.2f%@",[hostVO localStorage_value],[hostVO localStorage_unit]];
    cell.cpuSlots.text = [NSString stringWithFormat:@"%d",hostVO.cpuSlots];
    cell.cpu.text = [NSString stringWithFormat:@"%d",hostVO.cpu];
    cell.memorySize.text = [NSString stringWithFormat:@"%.2fGB",hostVO.memory/1024.0];
    cell.status.text = [hostVO state_text];
    cell.status.textColor = [hostVO state_color];
    cell.status_image.layer.cornerRadius = 6;
    cell.status_image.backgroundColor = [hostVO state_color];
    
    cell.progress_1.litEffect = NO;
    cell.progress_1.numBars = 10;
    cell.progress_1.value = [self formatCountData:hostVO.virtualMachineNum/16.0];
    cell.progress_1.backgroundColor = [UIColor clearColor];
    cell.progress_1.outerBorderColor = [UIColor clearColor];
    cell.progress_1.innerBorderColor = [UIColor clearColor];
    
    cell.progress_2.litEffect = NO;
    cell.progress_2.numBars = 10;
    cell.progress_2.value = [self formatCountData:hostVO.localStorage/640.0];
    cell.progress_2.backgroundColor = [UIColor clearColor];
    cell.progress_2.outerBorderColor = [UIColor clearColor];
    cell.progress_2.innerBorderColor = [UIColor clearColor];
    
    cell.progress_3.litEffect = NO;
    cell.progress_3.numBars = 10;
    cell.progress_3.value = [self formatCountData:hostVO.cpuSlots/16.0];
    cell.progress_3.backgroundColor = [UIColor clearColor];
    cell.progress_3.outerBorderColor = [UIColor clearColor];
    cell.progress_3.innerBorderColor = [UIColor clearColor];
    
    cell.progress_4.litEffect = NO;
    cell.progress_4.numBars = 10;
    cell.progress_4.value = [self formatCountData:hostVO.cpu/(2*8*4.0)];
    cell.progress_4.backgroundColor = [UIColor clearColor];
    cell.progress_4.outerBorderColor = [UIColor clearColor];
    cell.progress_4.innerBorderColor = [UIColor clearColor];
    
    cell.progress_5.litEffect = NO;
    cell.progress_5.numBars = 10;
    cell.progress_5.value = [self formatCountData:hostVO.memory/(1024.0*256.0)];
    cell.progress_5.backgroundColor = [UIColor clearColor];
    cell.progress_5.outerBorderColor = [UIColor clearColor];
    cell.progress_5.innerBorderColor = [UIColor clearColor];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HostDashboardHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HostDashboardHeader" forIndexPath:indexPath];
    header.hostCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.hostNubmer];
    header.inPoolHostCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.hostNubmer - self.datacenterStatWinserver.dissociateHostNumber];
    header.dissociateHostCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.dissociateHostNumber];
    header.statusOthers.text = [NSString stringWithFormat:@"%d",self.hostStatWinserver.other];
    header.statusOk.text = [NSString stringWithFormat:@"%d",self.hostStatWinserver.OK];
    header.statusDis.text = [NSString stringWithFormat:@"%d",self.hostStatWinserver.DISCONNECT];
    
    //缩起
    header.hostCount2.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.hostNubmer - self.datacenterStatWinserver.dissociateHostNumber];
    header.inPoolHostCount2.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.hostNubmer];
    header.dissociateHostCount2.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.dissociateHostNumber];
    header.statusOthers2.text = [NSString stringWithFormat:@"%d",self.hostStatWinserver.other];
    header.statusOk2.text = [NSString stringWithFormat:@"%d",self.hostStatWinserver.OK];
    header.statusDis2.text = [NSString stringWithFormat:@"%d",self.hostStatWinserver.DISCONNECT];
    
    //圈图
    
    for(UIView *subView in header.hostTypeChart.subviews){
        [subView removeFromSuperview];
    }
    PNCircleChart * circleChart;
    if(self.datacenterStatWinserver.hostNubmer == 0){
        circleChart= [[PNCircleChart alloc] initWithFrame:header.hostTypeChart.bounds andTotal:@100 andCurrent:0 andClockwise:YES andShadow:YES];
    }else{
        circleChart= [[PNCircleChart alloc] initWithFrame:header.hostTypeChart.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:(self.datacenterStatWinserver.hostNubmer - self.datacenterStatWinserver.dissociateHostNumber)*100/self.datacenterStatWinserver.hostNubmer] andClockwise:YES andShadow:YES];
    }
    circleChart.backgroundColor = [UIColor clearColor];
    circleChart.strokeColor = [UIColor clearColor];
    circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    circleChart.circle.lineCap = kCALineCapSquare;//直角填充
    circleChart.lineWidth = @11.0f;//线宽度
    [circleChart setStrokeColor:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1]];//已使用填充颜色
    [circleChart strokeChart];
    [header.hostTypeChart addSubview:circleChart];
    
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:self.hostStatWinserver.other color:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1] description:@""],
                       [PNPieChartDataItem dataItemWithValue:self.hostStatWinserver.OK color:[UIColor colorWithRed:91.0/255 green:213.0/255 blue:68.0/255 alpha:1] description:@""],
                       [PNPieChartDataItem dataItemWithValue:self.hostStatWinserver.DISCONNECT color:[UIColor colorWithRed:255.0/255 green:216.0/255 blue:0.0/255 alpha:1] description:@""],
                       ];
    
    
    if (self.hostStatWinserver.total > 0) {
        for(UIView *subView in header.hostStatusChart.subviews){
            [subView removeFromSuperview];
        }
        PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:header.hostStatusChart.bounds items:items];
        pieChart.descriptionTextColor = [UIColor whiteColor];
        pieChart.descriptionTextFont  = [UIFont fontWithName:@"" size:14.0];
        [pieChart strokeChart];
        [header.hostStatusChart addSubview:pieChart];
    }
    
//    PNCircleChart * circleChart2 = [[PNCircleChart alloc] initWithFrame:header.hostStatusChart.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:50] andClockwise:YES andShadow:YES];
//    circleChart2.backgroundColor = [UIColor clearColor];
//    circleChart2.strokeColor = [UIColor clearColor];
//    circleChart2.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
//    circleChart2.circle.lineCap = kCALineCapSquare;//直角填充
//    circleChart2.lineWidth = @11.0f;//线宽度
//    [circleChart2 setStrokeColor:[UIColor colorWithRed:88.0/255 green:206.0/255 blue:96.0/255 alpha:1]];//已使用填充颜色
//    [circleChart2 strokeChart];
//    [header.hostStatusChart addSubview:circleChart2];
    
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *root = [[UIStoryboard storyboardWithName:@"Host" bundle:nil] instantiateInitialViewController];
    HostContainerVC *vc;
    if([root isKindOfClass:[HostContainerVC class]]){
        vc = (HostContainerVC*) root;
    }else{
        vc = [[root childViewControllers] firstObject];
    }
    vc.hostVO = (HostVO *) self.dataList[indexPath.row];

    
    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }
}


@end

//
//  PoolCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmDashboardVC.h"
#import "VmContainerVC.h"
#import "VmDashboardCell.h"
#import "VmDashboardHeader.h"

@interface VmDashboardVC ()

@property DatacenterStatWinserver *datacenterStatWinserver;
@property VmSubVO *vmSubVO;

@end

@implementation VmDashboardVC

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
            
            [[RemoteObject getCurrentDatacenterVO] getVmSubVOAsync:^(id object, NSError *error) {
                self.vmSubVO = object;
                
                if(self.poolVO){
                    [self.poolVO getVmListAsync:^(id object, NSError *error) {
                        [self.dataList addObjectsFromArray:((VmListResult*)object).vms];
                        
                        [self.collectionView headerEndRefreshing];
                        if(self.dataList.count >= ((VmListResult*)object).recordTotal){
                            [self.collectionView footerFinishingLoading];
                        }else{
                            [self.collectionView footerEndRefreshing];
                        }
                        [self.collectionView reloadData];
                        self.navigationItem.rightBarButtonItem.enabled = true;
                    } referTo:self.dataList];
                }else if(self.isOutofPool){
                    //游离物理主机
                    [[RemoteObject getCurrentDatacenterVO] getVmListAsync:^(id object, NSError *error) {
                        NSMutableArray *vmOfPoolList = [NSMutableArray new];
                        for (VmVO *vm in ((VmListResult*)object).vms) {
                            if (!(vm.poolId)) {
                                [vmOfPoolList addObject: vm];
                            }
                        }
                        [self.dataList addObjectsFromArray:vmOfPoolList];
                        
                        [self.collectionView headerEndRefreshing];
                        [self.collectionView footerFinishingLoading];
                        [self.collectionView reloadData];
                        self.navigationItem.rightBarButtonItem.enabled = true;
                    }];
                }else{
                    [[RemoteObject getCurrentDatacenterVO] getVmListAsync:^(id object, NSError *error) {
                        [self.dataList addObjectsFromArray:((VmListResult*)object).vms];
                        
                        [self.collectionView headerEndRefreshing];
                        if(self.dataList.count >= ((VmListResult*)object).recordTotal){
                            [self.collectionView footerFinishingLoading];
                        }else{
                            [self.collectionView footerEndRefreshing];
                        }
                        [self.collectionView reloadData];
                        self.navigationItem.rightBarButtonItem.enabled = true;
                        
                    } referTo:self.dataList];

                }
            }];
        }];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VmDashboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VmDashboardCell" forIndexPath:indexPath];
    
    if(self.dataList.count==0) return cell;
    
    VmVO *vmVO = (VmVO *) self.dataList[indexPath.row];
    cell.title.text = vmVO.name;
    cell.ip.text = vmVO.ip;
    if(vmVO.ip == nil || [vmVO.ip isEqualToString:@""]){
        cell.ip.text = @"无法获取网络";
        cell.ip.textColor = [UIColor lightGrayColor];
    }else{
        cell.ip.textColor = [UIColor blackColor];
    }
    cell.vCpu.text = [NSString stringWithFormat:@"%d", vmVO.vcpu];
    cell.memorySize.text = [NSString stringWithFormat:@"%.2fGB", vmVO.memory/1024.0];
    cell.storageSize.text = [NSString stringWithFormat:@"%.2f%@", [vmVO storage_value], [vmVO storage_unit]];
    
    HostVO *hostVO = [HostVO new];
    hostVO.hostId = vmVO.ownerHostId;
    [hostVO getHostVOAsync:^(id object, NSError *error) {
        HostVO *hostVO = (HostVO*) object;
        if([hostVO.state isEqualToString:@"DISCONNECT"]){
            cell.status.text = @"未知";
        }else{
            cell.status.text = [vmVO state_text];
            cell.status.textColor = [vmVO state_color];
        }
    }];
    
    cell.osType.text = vmVO.osType;
    if (vmVO.osType == nil) {
        cell.osType.text = @"(尚未安装系统)";
    }
    cell.osType_image.image = [UIImage imageNamed:[vmVO osType_imageName]];
    cell.status_image.layer.cornerRadius = 6;
    cell.status_image.backgroundColor = [vmVO state_color];
    
    cell.progress_1.litEffect = NO;
    cell.progress_1.numBars = 10;
    cell.progress_1.value = [self formatCountData:vmVO.vcpu/(2*8*4.0)];;
    cell.progress_1.backgroundColor = [UIColor clearColor];
    cell.progress_1.outerBorderColor = [UIColor clearColor];
    cell.progress_1.innerBorderColor = [UIColor clearColor];
    
    cell.progress_2.litEffect = NO;
    cell.progress_2.numBars = 10;
    cell.progress_2.value = [self formatCountData:vmVO.memory/(1024.0*16.0)];;
    cell.progress_2.backgroundColor = [UIColor clearColor];
    cell.progress_2.outerBorderColor = [UIColor clearColor];
    cell.progress_2.innerBorderColor = [UIColor clearColor];
    
    cell.progress_3.litEffect = NO;
    cell.progress_3.numBars = 10;
    cell.progress_3.value = [self formatCountData:vmVO.storage/320.0];;
    cell.progress_3.backgroundColor = [UIColor clearColor];
    cell.progress_3.outerBorderColor = [UIColor clearColor];
    cell.progress_3.innerBorderColor = [UIColor clearColor];
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    VmDashboardHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"VmDashboardHeader" forIndexPath:indexPath];
    
    header.vmCount.text =[NSString stringWithFormat:@"%d",self.datacenterStatWinserver.vmNumber];
    header.osTypeWin.text =[NSString stringWithFormat:@"%d",self.vmSubVO.os.Windows];
    header.osTypeLinux.text =[NSString stringWithFormat:@"%d",self.vmSubVO.os.Linux];
    header.statusOthers.text =[NSString stringWithFormat:@"%d",self.vmSubVO.state.other];
    header.statusOk.text =[NSString stringWithFormat:@"%d",self.vmSubVO.state.OK];
    header.statusDis.text =[NSString stringWithFormat:@"%d",self.vmSubVO.state.STOPPED];
    
    //缩起
    header.vmCount2.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.vmNumber];
    header.statusOthers2.text =[NSString stringWithFormat:@"%d",self.vmSubVO.state.other];
    header.statusOk2.text =[NSString stringWithFormat:@"%d",self.vmSubVO.state.OK];
    header.statusDis2.text =[NSString stringWithFormat:@"%d",self.vmSubVO.state.STOPPED];
    header.osTypeWin2.text =[NSString stringWithFormat:@"%d",self.vmSubVO.os.Windows];
    header.osTypeLinux2.text =[NSString stringWithFormat:@"%d",self.vmSubVO.os.Linux];
    
    //圈图
    
    if([self.vmSubVO.os total]>0){
        for(UIView *subView in header.vmOsTypeChart.subviews){
            [subView removeFromSuperview];
        }
    NSArray *items2 = @[[PNPieChartDataItem dataItemWithValue:self.vmSubVO.os.Windows color:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1] description:@""],
                       [PNPieChartDataItem dataItemWithValue:self.vmSubVO.os.Linux color:[UIColor colorWithRed:255.0/255 green:216.0/255 blue:0.0/255 alpha:1] description:@""],
                       ];
    PNPieChart *pieChart2 = [[PNPieChart alloc] initWithFrame:header.vmOsTypeChart.bounds items:items2];
    pieChart2.descriptionTextColor = [UIColor whiteColor];
    pieChart2.descriptionTextFont  = [UIFont fontWithName:@"" size:14.0];
    [pieChart2 strokeChart];
    [header.vmOsTypeChart addSubview:pieChart2];
    }else{
        
        NSArray *items = @[[PNPieChartDataItem dataItemWithValue:5 color:[UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1] description:@""]
                           ];
        PNPieChart *pieChart2 = [[PNPieChart alloc] initWithFrame:header.vmOsTypeChart.bounds items:items];
        pieChart2.descriptionTextColor = [UIColor whiteColor];
        pieChart2.descriptionTextFont  = [UIFont fontWithName:@"" size:14.0];
        [pieChart2 strokeChart];
        [header.vmOsTypeChart addSubview:pieChart2];

    }
    
    if([self.vmSubVO.state total]>0){
        for(UIView *subView in header.vmStatusChart.subviews){
            [subView removeFromSuperview];
        }
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:self.vmSubVO.state.other color:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1] description:@""],
                       [PNPieChartDataItem dataItemWithValue:self.vmSubVO.state.OK color:[UIColor colorWithRed:91.0/255 green:213.0/255 blue:68.0/255 alpha:1] description:@""],
                       [PNPieChartDataItem dataItemWithValue:self.vmSubVO.state.STOPPED color:[UIColor colorWithRed:255.0/255 green:216.0/255 blue:0.0/255 alpha:1] description:@""],
                       ];
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:header.vmStatusChart.bounds items:items];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"" size:14.0];
    [pieChart strokeChart];
    [header.vmStatusChart addSubview:pieChart];
    }else{
    
        NSArray *items = @[[PNPieChartDataItem dataItemWithValue:5 color:[UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1] description:@""]
                           ];
        PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:header.vmStatusChart.bounds items:items];
        pieChart.descriptionTextColor = [UIColor whiteColor];
        pieChart.descriptionTextFont  = [UIFont fontWithName:@"" size:14.0];
        [pieChart strokeChart];
        [header.vmStatusChart addSubview:pieChart];
    }
    
    
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    UIViewController *root = [[UIStoryboard storyboardWithName:@"VM" bundle:nil] instantiateInitialViewController];
    VmContainerVC *vc;
    if([root isKindOfClass:[VmContainerVC class]]){
        vc = (VmContainerVC*) root;
    }else{
        vc = [[root childViewControllers] firstObject];
    }
    vc.vmVO = (VmVO *) self.dataList[indexPath.row];

    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }
}


@end

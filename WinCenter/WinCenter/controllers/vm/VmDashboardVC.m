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
    [[RemoteObject getCurrentDatacenterVO] getVmListAsync:^(NSArray *allRemote, NSError *error) {
        [self.dataList setValue:allRemote forKey:[RemoteObject getCurrentDatacenterVO].name];
        
        [[RemoteObject getCurrentDatacenterVO] getDatacenterStatWinserverVOAsync:^(id object, NSError *error) {
            self.datacenterStatWinserver = object;
            
            [[RemoteObject getCurrentDatacenterVO] getVmSubVOAsync:^(id object, NSError *error) {
                self.vmSubVO = object;
                [self.collectionView reloadData];
            }];
        }];
    }];
    

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VmDashboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VmDashboardCell" forIndexPath:indexPath];
    
    VmVO *vmVO = (VmVO *) [self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];
    cell.title.text = vmVO.name;
    cell.label1.text = vmVO.ip;
    if(vmVO.ip == nil){
        cell.label1.text = @"(尚未配置ip)";
    }
    cell.label2.text = [NSString stringWithFormat:@"%d", vmVO.vcpu];
    cell.label3.text = [NSString stringWithFormat:@"%.2fGB", vmVO.memory/1024.0];
    cell.label4.text = [NSString stringWithFormat:@"%dGB", vmVO.storage];
    cell.status.text = [vmVO state_text];
    cell.status.textColor = [vmVO state_color];
    cell.osType_image.image = [UIImage imageNamed:[vmVO osType_imageName]];
    
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
    header.label1.text =[NSString stringWithFormat:@"%d",self.vmSubVO.os.Windows];
    header.label3.text =[NSString stringWithFormat:@"%d",self.vmSubVO.os.Linux];
    header.label6.text =[NSString stringWithFormat:@"%d",self.vmSubVO.state.other];
    header.label7.text =[NSString stringWithFormat:@"%d",self.vmSubVO.state.OK];
    header.label8.text =[NSString stringWithFormat:@"%d",self.vmSubVO.state.STOPPED];
    
    //缩起
    header.label10.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.vmNumber];
    header.label11.text =[NSString stringWithFormat:@"%d",self.vmSubVO.state.other];
    header.label12.text =[NSString stringWithFormat:@"%d",self.vmSubVO.state.OK];
    header.label13.text =[NSString stringWithFormat:@"%d",self.vmSubVO.state.STOPPED];
    header.label14.text =[NSString stringWithFormat:@"%d",self.vmSubVO.os.Windows];
    header.label16.text =[NSString stringWithFormat:@"%d",self.vmSubVO.os.Linux];
    
    //圈图
    
    if([self.vmSubVO.os total]>0){
    NSArray *items2 = @[[PNPieChartDataItem dataItemWithValue:self.vmSubVO.os.Windows color:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1] description:@""],
                       [PNPieChartDataItem dataItemWithValue:self.vmSubVO.os.Linux color:[UIColor colorWithRed:255.0/255 green:216.0/255 blue:0.0/255 alpha:1] description:@""],
                       ];
    PNPieChart *pieChart2 = [[PNPieChart alloc] initWithFrame:header.vmOsTypeChart.bounds items:items2];
    pieChart2.descriptionTextColor = [UIColor whiteColor];
    pieChart2.descriptionTextFont  = [UIFont fontWithName:@"" size:14.0];
    [pieChart2 strokeChart];
    [header.vmOsTypeChart addSubview:pieChart2];
    }
    
    if([self.vmSubVO.state total]>0){
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:self.vmSubVO.state.other color:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1] description:@""],
                       [PNPieChartDataItem dataItemWithValue:self.vmSubVO.state.OK color:[UIColor colorWithRed:91.0/255 green:213.0/255 blue:68.0/255 alpha:1] description:@""],
                       [PNPieChartDataItem dataItemWithValue:self.vmSubVO.state.STOPPED color:[UIColor colorWithRed:255.0/255 green:216.0/255 blue:0.0/255 alpha:1] description:@""],
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
    vc.vmVO = (VmVO *)[self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];

    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }
}


@end

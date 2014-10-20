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
    [[RemoteObject getCurrentDatacenterVO] getHostListAsync:^(NSArray *allRemote, NSError *error) {
        [self.dataList setValue:allRemote forKey:[RemoteObject getCurrentDatacenterVO].name];
        [self.collectionView reloadData];
    }];
    
    [[RemoteObject getCurrentDatacenterVO] getDatacenterStatWinserverVOAsync:^(id object, NSError *error) {
        self.datacenterStatWinserver = object;
    }];
    
    [[RemoteObject getCurrentDatacenterVO] getHostSubVOAsync:^(id object, NSError *error) {
        self.hostStatWinserver = object;
    }];

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HostDashboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HostDashboardCell" forIndexPath:indexPath];
    
    HostVO *hostVO = (HostVO *) [self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];
    cell.title.text = hostVO.hostName;
    cell.label1.text = hostVO.ip;
    cell.label2.text = [NSString stringWithFormat:@"%d",hostVO.virtualMachineNum ];
    cell.label3.text = [NSString stringWithFormat:@"%.2fGB",hostVO.storage];
    cell.label4.text = [NSString stringWithFormat:@"%d",hostVO.cpuSlots];
    cell.label5.text = [NSString stringWithFormat:@"%d",hostVO.cpu];
    cell.label6.text = [NSString stringWithFormat:@"%.2fGB",hostVO.memory/1024.0];
    cell.status.text = [hostVO state_text];
    cell.status.textColor = [hostVO state_color];
    
    cell.progress_1.litEffect = NO;
    cell.progress_1.numBars = 10;
    cell.progress_1.value = [self formatCountData:hostVO.virtualMachineNum/16.0];
    cell.progress_1.backgroundColor = [UIColor clearColor];
    cell.progress_1.outerBorderColor = [UIColor clearColor];
    cell.progress_1.innerBorderColor = [UIColor clearColor];
    
    cell.progress_2.litEffect = NO;
    cell.progress_2.numBars = 10;
    cell.progress_2.value = [self formatCountData:hostVO.storage/640.0];
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
    header.hostCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.hostNubmer + self.datacenterStatWinserver.dissociateHostNumber];
    header.label1.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.hostNubmer];
    header.label2.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.dissociateHostNumber];
    header.label3.text = [NSString stringWithFormat:@"%d",self.hostStatWinserver.other];
    header.label4.text = [NSString stringWithFormat:@"%d",self.hostStatWinserver.OK];
    header.label5.text = [NSString stringWithFormat:@"%d",self.hostStatWinserver.DISCONNECT];
    
    //缩起
    header.label6.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.hostNubmer + self.datacenterStatWinserver.dissociateHostNumber];
    header.label7.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.hostNubmer];
    header.label8.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.dissociateHostNumber];
    header.label9.text = [NSString stringWithFormat:@"%d",self.hostStatWinserver.other];
    header.label10.text = [NSString stringWithFormat:@"%d",self.hostStatWinserver.OK];
    header.label11.text = [NSString stringWithFormat:@"%d",self.hostStatWinserver.DISCONNECT];
    
    //圈图
    PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:header.hostTypeChart.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:self.datacenterStatWinserver.hostNubmer*100/(self.datacenterStatWinserver.hostNubmer + self.datacenterStatWinserver.dissociateHostNumber)] andClockwise:YES andShadow:YES];
    circleChart.backgroundColor = [UIColor clearColor];
    circleChart.strokeColor = [UIColor clearColor];
    circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    circleChart.circle.lineCap = kCALineCapSquare;//直角填充
    circleChart.lineWidth = @11.0f;//线宽度
    [circleChart setStrokeColor:[UIColor colorWithRed:71.0/255 green:145.0/255 blue:210.0/255 alpha:1]];//已使用填充颜色
    [circleChart strokeChart];
    [header.hostTypeChart addSubview:circleChart];
    
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNRed],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNBlue description:@"WWDC"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNGreen description:@"GOOL I/O"],
                       ];

    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 155.0, 240.0, 240.0) items:items];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    [pieChart strokeChart];
    [header.hostStatusChart addSubview:pieChart];

    
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
    vc.hostVO = (HostVO *)[self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];

    
    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }
}


@end

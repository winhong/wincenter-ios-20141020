//
//  PoolCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "PoolDashboardVC.h"
#import "PoolContainerVC.h"
#import "PoolDashboardCell.h"
#import "PoolDashboardHeader.h"

@interface PoolDashboardVC ()

@property DatacenterStatWinserver *datacenterStatWinserver;
@property PoolSubVO *poolStatWinserver;

@end

@implementation PoolDashboardVC

-(void)reloadData{
    [[RemoteObject getCurrentDatacenterVO] getPoolListAsync:^(NSArray *allRemote, NSError *error) {
        [self.dataList setValue:allRemote forKey:[RemoteObject getCurrentDatacenterVO].name];
        [self.collectionView reloadData];
    }];
    
    [[RemoteObject getCurrentDatacenterVO] getDatacenterStatWinserverVOAsync:^(id object, NSError *error) {
        self.datacenterStatWinserver = object;
    }];
    
    [[RemoteObject getCurrentDatacenterVO] getPoolSubVOAsync:^(id object, NSError *error) {
        self.poolStatWinserver = object;
    }];
    
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    PoolDashboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PoolDashboardCell" forIndexPath:indexPath];
    
    
    PoolVO *poolVO = (PoolVO *) [self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];
    cell.title.text = poolVO.resourcePoolName;
    cell.hostCount.text = [NSString stringWithFormat:@"%d台", poolVO.hostNumber];
    cell.activeVmCount.text = [NSString stringWithFormat:@"%d台", poolVO.activeVmNumber];
    cell.cpuUnitCount.text = [NSString stringWithFormat:@"%.2fGHz", poolVO.totalCpu/1000.0];
    cell.memerySize.text = [NSString stringWithFormat:@"%.2fGB", poolVO.totalMemory/1024.0];
    cell.storageSize.text = [NSString stringWithFormat:@"%.2fGB", poolVO.totalStorage];
    
    cell.progress_1.litEffect = NO;
    cell.progress_1.numBars = 10;
    cell.progress_1.value = [self formatCountData:poolVO.hostNumber/16.0];

    cell.progress_1.backgroundColor = [UIColor clearColor];
    cell.progress_1.outerBorderColor = [UIColor clearColor];
    cell.progress_1.innerBorderColor = [UIColor clearColor];
    
    cell.progress_2.litEffect = NO;
    cell.progress_2.numBars = 10;
    cell.progress_2.value = [self formatCountData:poolVO.activeVmNumber/(16*16.0)];
    cell.progress_2.backgroundColor = [UIColor clearColor];
    cell.progress_2.outerBorderColor = [UIColor clearColor];
    cell.progress_2.innerBorderColor = [UIColor clearColor];
    
    cell.progress_3.litEffect = NO;
    cell.progress_3.numBars = 10;
    cell.progress_3.value = 1;
    cell.progress_3.backgroundColor = [UIColor clearColor];
    cell.progress_3.outerBorderColor = [UIColor clearColor];
    cell.progress_3.innerBorderColor = [UIColor clearColor];
    
    cell.progress_4.litEffect = NO;
    cell.progress_4.numBars = 10;
    cell.progress_4.value = [self formatCountData:poolVO.totalMemory/(1024.0*256*16)];
    cell.progress_4.backgroundColor = [UIColor clearColor];
    cell.progress_4.outerBorderColor = [UIColor clearColor];
    cell.progress_4.innerBorderColor = [UIColor clearColor];
    
    cell.progress_5.litEffect = NO;
    cell.progress_5.numBars = 10;
    cell.progress_5.value = [self formatCountData:poolVO.totalStorage/(640*16.0)];
    cell.progress_5.backgroundColor = [UIColor clearColor];
    cell.progress_5.outerBorderColor = [UIColor clearColor];
    cell.progress_5.innerBorderColor = [UIColor clearColor];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    PoolDashboardHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PoolDashboardHeader" forIndexPath:indexPath];
    PoolVO *poolVO = (PoolVO *) [self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];
    header.poolCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.resPoolNumber];
    header.haPoolCount.text = [NSString stringWithFormat:@"%d",self.poolStatWinserver.ha_num];
    header.elasticCalPoolCount.text = [NSString stringWithFormat:@"%d",self.poolStatWinserver.plan_num];
    header.cpuUsedCount.text = [NSString stringWithFormat:@"%.2fGHz",(poolVO.totalCpu - poolVO.availCpu)/1024.0];
    header.cpuUnitUnusedCount.text = [NSString stringWithFormat:@"%.2fGHz",poolVO.availCpu/1024];
    header.memeryUsedSize.text = [NSString stringWithFormat:@"%.2fG",(poolVO.totalMemory - poolVO.availMemory)/1024.0];
    header.memoryUnusedSize.text = [NSString stringWithFormat:@"%.2fG",poolVO.availMemory/1024];
    header.storageUsedSize.text = [NSString stringWithFormat:@"%.2fT",(poolVO.totalStorage - poolVO.availStorage)/1024.0];
    header.storageUnusedSize.text = [NSString stringWithFormat:@"%.2fT",poolVO.availStorage/1024.0];

    //缩起
    header.poolCount2.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.resPoolNumber];
    header.haPoolCount2.text = [NSString stringWithFormat:@"%d",self.poolStatWinserver.ha_num];
    header.elasticCalPoolCount2.text = [NSString stringWithFormat:@"%d",self.poolStatWinserver.plan_num];
    header.cpuUnitCount2.text = [NSString stringWithFormat:@"%.2f",poolVO.totalCpu/1024];
    header.cpuUsedCount2.text = [NSString stringWithFormat:@"%.2f",(poolVO.totalCpu - poolVO.availCpu)/1024.0];
    header.cpuUnitUnusedCount2.text = [NSString stringWithFormat:@"%.2f",poolVO.availCpu/1024];
    header.memerySize2.text = [NSString stringWithFormat:@"%.2f",poolVO.totalMemory/1024.0];
    header.memeryUsedSize2.text = [NSString stringWithFormat:@"%.2f",(poolVO.totalMemory - poolVO.availMemory)/1024.0];
    header.memoryUnusedSize2.text = [NSString stringWithFormat:@"%.2f",poolVO.availMemory/1024.0];
    header.storageSize2.text = [NSString stringWithFormat:@"%.2f",poolVO.totalStorage/1024];
    header.storageUsedSize2.text = [NSString stringWithFormat:@"%.2f",(poolVO.totalStorage - poolVO.availStorage)/1024.0];
    header.storageUnusedSize2.text = [NSString stringWithFormat:@"%.2f",poolVO.availStorage/1024.0];
    
    //圈图
    PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:header.cpuChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:(poolVO.totalCpu - poolVO.availCpu)/poolVO.totalCpu*100] andClockwise:YES andShadow:YES];
    circleChart.backgroundColor = [UIColor clearColor];
    circleChart.strokeColor = [UIColor clearColor];
    circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    circleChart.circle.lineCap = kCALineCapSquare;//直角填充
    circleChart.lineWidth = @11.0f;//线宽度
    [circleChart setStrokeColor:[UIColor colorWithRed:88.0/255 green:206.0/255 blue:96.0/255 alpha:1]];//已使用填充颜色
    [circleChart strokeChart];
    [header.cpuChartGroup addSubview:circleChart];
    
    
    PNCircleChart * circleChart2 = [[PNCircleChart alloc] initWithFrame:header.memoryChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:(poolVO.totalMemory - poolVO.availMemory)/poolVO.totalMemory*100] andClockwise:YES andShadow:YES];
    circleChart2.backgroundColor = [UIColor clearColor];
    circleChart2.strokeColor = [UIColor clearColor];
    circleChart2.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    circleChart2.circle.lineCap = kCALineCapSquare;//直角填充
    circleChart2.lineWidth = @11.0f;//线宽度
    [circleChart2 setStrokeColor:[UIColor colorWithRed:88.0/255 green:206.0/255 blue:96.0/255 alpha:1]];//已使用填充颜色
    [circleChart2 strokeChart];
    [header.memoryChartGroup addSubview:circleChart2];
    
    PNCircleChart * circleChart3 = [[PNCircleChart alloc] initWithFrame:header.storageChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:(poolVO.totalStorage - poolVO.availStorage)/poolVO.totalStorage*100] andClockwise:YES andShadow:YES];
    circleChart3.backgroundColor = [UIColor clearColor];
    circleChart3.strokeColor = [UIColor clearColor];
    circleChart3.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    circleChart3.circle.lineCap = kCALineCapSquare;//直角填充
    circleChart3.lineWidth = @11.0f;//线宽度
    [circleChart3 setStrokeColor:[UIColor colorWithRed:88.0/255 green:206.0/255 blue:96.0/255 alpha:1]];//已使用填充颜色
    [circleChart3 strokeChart];
    [header.storageChartGroup addSubview:circleChart3];
    
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    UIViewController *root = [[UIStoryboard storyboardWithName:@"Pool" bundle:nil] instantiateInitialViewController];
    PoolContainerVC *vc;
    if([root isKindOfClass:[PoolContainerVC class]]){
        vc = (PoolContainerVC*) root;
    }else{
        vc = [[root childViewControllers] firstObject];
    }
    vc.poolVO = (PoolVO *)[self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];
    
    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }
}




@end

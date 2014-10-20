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
    
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    PoolDashboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PoolDashboardCell" forIndexPath:indexPath];
    
    
    PoolVO *poolVO = (PoolVO *) [self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];
    cell.title.text = poolVO.resourcePoolName;
    cell.label1.text = [NSString stringWithFormat:@"%d台", poolVO.hostNumber];
    cell.label2.text = [NSString stringWithFormat:@"%d台", poolVO.activeVmNumber];
    cell.label3.text = [NSString stringWithFormat:@"%.2fGHz", poolVO.totalCpu/1000.0];
    cell.label4.text = [NSString stringWithFormat:@"%.2fGB", poolVO.totalMemory/1024.0];
    cell.label5.text = [NSString stringWithFormat:@"%.2fGB", poolVO.totalStorage];
    
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
    
    header.poolCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.resPoolNumber];
    header.haPoolCount.text = [NSString stringWithFormat:@"%d",0];
    header.elasticCalPoolCount.text = [NSString stringWithFormat:@"%d",0];
    header.cpuUsedCount.text = [NSString stringWithFormat:@"%.2fGHz",20.0];
    header.cpuUnitUnusedCount.text = [NSString stringWithFormat:@"%.2fGHz",20.0];
    header.memeryUsedSize.text = [NSString stringWithFormat:@"%.2fG",10.00];
    header.memoryUnusedSize.text = [NSString stringWithFormat:@"%.2fG",10.00];
    header.storageUsedSize.text = [NSString stringWithFormat:@"%.2fT",1.0];
    header.storageUnusedSize.text = [NSString stringWithFormat:@"%.2fT",1.0];
    
    //缩起
    header.label1.text = [NSString stringWithFormat:@"%d",0];
    header.label2.text = [NSString stringWithFormat:@"%d",0];
    header.label3.text = [NSString stringWithFormat:@"%d",0];
    header.label4.text = [NSString stringWithFormat:@"%d",0];
    header.label5.text = [NSString stringWithFormat:@"%d",0];
    header.label6.text = [NSString stringWithFormat:@"%d",0];
    header.label7.text = [NSString stringWithFormat:@"%.2f",20.00];
    header.label8.text = [NSString stringWithFormat:@"%.2f",10.00];
    header.label9.text = [NSString stringWithFormat:@"%.2f",10.00];
    header.label10.text = [NSString stringWithFormat:@"%.2f",2.0];
    header.label11.text = [NSString stringWithFormat:@"%.2f",1.0];
    header.label12.text = [NSString stringWithFormat:@"%.2f",1.0];
    
    //圈图
    PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:header.cpuChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:50] andClockwise:YES andShadow:YES];
    circleChart.backgroundColor = [UIColor clearColor];
    circleChart.strokeColor = [UIColor clearColor];
    circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    circleChart.circle.lineCap = kCALineCapSquare;//直角填充
    circleChart.lineWidth = @11.0f;//线宽度
    [circleChart setStrokeColor:[UIColor colorWithRed:88.0/255 green:206.0/255 blue:96.0/255 alpha:1]];//已使用填充颜色
    [circleChart strokeChart];
    [header.cpuChartGroup addSubview:circleChart];
    
    
    PNCircleChart * circleChart2 = [[PNCircleChart alloc] initWithFrame:header.memoryChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:50] andClockwise:YES andShadow:YES];
    circleChart2.backgroundColor = [UIColor clearColor];
    circleChart2.strokeColor = [UIColor clearColor];
    circleChart2.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    circleChart2.circle.lineCap = kCALineCapSquare;//直角填充
    circleChart2.lineWidth = @11.0f;//线宽度
    [circleChart setStrokeColor:[UIColor colorWithRed:88.0/255 green:206.0/255 blue:96.0/255 alpha:1]];//已使用填充颜色
    [circleChart2 strokeChart];
    [header.memoryChartGroup addSubview:circleChart2];
    
    PNCircleChart * circleChart3 = [[PNCircleChart alloc] initWithFrame:header.storageChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:50] andClockwise:YES andShadow:YES];
    circleChart3.backgroundColor = [UIColor clearColor];
    circleChart3.strokeColor = [UIColor clearColor];
    circleChart3.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    circleChart3.circle.lineCap = kCALineCapSquare;//直角填充
    circleChart3.lineWidth = @11.0f;//线宽度
    [circleChart setStrokeColor:[UIColor colorWithRed:88.0/255 green:206.0/255 blue:96.0/255 alpha:1]];//已使用填充颜色
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

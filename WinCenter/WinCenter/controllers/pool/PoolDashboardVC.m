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
    
    [[RemoteObject getCurrentDatacenterVO] getDatacenterStatWinserverVOAsync:^(id object, NSError *error) {
        self.datacenterStatWinserver = object;
        
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
        }];
        
        [[RemoteObject getCurrentDatacenterVO] getPoolSubVOAsync:^(id object, NSError *error) {
            self.poolStatWinserver = object;
            
            [[RemoteObject getCurrentDatacenterVO] getPoolListAsync:^(id object, NSError *error) {
                NSUInteger recordTotal = ((PoolListResult*)object).resourcePools.count;
                
                [[RemoteObject getCurrentDatacenterVO] getPoolListAsync:^(id object, NSError *error) {
                    [self.dataList addObjectsFromArray:((PoolListResult*)object).resourcePools];
                    [self.collectionView headerEndRefreshing];
                    if(self.dataList.count >= recordTotal){
                        [self.collectionView footerFinishingLoading];
                    }else{
                        [self.collectionView footerEndRefreshing];
                    }
                    [self.collectionView reloadData];
                } referTo:self.dataList];
                
            }];
        }];
    }];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    PoolDashboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PoolDashboardCell" forIndexPath:indexPath];
    
    
    PoolVO *poolVO = (PoolVO *) self.dataList[indexPath.row];
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
    header.name.title =  [RemoteObject getCurrentDatacenterVO].name;
    header.poolCount.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.resPoolNumber];
    header.haPoolCount.text = [NSString stringWithFormat:@"%d",self.poolStatWinserver.ha_num];
    header.elasticCalPoolCount.text = [NSString stringWithFormat:@"%d",self.poolStatWinserver.plan_num];
    header.cpuUsedCount.text = [NSString stringWithFormat:@"%.2fGHz",(self.datacenterStatWinserver.totalCpu - self.datacenterStatWinserver.availCpu)/1024.0];
    header.cpuUnitUnusedCount.text = [NSString stringWithFormat:@"%.2fGHz",self.datacenterStatWinserver.availCpu/1024];
    header.memeryUsedSize.text = [NSString stringWithFormat:@"%.2fG",(self.datacenterStatWinserver.totalMemory - self.datacenterStatWinserver.availMemory)/1024.0];
    header.memoryUnusedSize.text = [NSString stringWithFormat:@"%.2fG",self.datacenterStatWinserver.availMemory/1024];
    header.storageUsedSize.text = [NSString stringWithFormat:@"%.2fT",(self.datacenterStatWinserver.totalStorage - self.datacenterStatWinserver.availStorage)/1024.0];
    header.storageUnusedSize.text = [NSString stringWithFormat:@"%.2fT",self.datacenterStatWinserver.availStorage/1024.0];

    //缩起
    header.poolCount2.text = [NSString stringWithFormat:@"%d",self.datacenterStatWinserver.resPoolNumber];
    header.haPoolCount2.text = [NSString stringWithFormat:@"%d",self.poolStatWinserver.ha_num];
    header.elasticCalPoolCount2.text = [NSString stringWithFormat:@"%d",self.poolStatWinserver.plan_num];
    header.cpuUnitCount2.text = [NSString stringWithFormat:@"%.2f",self.datacenterStatWinserver.totalCpu/1024];
    header.cpuUsedCount2.text = [NSString stringWithFormat:@"%.2f",(self.datacenterStatWinserver.totalCpu - self.datacenterStatWinserver.availCpu)/1024.0];
    header.cpuUnitUnusedCount2.text = [NSString stringWithFormat:@"%.2f",self.datacenterStatWinserver.availCpu/1024];
    header.memerySize2.text = [NSString stringWithFormat:@"%.2f",self.datacenterStatWinserver.totalMemory/1024.0];
    header.memeryUsedSize2.text = [NSString stringWithFormat:@"%.2f",(self.datacenterStatWinserver.totalMemory - self.datacenterStatWinserver.availMemory)/1024.0];
    header.memoryUnusedSize2.text = [NSString stringWithFormat:@"%.2f",self.datacenterStatWinserver.availMemory/1024.0];
    header.storageSize2.text = [NSString stringWithFormat:@"%.2f",self.datacenterStatWinserver.totalStorage/1024];
    header.storageUsedSize2.text = [NSString stringWithFormat:@"%.2f",(self.datacenterStatWinserver.totalStorage - self.datacenterStatWinserver.availStorage)/1024.0];
    header.storageUnusedSize2.text = [NSString stringWithFormat:@"%.2f",self.datacenterStatWinserver.availStorage/1024.0];
    
    //圈图
    for(UIView *subView in header.cpuChartGroup.subviews){
        [subView removeFromSuperview];
    }
    PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:header.cpuChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:(self.datacenterStatWinserver.totalCpu - self.datacenterStatWinserver.availCpu)/self.datacenterStatWinserver.totalCpu*100] andClockwise:YES andShadow:YES];
    circleChart.backgroundColor = [UIColor clearColor];
    circleChart.strokeColor = [UIColor clearColor];
    circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    circleChart.circle.lineCap = kCALineCapSquare;//直角填充
    circleChart.lineWidth = @11.0f;//线宽度
    [circleChart setStrokeColor:[UIColor colorWithRed:88.0/255 green:206.0/255 blue:96.0/255 alpha:1]];//已使用填充颜色
    [circleChart strokeChart];
    [header.cpuChartGroup addSubview:circleChart];
    
    
    for(UIView *subView in header.memoryChartGroup.subviews){
        [subView removeFromSuperview];
    }
    PNCircleChart * circleChart2 = [[PNCircleChart alloc] initWithFrame:header.memoryChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:(self.datacenterStatWinserver.totalMemory - self.datacenterStatWinserver.availMemory)/self.datacenterStatWinserver.totalMemory*100] andClockwise:YES andShadow:YES];
    circleChart2.backgroundColor = [UIColor clearColor];
    circleChart2.strokeColor = [UIColor clearColor];
    circleChart2.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    circleChart2.circle.lineCap = kCALineCapSquare;//直角填充
    circleChart2.lineWidth = @11.0f;//线宽度
    [circleChart2 setStrokeColor:[UIColor colorWithRed:88.0/255 green:206.0/255 blue:96.0/255 alpha:1]];//已使用填充颜色
    [circleChart2 strokeChart];
    [header.memoryChartGroup addSubview:circleChart2];
    
    for(UIView *subView in header.storageChartGroup.subviews){
        [subView removeFromSuperview];
    }
    PNCircleChart * circleChart3 = [[PNCircleChart alloc] initWithFrame:header.storageChartGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:(self.datacenterStatWinserver.totalStorage - self.datacenterStatWinserver.availStorage)/self.datacenterStatWinserver.totalStorage*100] andClockwise:YES andShadow:YES];
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
    vc.poolVO = (PoolVO *) self.dataList[indexPath.row];
    
    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }
}




@end

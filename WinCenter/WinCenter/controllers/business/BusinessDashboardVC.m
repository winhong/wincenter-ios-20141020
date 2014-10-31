//
//  PoolCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "BusinessDashboardVC.h"
#import "BusinessContainerVC.h"
#import "BusinessDashboardCell.h"
#import "BusinessDashboardHeader.h"

@interface BusinessDashboardVC ()

@property NSArray *allBusList;
@property NSArray *unalloctedBusList;
@property NSArray *allBusDomainsList;

@end


@implementation BusinessDashboardVC



-(void)reloadData{
    [[RemoteObject getCurrentDatacenterVO] getBusinessListAsync:^(NSArray *allRemote, NSError *error) {
        [self.dataList setValue:allRemote forKey:[RemoteObject getCurrentDatacenterVO].name];
        [[RemoteObject getCurrentDatacenterVO] getBusinessAllAsync:^(NSArray *allRemote, NSError *error) {
            self.allBusList = allRemote;
            
            [[RemoteObject getCurrentDatacenterVO] getBusinessUnallocatedAsync:^(NSArray *allRemote, NSError *error) {
                self.unalloctedBusList = allRemote;
                [self.collectionView headerEndRefreshing];
                [self.collectionView footerEndRefreshing];
                [self.collectionView reloadData];
            }];
        }];
    }];
    
    [[RemoteObject getCurrentDatacenterVO] getBusDomainsListAsync:^(NSArray *allRemote, NSError *error) {
        self.allBusDomainsList = allRemote;
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
        [self.collectionView reloadData];
    }];

    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BusinessDashboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BusinessDashboardCell" forIndexPath:indexPath];
    
    BusinessVO *businessVO = (BusinessVO *) [self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];
    cell.title.text = businessVO.name;
    cell.manager.text = businessVO.managerId;
    cell.createTime.text = [businessVO.createTime stringByReplacingOccurrencesOfString:@" 000" withString:@""];
    cell.vmNum.text = [NSString stringWithFormat:@"%d", businessVO.vmNum];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    BusinessDashboardHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BusinessDashboardHeader" forIndexPath:indexPath];
    
    header.name.title = [RemoteObject getCurrentDatacenterVO].name;
    header.businessCount.text =[NSString stringWithFormat:@"%ld",self.allBusList.count];
    header.busDomainsCount.text = [NSString stringWithFormat:@"%ld",self.allBusDomainsList.count];
    header.alloctedBus.text =[NSString stringWithFormat:@"%ld",self.allBusList.count - self.unalloctedBusList.count];
    header.unalloctedBus.text =[NSString stringWithFormat:@"%ld",self.unalloctedBusList.count];
    
    //缩起
    header.businessCount2.text =[NSString stringWithFormat:@"%ld",self.allBusList.count];
//    header.busDomainsCount2.text =[NSString stringWithFormat:@"%ld",allBusDomainsList.count];
    header.alloctedBus2.text =[NSString stringWithFormat:@"%ld",self.allBusList.count - self.unalloctedBusList.count];
    header.unalloctedBus2.text =[NSString stringWithFormat:@"%ld",self.unalloctedBusList.count];
    
    //圈图
    PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:header.businessAllocateChart.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:self.unalloctedBusList.count*100/self.allBusList.count] andClockwise:YES andShadow:YES];
    circleChart.backgroundColor = [UIColor clearColor];
    circleChart.strokeColor = [UIColor clearColor];
    circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    circleChart.circle.lineCap = kCALineCapSquare;//直角填充
    circleChart.lineWidth = @11.0f;//线宽度
    [circleChart setStrokeColor:[UIColor colorWithRed:0.0/255 green:181.0/255 blue:185.0/255 alpha:1]];//已使用填充颜色
    [circleChart strokeChart];
    [header.businessAllocateChart addSubview:circleChart];
    
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *root = [[UIStoryboard storyboardWithName:@"Business" bundle:nil] instantiateInitialViewController];
    BusinessContainerVC *vc;
    if([root isKindOfClass:[BusinessContainerVC class]]){
        vc = (BusinessContainerVC*) root;
    }else{
        vc = [[root childViewControllers] firstObject];
    }
    vc.businessVO = (BusinessVO *)[self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];

    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }
}

@end

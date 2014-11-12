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
@property int allBusDomainsList;

@end


@implementation BusinessDashboardVC



-(void)reloadData{
    [[RemoteObject getCurrentDatacenterVO] getDatacenterVOAsync:^(id object, NSError *error) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            if(!self.navigationItem.leftBarButtonItem){
                self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
            }
            self.navigationItem.leftBarButtonItem.title = ((DatacenterVO *)object).name;
        }
    
        [[RemoteObject getCurrentDatacenterVO] getDatacenterStatWinserverVOAsync:^(id object, NSError *error) {
        
            [[RemoteObject getCurrentDatacenterVO] getBusDomainsListAsync:^(id object, NSError *error) {
                
                self.allBusDomainsList = ((BusDomainsListResult*)object).recordTotal;
            
                [[RemoteObject getCurrentDatacenterVO] getBusinessListAsync:^(id object, NSError *error) {
                    self.allBusList = ((BusinessListResult*)object).resultList;
                    
                    [[RemoteObject getCurrentDatacenterVO] getBusinessUnallocatedAsync:^(id object, NSError *error) {
                        self.unalloctedBusList = ((BusinessListResult*)object).resultList;
                        
                        if(self.busDomainVO){
                            //陈洁补充：根据业务域查询业务系统
                            NSMutableArray *alloctedBusList = [NSMutableArray new];
                            for (BusinessVO *busVO in self.allBusList){
                                if (busVO.busDomainId == self.busDomainVO.busDomainId) {
                                    [alloctedBusList addObject:busVO];
                                }
                            }
                            [self.dataList addObjectsFromArray:alloctedBusList];
                            [self.collectionView headerEndRefreshing];
                            [self.collectionView footerEndRefreshing];
                            [self.collectionView reloadData];
                            self.navigationItem.rightBarButtonItem.enabled = true;
                        }else if(self.isUnGroup){
                            //陈洁补充：查询未分配的业务系统
                            [self.dataList addObjectsFromArray:((BusinessListResult*)object).resultList];
                            [self.collectionView headerEndRefreshing];
                            [self.collectionView footerEndRefreshing];
                            [self.collectionView reloadData];
                            self.navigationItem.rightBarButtonItem.enabled = true;
                        }else{
                            [[RemoteObject getCurrentDatacenterVO] getBusinessListAsync:^(id object, NSError *error) {
                                [self.dataList addObjectsFromArray:((BusinessListResult*)object).resultList];
                                [self.collectionView headerEndRefreshing];
                                if(self.dataList.count >= ((BusinessListResult*)object).recordTotal){
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
        }];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BusinessDashboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BusinessDashboardCell" forIndexPath:indexPath];
    
    if(self.dataList.count==0) return cell;
    
    BusinessVO *businessVO = (BusinessVO *) self.dataList[indexPath.row];
    cell.title.text = businessVO.name;
    cell.manager.text = businessVO.managerId;
    cell.createTime.text = [businessVO.createTime stringByReplacingOccurrencesOfString:@" 000" withString:@""];
    cell.vmNum.text = [NSString stringWithFormat:@"%d", businessVO.vmNum];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    BusinessDashboardHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BusinessDashboardHeader" forIndexPath:indexPath];
    
    header.businessCount.text =[NSString stringWithFormat:@"%ld",self.allBusList.count];
    header.busDomainsCount.text = [NSString stringWithFormat:@"%d",self.allBusDomainsList];
    header.alloctedBus.text =[NSString stringWithFormat:@"%ld",self.allBusList.count - self.unalloctedBusList.count];
    header.unalloctedBus.text =[NSString stringWithFormat:@"%ld",self.unalloctedBusList.count];
    
    //缩起
    header.businessCount2.text =[NSString stringWithFormat:@"%ld",self.allBusList.count];
//    header.busDomainsCount2.text =[NSString stringWithFormat:@"%d",allBusDomainsList];
    header.alloctedBus2.text =[NSString stringWithFormat:@"%ld",self.allBusList.count - self.unalloctedBusList.count];
    header.unalloctedBus2.text =[NSString stringWithFormat:@"%ld",self.unalloctedBusList.count];
    
    //圈图
    for(UIView *subView in header.businessAllocateChart.subviews){
        [subView removeFromSuperview];
    }
    PNCircleChart * circleChart;
    if(self.allBusList.count==0){
        circleChart = [[PNCircleChart alloc] initWithFrame:header.businessAllocateChart.bounds andTotal:@100 andCurrent:0 andClockwise:YES andShadow:YES];
    }else{
        circleChart = [[PNCircleChart alloc] initWithFrame:header.businessAllocateChart.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:self.unalloctedBusList.count*100/self.allBusList.count] andClockwise:YES andShadow:YES];
    }
    circleChart.backgroundColor = [UIColor clearColor];
    circleChart.strokeColor = [UIColor clearColor];
    if (self.allBusList.count == 0) {
        circleChart.circleBG.strokeColor = [UIColor colorWithRed:230.0/255 green:230.0/255 blue:230.0/255 alpha:1].CGColor;
    }else{
        circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
    }
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
    vc.businessVO = (BusinessVO *)self.dataList[indexPath.row];

    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }
}

@end

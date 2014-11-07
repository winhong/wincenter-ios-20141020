//
//  PoolCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "StorageDashboardVC.h"
#import "StorageContainerVC.h"
#import "StorageDashboardCell.h"
#import "StorageDashboardHeader.h"

@interface StorageDashboardVC ()

@property DatacenterStatWinserver *datacenterStatWinserver;
@property StorageSubVO *StorageSubVOWinserver;

@end

@implementation StorageDashboardVC

-(void)reloadData{
    [[RemoteObject getCurrentDatacenterVO] getDatacenterStatWinserverVOAsync:^(id object, NSError *error) {
        self.datacenterStatWinserver = object;
        [[RemoteObject getCurrentDatacenterVO] getStorageSubVOAsync:^(id object, NSError *error) {
            self.StorageSubVOWinserver = object;
            
            if(self.poolVO){
                [self.poolVO getStorageListAsync:^(id object, NSError *error) {
                    [self.dataList addObjectsFromArray:((StorageListResult*)object).resultList];
                    [self.collectionView headerEndRefreshing];
                    if(self.dataList.count >= ((StorageListResult*)object).recordTotal){
                        [self.collectionView footerFinishingLoading];
                    }else{
                        [self.collectionView footerEndRefreshing];
                    }
                    [self.collectionView reloadData];
                } referTo:self.dataList];
            }else if(self.isOutofPool){
                //游离物理主机
                [[RemoteObject getCurrentDatacenterVO] getStorageListAsync:^(id object, NSError *error) {
                    NSMutableArray *storageOfPoolList = [NSMutableArray new];
                    for (StorageVO *storage in ((StorageListResult*)object).resultList) {
                        if (!(storage.resourcePoolId)) {
                            [storageOfPoolList addObject: storage];
                        }
                    }
                    [self.dataList addObjectsFromArray:storageOfPoolList];
                    
                    [self.collectionView headerEndRefreshing];
                    [self.collectionView footerFinishingLoading];
                    [self.collectionView reloadData];
                }];
            }else{
                [[RemoteObject getCurrentDatacenterVO] getStorageListAsync:^(id object, NSError *error) {
                    [self.dataList addObjectsFromArray:((StorageListResult*)object).resultList];
                    [self.collectionView headerEndRefreshing];
                    if(self.dataList.count >= ((StorageListResult*)object).recordTotal){
                        [self.collectionView footerFinishingLoading];
                    }else{
                        [self.collectionView footerEndRefreshing];
                    }
                    [self.collectionView reloadData];
                } referTo:self.dataList];
            }
        }];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StorageDashboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StorageDashboardCell" forIndexPath:indexPath];
    
    if(self.dataList.count==0) return cell;
    
    StorageVO *storageVO = (StorageVO *) self.dataList[indexPath.row];
    cell.title.text = storageVO.storagePoolName;
    cell.availStorage.text = [NSString stringWithFormat:@"%.2f%@剩余,共%.2f%@", [storageVO availStorage_value],[storageVO availStorage_unit],[storageVO totalStorage_value],[storageVO totalStorage_unit]];
    cell.volumeNum.text = [NSString stringWithFormat:@"%d个", storageVO.volumeNum];
    cell.location.text = [NSString stringWithFormat:@"%@", storageVO.location];
    cell.underPool.text = storageVO.resourcePoolName;
    cell.status.text = [storageVO state_text];
    cell.status.textColor = [storageVO state_color];
    cell.status_image.layer.cornerRadius = 6;
    cell.status_image.backgroundColor = [storageVO state_color];
    cell.share_image.hidden = [storageVO.shared isEqualToString:@"false"];
    cell.progress.progress = (storageVO.totalStorage-storageVO.availStorage)/storageVO.totalStorage;
    if(cell.progress.progress>0.8){
        cell.progress.progressTintColor = PNRed;
    }else if(cell.progress.progress>0.6){
        cell.progress.progressTintColor = PNYellow;
    }else{
        cell.progress.progressTintColor = PNGreen;
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    StorageDashboardHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"StorageDashboardHeader" forIndexPath:indexPath];
    
    header.name.title = [RemoteObject getCurrentDatacenterVO].name;
    header.shareStorageSize.text = [NSString stringWithFormat:@"%.2f%@",[self.StorageSubVOWinserver.total shareStorage_value],[self.StorageSubVOWinserver.total shareStorage_unit]];
    header.localStorageSize.text = [NSString stringWithFormat:@"%.2f%@",[self.StorageSubVOWinserver.total localStorage_value],[self.StorageSubVOWinserver.total localStorage_unit]];
    header.storageSize2.text = [NSString stringWithFormat:@"%.2f%@",[self.StorageSubVOWinserver.total totalStorage_value],[self.StorageSubVOWinserver.total totalStorage_unit]];
    header.storageSize4.text = [NSString stringWithFormat:@"%.2f%@",[self.StorageSubVOWinserver.total totalStorage_value],[self.StorageSubVOWinserver.total totalStorage_unit]];
    header.unUsedStorageSize.text = [NSString stringWithFormat:@"%.2f%@",[self.StorageSubVOWinserver.capacity availStorage_value],[self.StorageSubVOWinserver.capacity availStorage_unit]];
    header.usedStorageSize.text = [NSString stringWithFormat:@"%.2f%@",[self.StorageSubVOWinserver.capacity usedStorage_value],[self.StorageSubVOWinserver.capacity usedStorage_unit]];
    
    header.fcSanStorageSize.text = [NSString stringWithFormat:@"%d",self.StorageSubVOWinserver.type.lvmohba];
    header.iscsiStorageSize.text = [NSString stringWithFormat:@"%d",self.StorageSubVOWinserver.type.lvmoiscsi];
    header.nfsStorageSize.text = [NSString stringWithFormat:@"%d",self.StorageSubVOWinserver.type.nfs];
    header.localStorageSize2.text = [NSString stringWithFormat:@"%d",self.StorageSubVOWinserver.type.lvm];
    
    //缩起
    header.fcSanStorageSize2.text = [NSString stringWithFormat:@"%d个",self.StorageSubVOWinserver.type.lvmohba];
    header.iscsiStorageSize2.text = [NSString stringWithFormat:@"%d个",self.StorageSubVOWinserver.type.lvmoiscsi];
    header.nfsStorageSize2.text = [NSString stringWithFormat:@"%d个",self.StorageSubVOWinserver.type.nfs];
    header.localStorageSize3.text = [NSString stringWithFormat:@"%d个",self.StorageSubVOWinserver.type.lvm];
    
    header.storageSize3.text = [NSString stringWithFormat:@"%.2f%@",[self.StorageSubVOWinserver.total totalStorage_value],[self.StorageSubVOWinserver.total totalStorage_unit]];
    header.shareStorageSize2.text = [NSString stringWithFormat:@"%.2f%@",[self.StorageSubVOWinserver.total shareStorage_value],[self.StorageSubVOWinserver.total shareStorage_unit]];
    header.localStorageSize4.text = [NSString stringWithFormat:@"%.2f%@",[self.StorageSubVOWinserver.total localStorage_value],[self.StorageSubVOWinserver.total localStorage_unit]];
    header.unUsedStorageSize2.text = [NSString stringWithFormat:@"%.2f%@",[self.StorageSubVOWinserver.capacity availStorage_value],[self.StorageSubVOWinserver.capacity availStorage_unit]];
    header.usedStorageSize2.text = [NSString stringWithFormat:@"%.2f%@",[self.StorageSubVOWinserver.capacity usedStorage_value],[self.StorageSubVOWinserver.capacity usedStorage_unit]];
    
    //圈图
    for(UIView *subView in header.storageShareChart.subviews){
        [subView removeFromSuperview];
    }
    PNCircleChart * circleChart;
    if ((self.StorageSubVOWinserver.total.true_field + self.StorageSubVOWinserver.total.false_field) == 0) {
        circleChart = [[PNCircleChart alloc] initWithFrame:header.storageShareChart.bounds andTotal:@100 andCurrent:0 andClockwise:YES andShadow:YES];
    }else{
        circleChart = [[PNCircleChart alloc] initWithFrame:header.storageShareChart.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:self.StorageSubVOWinserver.total.false_field*100/(self.StorageSubVOWinserver.total.true_field + self.StorageSubVOWinserver.total.false_field)] andClockwise:YES andShadow:YES];
    }
    
        circleChart.backgroundColor = [UIColor clearColor];
        circleChart.strokeColor = [UIColor clearColor];
        circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
        circleChart.circle.lineCap = kCALineCapSquare;//直角填充
        circleChart.lineWidth = @11.0f;//线宽度
        [circleChart setStrokeColor:[UIColor colorWithRed:248.0/255 green:123.0/255 blue:56.0/255 alpha:1]];//已使用填充颜色
        [circleChart strokeChart];
        [header.storageShareChart addSubview:circleChart];
    
    for(UIView *subView in header.storageUseChart.subviews){
        [subView removeFromSuperview];
    }
    
    PNCircleChart * circleChart2;
    if ((self.StorageSubVOWinserver.total.true_field + self.StorageSubVOWinserver.total.false_field) == 0) {
        circleChart2 = [[PNCircleChart alloc] initWithFrame:header.storageUseChart.bounds andTotal:@100 andCurrent:0 andClockwise:YES andShadow:YES];
    }else{
        circleChart2 = [[PNCircleChart alloc] initWithFrame:header.storageUseChart.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:self.StorageSubVOWinserver.capacity.usedStorage*100/(self.StorageSubVOWinserver.total.true_field + self.StorageSubVOWinserver.total.false_field)] andClockwise:YES andShadow:YES];
    }
        circleChart2.backgroundColor = [UIColor clearColor];
        circleChart2.strokeColor = [UIColor clearColor];
        circleChart2.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
        circleChart2.circle.lineCap = kCALineCapSquare;//直角填充
        circleChart2.lineWidth = @11.0f;//线宽度
        [circleChart2 setStrokeColor:[UIColor colorWithRed:248.0/255 green:123.0/255 blue:56.0/255 alpha:1]];//已使用填充颜色
        [circleChart2 strokeChart];
        [header.storageUseChart addSubview:circleChart2];
    
    
    
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *root = [[UIStoryboard storyboardWithName:@"Storage" bundle:nil] instantiateInitialViewController];
    StorageContainerVC *vc;
    if([root isKindOfClass:[StorageContainerVC class]]){
        vc = (StorageContainerVC*) root;
    }else{
        vc = [[root childViewControllers] firstObject];
    }
    vc.storageVO = (StorageVO *)self.dataList[indexPath.row];

    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }
}

@end

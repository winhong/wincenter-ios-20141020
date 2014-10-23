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
    [[RemoteObject getCurrentDatacenterVO] getStorageListAsync:^(NSArray *allRemote, NSError *error) {
        [self.dataList setValue:allRemote forKey:[RemoteObject getCurrentDatacenterVO].name];
        [[RemoteObject getCurrentDatacenterVO] getDatacenterStatWinserverVOAsync:^(id object, NSError *error) {
            self.datacenterStatWinserver = object;
            [[RemoteObject getCurrentDatacenterVO] getStorageSubVOAsync:^(id object, NSError *error) {
                self.StorageSubVOWinserver = object;
                [self.collectionView reloadData];
            }];
        }];
        
    }];
    
    
    
    
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StorageDashboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StorageDashboardCell" forIndexPath:indexPath];
    
    StorageVO *storageVO = (StorageVO *) [self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];
    cell.title.text = storageVO.storagePoolName;
    cell.availStorage.text = [NSString stringWithFormat:@"%.2fGB剩余,共%.2fGB", storageVO.availStorage, storageVO.totalStorage];
    cell.volumeNum.text = [NSString stringWithFormat:@"%d个", storageVO.volumeNum];
    cell.location.text = [NSString stringWithFormat:@"%@", storageVO.location];
    cell.status.text = [storageVO state_text];
    cell.status.textColor = [storageVO state_color];
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
    
    header.shareStorageSize.text = [NSString stringWithFormat:@"%.2fG",self.StorageSubVOWinserver.total.true_field];
    header.localStorageSize.text = [NSString stringWithFormat:@"%.2fG",self.StorageSubVOWinserver.total.false_field];
    header.storageSize2.text = [NSString stringWithFormat:@"%.2fG",(self.StorageSubVOWinserver.total.true_field + self.StorageSubVOWinserver.total.false_field)];
    header.unUsedStorageSize.text = [NSString stringWithFormat:@"%.2fG",self.StorageSubVOWinserver.capacity.availStorage];
    header.usedStorageSize.text = [NSString stringWithFormat:@"%.2fG",self.StorageSubVOWinserver.capacity.usedStorage];
    header.fcSanStorageSize.text = [NSString stringWithFormat:@"%.2f",self.StorageSubVOWinserver.type.lvmohba];
    header.iscsiStorageSize.text = [NSString stringWithFormat:@"%.2f",self.StorageSubVOWinserver.type.lvmoiscsi];
    header.nfsStorageSize.text = [NSString stringWithFormat:@"%.2f",self.StorageSubVOWinserver.type.nfs];
    header.localStorageSize2.text = [NSString stringWithFormat:@"%.2f",self.StorageSubVOWinserver.type.lvm];
    
    //缩起
    header.fcSanStorageSize2.text = [NSString stringWithFormat:@"%.2fG",self.StorageSubVOWinserver.type.lvmohba];
    header.iscsiStorageSize2.text = [NSString stringWithFormat:@"%.2fG",self.StorageSubVOWinserver.type.lvmoiscsi];
    header.nfsStorageSize2.text = [NSString stringWithFormat:@"%.2fG",self.StorageSubVOWinserver.type.nfs];
    header.localStorageSize3.text = [NSString stringWithFormat:@"%.2fG",self.StorageSubVOWinserver.type.lvm];
    header.storageSize3.text = [NSString stringWithFormat:@"%.2fG",(self.StorageSubVOWinserver.total.true_field + self.StorageSubVOWinserver.total.false_field)];
    header.shareStorageSize2.text = [NSString stringWithFormat:@"%.2fG",self.StorageSubVOWinserver.total.true_field];
    header.localStorageSize4.text = [NSString stringWithFormat:@"%.2fG",self.StorageSubVOWinserver.total.false_field];
    header.unUsedStorageSize2.text = [NSString stringWithFormat:@"%.2fG",self.StorageSubVOWinserver.capacity.availStorage];
    header.usedStorageSize2.text = [NSString stringWithFormat:@"%.2fG",self.StorageSubVOWinserver.capacity.usedStorage];
    
    //圈图
        PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:header.storageShareChart.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:self.StorageSubVOWinserver.total.false_field*100/(self.StorageSubVOWinserver.total.true_field + self.StorageSubVOWinserver.total.false_field)] andClockwise:YES andShadow:YES];
        circleChart.backgroundColor = [UIColor clearColor];
        circleChart.strokeColor = [UIColor clearColor];
        circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;//未使用填充颜色
        circleChart.circle.lineCap = kCALineCapSquare;//直角填充
        circleChart.lineWidth = @11.0f;//线宽度
        [circleChart setStrokeColor:[UIColor colorWithRed:248.0/255 green:123.0/255 blue:56.0/255 alpha:1]];//已使用填充颜色
        [circleChart strokeChart];
        [header.storageShareChart addSubview:circleChart];
        
        PNCircleChart * circleChart2 = [[PNCircleChart alloc] initWithFrame:header.storageUseChart.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:self.StorageSubVOWinserver.capacity.usedStorage*100/(self.StorageSubVOWinserver.total.true_field + self.StorageSubVOWinserver.total.false_field)] andClockwise:YES andShadow:YES];
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
    vc.storageVO = (StorageVO *)[self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];

    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }
}

@end

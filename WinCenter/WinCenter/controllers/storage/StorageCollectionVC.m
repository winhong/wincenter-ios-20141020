//
//  PoolStorageCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "StorageCollectionVC.h"
#import "StorageCollectionCell.h"
#import "StorageContainerVC.h"

@implementation StorageCollectionVC

-(void)reloadData{
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
    }else{
        [self.hostVO getStorageListAsync:^(id object, NSError *error) {
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
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StorageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StorageCollectionCell" forIndexPath:indexPath];
    
    StorageVO *storageVO = (StorageVO *) self.dataList[indexPath.row];
    cell.title.text = storageVO.storagePoolName;
    cell.label1.text = storageVO.type;
    cell.label2.text = storageVO.location;
    cell.label3.text = [NSString stringWithFormat:@"%d个", storageVO.volumeNum];
    cell.label4.text = [NSString stringWithFormat:@"%.2fGB剩余,共%.2fGB", storageVO.availStorage, storageVO.totalStorage];
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *root= [[UIStoryboard storyboardWithName:@"Storage" bundle:nil] instantiateInitialViewController];
    StorageContainerVC *vc;
    if([root isKindOfClass:[StorageContainerVC class]]){
        vc = (StorageContainerVC*) root;
    }else{
        vc = [[root childViewControllers] firstObject];
    }
    vc.storageVO = (StorageVO *) self.dataList[indexPath.row];
    if(self.isDetailPagePushed){
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self presentViewController:root animated:YES completion:nil];
    }}


@end

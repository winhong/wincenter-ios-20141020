//
//  HostNetworkCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "HostNetworkCollectionVC.h"
#import "HostNetworkCollectionCell.h"

@implementation HostNetworkCollectionVC

-(void)reloadData{
    [self.hostVO getHostNetworkListAsync:^(id object, NSError *error) {
        [self.dataList addObjectsFromArray:((HostNetworkListResult*)object).networks];
        [self.collectionView headerEndRefreshing];
        if(self.dataList.count >= ((HostNicListResult*)object).recordTotal){
            [self.collectionView footerFinishingLoading];
        }else{
            [self.collectionView footerEndRefreshing];
        }
        [self.collectionView reloadData];
        self.parentViewController.parentViewController.navigationItem.rightBarButtonItem.enabled = true;
    } withType:self.isExternal referTo:self.dataList];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HostNetworkCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HostNetworkCollectionCell" forIndexPath:indexPath];
    
    if(self.dataList.count==0) return cell;
    
    HostNetworkVO *hostNetworkVO = (HostNetworkVO *) self.dataList[indexPath.row];
    cell.title.text = hostNetworkVO.name;
    
    cell.label2.text = @"";
    cell.label3.text = @"";
    cell.label4.text = @"";
    if (hostNetworkVO.vlanId && ![hostNetworkVO.vlanId isEqualToString:@"-1"]) {
        cell.label5.text = hostNetworkVO.vlanId;
    }else{
        cell.label5.text = @"无";
    }
    if (hostNetworkVO.pniName && ![hostNetworkVO.pniName isEqualToString:@""]) {
        cell.label6.text = hostNetworkVO.pniName;
    }else{
        cell.label6.text = @"无";
    }
    
    
    cell.status.text = [hostNetworkVO state_text];
    cell.status.textColor = [hostNetworkVO state_color];
    cell.linkState.image = [UIImage imageNamed:[hostNetworkVO linkState_image]];
    if(indexPath.section==0){
        cell.type_image.image = [UIImage imageNamed:@"Network_internal"];
    }else{
        cell.type_image.image = [UIImage imageNamed:@"Network_External"];
    }
    if (indexPath.row % 2 == 1) {
        cell.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}


@end

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
    [self.hostVO getHostNetworkExternalListAsync:^(NSArray *allRemote, NSError *error) {
        [self.dataList setValue:allRemote forKey:@"外部网络"];
        [self.hostVO getHostNetworkInternalListAsync:^(NSArray *allRemote, NSError *error) {
            [self.dataList setValue:allRemote forKey:@"内部网络"];
            [self.collectionView reloadData];
        }];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HostNetworkCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HostNetworkCollectionCell" forIndexPath:indexPath];
    
    HostNetworkVO *hostNetworkVO = (HostNetworkVO *) [self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];
    cell.title.text = hostNetworkVO.name;
    
    cell.label2.text = @"";
    cell.label3.text = @"";
    cell.label4.text = @"";
    cell.label5.text = hostNetworkVO.vlanId;
    cell.label6.text = hostNetworkVO.pniName;
    cell.status.text = [hostNetworkVO state_text];
    cell.linkState.image = [UIImage imageNamed:[hostNetworkVO linkState_image]];
    if(indexPath.section==0){
        cell.type_image.image = [UIImage imageNamed:@"Network_internal"];
    }else{
        cell.type_image.image = [UIImage imageNamed:@"Network_External"];
    }
    if (indexPath.row % 2 == 1) {
        cell.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}


@end

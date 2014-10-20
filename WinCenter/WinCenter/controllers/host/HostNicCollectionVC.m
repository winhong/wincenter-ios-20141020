//
//  HostNicCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "HostNicCollectionVC.h"
#import "HostNicCollectionCell.h"

@implementation HostNicCollectionVC

-(void)reloadData{
    [self.hostVO getHostNicUngroupedListAsync:^(NSArray *allRemote, NSError *error) {
        [self.dataList setValue:allRemote forKey:@"非聚合网卡"];
        [self.hostVO getHostNicGroupedListAsync:^(NSArray *allRemote, NSError *error) {
            [self.dataList setValue:allRemote forKey:@"聚合网卡"];
            [self.collectionView reloadData];
        }];
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HostNicCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HostNicCollectionCell" forIndexPath:indexPath];

    HostNicVO *hostNicVO = (HostNicVO *) [self.dataList valueForKey:self.dataList.allKeys[indexPath.section]][indexPath.row];
    cell.title.text = hostNicVO.name;
    cell.label1.text = hostNicVO.macAddress;
    cell.label2.text = [NSString stringWithFormat:@"%dMbit/s", hostNicVO.speed];
    cell.label3.text = [NSString stringWithFormat:@"%dByte",hostNicVO.mtu];
    cell.label4.text = hostNicVO.vendor;
    cell.label5.text = hostNicVO.device;
    cell.type.text = [hostNicVO duplex_text];
    cell.linkState.image = [UIImage imageNamed:[hostNicVO linkState_image]];
    if (indexPath.row % 2 == 1) {
        cell.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
    //连接状态 linkeState
    return cell;
}

@end

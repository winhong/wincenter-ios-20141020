//
//  DatacenterDetailCollectionHeader.h
//  WinCenter-iPad
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StorageDashboardHeader : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *storageSize4;
@property (weak, nonatomic) IBOutlet UILabel *shareStorageSize;
@property (weak, nonatomic) IBOutlet UILabel *localStorageSize;
@property (weak, nonatomic) IBOutlet UILabel *storageSize2;
@property (weak, nonatomic) IBOutlet UILabel *unUsedStorageSize;
@property (weak, nonatomic) IBOutlet UILabel *usedStorageSize;

@property (weak, nonatomic) IBOutlet UILabel *fcSanStorageSize;
@property (weak, nonatomic) IBOutlet UILabel *iscsiStorageSize;
@property (weak, nonatomic) IBOutlet UILabel *nfsStorageSize;
@property (weak, nonatomic) IBOutlet UILabel *localStorageSize2;

@property (weak, nonatomic) IBOutlet UILabel *fcSanStorageSize2;
@property (weak, nonatomic) IBOutlet UILabel *iscsiStorageSize2;
@property (weak, nonatomic) IBOutlet UILabel *nfsStorageSize2;
@property (weak, nonatomic) IBOutlet UILabel *localStorageSize3;

@property (weak, nonatomic) IBOutlet UILabel *storageSize3;
@property (weak, nonatomic) IBOutlet UILabel *shareStorageSize2;
@property (weak, nonatomic) IBOutlet UILabel *localStorageSize4;
@property (weak, nonatomic) IBOutlet UILabel *unUsedStorageSize2;
@property (weak, nonatomic) IBOutlet UILabel *usedStorageSize2;

@property (weak, nonatomic) IBOutlet UIView *storageShareChart;
@property (weak, nonatomic) IBOutlet UIView *storageUseChart;



@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

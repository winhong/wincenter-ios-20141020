//
//  StorageVmCollectionVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-9.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "StorageDiskCollectionVC.h"
#import "StorageDiskCollectionCell.h"

@interface StorageDiskCollectionVC ()

@end

@implementation StorageDiskCollectionVC

- (void)viewDidLoad{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.collectionView.backgroundColor = [UIColor clearColor];
    }
    
    
    self.dataList = [[NSMutableArray alloc] initWithCapacity:0];
    
    [super viewDidLoad];
    
    __unsafe_unretained typeof(self) week_self = self;
    
    [self.collectionView addHeaderWithCallback:^{
        [week_self.dataList removeAllObjects];
        [week_self reloadData];
    } dateKey:@"collection"];
    
    [self.collectionView addFooterWithCallback:^{
        [week_self reloadData];
    }];
    
    //[self.collectionView headerBeginRefreshing];
    [week_self reloadData];
    //[self.collectionView headerEndRefreshing];
    //[self.collectionView footerEndRefreshing];
}

- (IBAction)refreshAction:(id)sender {
    [self.collectionView headerBeginRefreshing];
}

- (void) reloadData{
    [self.storageVO getStorageVolumnListAsync:^(id object, NSError *error) {
        [self.dataList addObjectsFromArray:((StorageVolumnListResult*)object).resultList];
        [self.collectionView headerEndRefreshing];
        if(self.dataList.count >= ((StorageVolumnListResult*)object).recordTotal){
            [self.collectionView footerFinishingLoading];
        }else{
            [self.collectionView footerEndRefreshing];
        }
        [self.collectionView reloadData];
    } referTo:self.dataList];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StorageDiskCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StorageDiskCollectionCell" forIndexPath:indexPath];
    
    StorageVolumnVO *volumnVO = self.dataList[indexPath.row];
    cell.name.text = volumnVO.name;
    cell.state.text = [volumnVO state_text];
    cell.state.textColor = [volumnVO state_color];
    cell.isASnapshot.text = [volumnVO isASnapshot_text];
    cell.size.text = [NSString stringWithFormat:@"%dGB", volumnVO.size];
    cell.belongsVM.text = [volumnVO vmNames_text];
    cell.type.text = [volumnVO type_text];
    if (indexPath.row % 2 == 1) {
        cell.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}


@end

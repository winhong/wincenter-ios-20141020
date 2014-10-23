//
//  HostVmMemoryTop5CollectionVC.m
//  WinCenter
//
//  Created by huadi on 14/10/23.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "HostVmMemoryTop5CollectionVC.h"
#import "HostVmMemoryTop5CollectionCell.h"

@interface HostVmMemoryTop5CollectionVC ()

@end

@implementation HostVmMemoryTop5CollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.hostVO getHostVOAsync:^(id object, NSError *error) {
        self.hostVO = object;
        [self.hostVO getVmListAsync:^(id object, NSError *error) {
            self.vmList = object;
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"_memory" ascending:NO];
            self.vmList_sorted = [[NSMutableArray alloc] initWithArray:self.vmList];
            [self.vmList_sorted sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
            [self.collectionView reloadData];
            
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger MaxCount = self.vmList_sorted.count >=5 ? 5 : self.vmList_sorted.count;
    return MaxCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HostVmMemoryTop5CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HostVmMemoryTop5CollectionCell" forIndexPath:indexPath];

    //NSArray *array2 = [(VmVO*)self.vmList[indexPath.row] sortedArrayUsingSelector:@selector(compare:)];
    VmVO *vm = [VmVO new];
    vm = self.vmList_sorted[indexPath.row];
    switch (indexPath.row) {
        case 1:
            cell.blockColor.backgroundColor = [UIColor colorWithRed:68.0/255 green:149.0/255 blue:214/255 alpha:1];
            break;
        case 2:
            cell.blockColor.backgroundColor = [UIColor colorWithRed:107.0/255 green:181.0/255 blue:245/255 alpha:1];
            break;
        case 3:
            cell.blockColor.backgroundColor = [UIColor colorWithRed:154.0/255 green:196.0/255 blue:84/255 alpha:1];
            break;
        case 4:
            cell.blockColor.backgroundColor = [UIColor colorWithRed:250.0/255 green:133.0/255 blue:100/255 alpha:1];
            break;
        case 5:
            cell.blockColor.backgroundColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1];
            break;
        default:
            break;
    }
    cell.name.text = [NSString stringWithFormat:@"%@",vm.name == nil ? @"" :  vm.name];
    cell.percent.text = [NSString stringWithFormat:@"%.1f%%",self.hostVO.memory == 0 ? 0 : vm.memory*100/self.hostVO.memory ];
    cell.size.text = [NSString stringWithFormat:@"%.2fG",vm.memory/1024.0 ];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

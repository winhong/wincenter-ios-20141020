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
            
            self.vmList_sorted = [self.vmList sortedArrayUsingComparator:
            ^NSComparisonResult(VmVO *vm1, VmVO *vm2){
                NSComparisonResult result = vm1.memory > vm2.memory;
                
                return result == NSOrderedDescending; // 升序
            }];
            //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
            [self.collectionView reloadData];
            
        }];
    }];
//    NSMutableArray *array = [NSMutableArray arrayWithObjects:
//                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj0", [NSNumber numberWithInt:0], nil],
//                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj5", [NSNumber numberWithInt:5], nil],
//                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj2", [NSNumber numberWithInt:2], nil],
//                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj3", [NSNumber numberWithInt:3], nil],
//                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj1", [NSNumber numberWithInt:1], nil],
//                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj4", [NSNumber numberWithInt:4], nil], nil];
//    
//    NSArray *resultArray = [array sortedArrayUsingSelector:@selector(compare:)];
//    
//    NSArray *resultArray2 = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        
//        NSNumber *number1 = [[obj1 allKeys] objectAtIndex:0];
//        NSNumber *number2 = [[obj2 allKeys] objectAtIndex:0];
//        
//        NSComparisonResult result = [number1 compare:number2];
//        
//        return result == NSOrderedDescending; // 升序
//        return result == NSOrderedAscending;  // 降序
//    }];
    
}

//-(NSComparisonResult)compareMemory:(VmVO*)vm {
    //NSComparisonResult result = (VmVO*)self.memory > vm.memory;
    //return result == NSOrderedAscending;;
//}

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
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HostVmMemoryTop5CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HostVmMemoryTop5CollectionCell" forIndexPath:indexPath];

    //NSArray *array2 = [(VmVO*)self.vmList[indexPath.row] sortedArrayUsingSelector:@selector(compare:)];
    VmVO *vm = [VmVO new];
    vm = self.vmList_sorted[indexPath.row];
    cell.name.text = [NSString stringWithFormat:@"%@",vm.name ];
    cell.memory.text = [NSString stringWithFormat:@"%d",vm.memory ];
    
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

//
//  NetworkTotalCollectionVC.m
//  WinCenter
//
//  Created by 黄茂坚 on 14/10/27.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "NetworkTotalCollectionVC.h"
#import "NetworkTotalCollectionCell.h"
#import "NetworkCollectionVC.h"

@interface NetworkTotalCollectionVC ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property NSArray *networkList;
@property NSArray *ipPoolsList;
@end

@implementation NetworkTotalCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
//    加ip池信息
    [[RemoteObject getCurrentDatacenterVO] getNetworkOutsideAsync:^(id object, NSError *error) {
        self.networkList = object;
        [[RemoteObject getCurrentDatacenterVO] getIpPoolsAsync:^(id object, NSError *error) {
            self.ipPoolsInfo = object;
            [self.collectionView reloadData];
        }];
        
    }];
    
//    [[RemoteObject getCurrentDatacenterVO] getNetworkOutsideAsync:^(id object, NSError *error) {
//        self.networkList = object;
//        [self.collectionView reloadData];
//    }];
    
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

    return self.networkList.count;
}
- (IBAction)segmentChange:(id)sender {
    if(self.segment.selectedSegmentIndex==0){
        [[RemoteObject getCurrentDatacenterVO] getNetworkOutsideAsync:^(id object, NSError *error) {
            self.networkList = object;
            [[RemoteObject getCurrentDatacenterVO] getIpPoolsAsync:^(id object, NSError *error) {
                self.ipPoolsInfo = object;
                [self.collectionView reloadData];
            }];
            
        }];
//        [[RemoteObject getCurrentDatacenterVO] getNetworkOutsideAsync:^(id object, NSError *error) {
//            self.networkList = object;
//            [self.collectionView reloadData];
//        }];
    }else{
        [[RemoteObject getCurrentDatacenterVO] getNetworkInsideAsync:^(id object, NSError *error) {
            self.networkList = object;
            [[RemoteObject getCurrentDatacenterVO] getIpPoolsAsync:^(id object, NSError *error) {
                self.ipPoolsInfo = object;
                [self.collectionView reloadData];
            }];
            
        }];
//        [[RemoteObject getCurrentDatacenterVO] getNetworkInsideAsync:^(id object, NSError *error) {
//            self.networkList = object;
//            [self.collectionView reloadData];
//        }];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.segment.selectedSegmentIndex==0){
        NetworkTotalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NetworkTotalCollectionCell_Outside" forIndexPath:indexPath];
        NetworkVO *network = [NetworkVO new];
        network = self.networkList[indexPath.row];
        IpPoolsVO *ipPools = [IpPoolsVO new];
        ipPools = self.ipPoolsList[indexPath.row];
        cell.name.text = network.name;
        cell.vlan.text = network.vlanId;
        cell.linkState.image = [UIImage imageNamed:[network linkState_image]];
        cell.state.text = [network state_text];
        cell.ipSegment.text = ipPools.segment;
        cell.ipTotal.text = [NSString stringWithFormat:@"%d",ipPools.total];
        cell.ipUsable.text = [NSString stringWithFormat:@"%d",ipPools.usable];
        cell.ipUsed.text = [NSString stringWithFormat:@"%d",ipPools.used];
        
        return cell;
    }else{
        NetworkTotalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NetworkTotalCollectionCell_Inside" forIndexPath:indexPath];
        NetworkVO *network = [NetworkVO new];
        network = self.networkList[indexPath.row];
        cell.name.text = network.name;
        cell.linkState.image = [UIImage imageNamed:[network linkState_image]];
        cell.state.text = [network state_text];

        return cell;
    }
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

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UISplitViewController *splitVC = (UISplitViewController*) self.parentViewController.parentViewController;
    UINavigationController *nav = [[splitVC childViewControllers] lastObject];
    NetworkCollectionVC *detailVC = [[nav childViewControllers] firstObject];
    [detailVC reloadData];
}

@end

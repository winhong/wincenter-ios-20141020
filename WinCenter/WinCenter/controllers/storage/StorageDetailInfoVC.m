//
//  StorageDetailVC.m
//  wincenterDemo01
//
//  Created by huadi on 14-8-18.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "StorageDetailInfoVC.h"
#import "StorageDiskCollectionCell.h"

@interface StorageDetailInfoVC ()
@property (weak, nonatomic) IBOutlet UILabel *totalStorage;
@property (weak, nonatomic) IBOutlet UILabel *volumeNum;
@property (weak, nonatomic) IBOutlet UILabel *hostNum;
@property (weak, nonatomic) IBOutlet UILabel *vmNum;
@property (weak, nonatomic) IBOutlet UIImageView *shared;
@property (weak, nonatomic) IBOutlet UILabel *defaulted_label;
@property (weak, nonatomic) IBOutlet UIImageView *defaulted;
@property (weak, nonatomic) IBOutlet UILabel *totalStorageLabel1;
@property (weak, nonatomic) IBOutlet UILabel *totalStorageLabel2;
@property (weak, nonatomic) IBOutlet UILabel *usedStorageLabel;
@property (weak, nonatomic) IBOutlet UILabel *allocatedStorageLabel;
@property (weak, nonatomic) IBOutlet UIView *usedStorageGroup;
@property (weak, nonatomic) IBOutlet UIView *allocatedStorageGroup;
@property (weak, nonatomic) IBOutlet UILabel *usedRatio;
@property (weak, nonatomic) IBOutlet UILabel *allocatedRatio;
@property (weak, nonatomic) IBOutlet UILabel *type;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *isShared_img;
@property (weak, nonatomic) IBOutlet UIImageView *noShared_img;
@property (weak, nonatomic) IBOutlet UIImageView *isDefaulted_img;
@property (weak, nonatomic) IBOutlet UIImageView *noDefaulted_img;
@property (weak, nonatomic) IBOutlet UILabel *isshared;
@property (weak, nonatomic) IBOutlet UILabel *path;

@end

@implementation StorageDetailInfoVC

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"toDiskCollection"]){
        StorageDiskCollectionVC *diskCollectionVC = segue.destinationViewController;
        diskCollectionVC.storageVO = self.storageVO;
    }
}

- (void)viewDidLayoutSubviews{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if(self.scrollView){
            self.scrollView.contentSize = CGSizeMake(320, 1000);
        }
    }
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.circleChart strokeChart];
    [self.circleChart2 strokeChart];
}

- (void)viewDidLoad
{
    for(UILabel *label in self.allLabels){
        label.text = @"";
    }
    self.view.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
    
    [self.scrollView addHeaderWithCallback:^{
        [self reloadData];
    }];
    [self reloadData];
}

- (IBAction)refreshAction:(id)sender {
    [self.scrollView headerBeginRefreshing];
}

-(void)reloadData{
    
    [self.storageVO getStorageVOAsync:^(id object, NSError *error) {
        self.storageVO = object;
        [self refreshMainInfo];
        [self.scrollView headerEndRefreshing];
    }];
}
- (void)refreshMainInfo{
    self.totalStorage.text = [NSString stringWithFormat:@"%.2f", self.storageVO.totalStorage];
    self.volumeNum.text = [NSString stringWithFormat:@"%d", self.storageVO.volumeNum];
    self.hostNum.text = [NSString stringWithFormat:@"%d", self.storageVO.hostNum];
    self.vmNum.text = [NSString stringWithFormat:@"%d", self.storageVO.vmNum];
    self.shared.hidden = [self.storageVO.shared isEqualToString:@"false"];
    self.isDefaulted_img.hidden = [self.storageVO defaulted_img];
    self.noDefaulted_img.hidden = ![self.storageVO defaulted_img];
    self.isShared_img.hidden = ![self.storageVO shared_img];
    self.noShared_img.hidden = [self.storageVO shared_img];
    
    self.totalStorageLabel1.text = [NSString stringWithFormat:@"%.2f%@", [self.storageVO totalStorage_value]-[self.storageVO usedStorage_value],[self.storageVO totalStorage_unit]];
    self.totalStorageLabel2.text = [NSString stringWithFormat:@"%.2f%@", [self.storageVO totalStorage_value]-[self.storageVO allocatedStorage_value],[self.storageVO totalStorage_unit]];
    self.usedStorageLabel.text = [NSString stringWithFormat:@"%.2f%@", [self.storageVO usedStorage_value],[self.storageVO usedStorage_unit]];
    self.allocatedStorageLabel.text = [NSString stringWithFormat:@"%.2f%@", [self.storageVO allocatedStorage_value],[self.storageVO allocatedStorage_unit]];
    self.type.text = [self.storageVO.type uppercaseString];
    self.path.text = self.storageVO.location;
    
    self.usedRatio.text = [NSString stringWithFormat:@"%.0f %%", [self.storageVO usedRatio]];
    self.allocatedRatio.text = [NSString stringWithFormat:@"%.0f %%", [self.storageVO allocatedRatio]];
    
    for(UIView *subView in self.usedStorageGroup.subviews){
        [subView removeFromSuperview];
    }
    self.circleChart = [[PNCircleChart alloc] initWithFrame:self.usedStorageGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:[self.storageVO usedRatio]] andClockwise:YES andShadow:YES];
    self.circleChart.backgroundColor = [UIColor clearColor];
    self.circleChart.strokeColor = [UIColor clearColor];
    self.circleChart.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;
    self.circleChart.circle.lineCap = kCALineCapSquare;
    self.circleChart.lineWidth = @11.0f;
    [self.circleChart setStrokeColor:[UIColor colorWithRed:247.0/255 green:124.0/255 blue:56/255 alpha:1]];
    [self.circleChart strokeChart];
    [self.usedStorageGroup addSubview:self.circleChart];
    
    for(UIView *subView in self.allocatedStorageGroup.subviews){
        [subView removeFromSuperview];
    }
    self.circleChart2 = [[PNCircleChart alloc] initWithFrame:self.allocatedStorageGroup.bounds andTotal:@100 andCurrent:[NSNumber numberWithFloat:[self.storageVO allocatedRatio]] andClockwise:YES andShadow:YES];
    self.circleChart2.backgroundColor = [UIColor clearColor];
    self.circleChart2.strokeColor = [UIColor clearColor];
    self.circleChart2.circleBG.strokeColor = [UIColor colorWithRed:255.0/255 green:216.0/255 blue:0/255 alpha:1].CGColor;
    self.circleChart2.circle.lineCap = kCALineCapSquare;
    self.circleChart2.lineWidth = @11.0f;
    [self.circleChart2 setStrokeColor:[UIColor colorWithRed:247.0/255 green:124.0/255 blue:56/255 alpha:1]];
    [self.circleChart2 strokeChart];
    [self.allocatedStorageGroup addSubview:self.circleChart2];
}




@end

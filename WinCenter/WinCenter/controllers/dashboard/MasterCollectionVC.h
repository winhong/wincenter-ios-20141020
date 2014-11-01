//
//  DatacenterDetailCollectionVC.h
//  wincenterDemo01
//
//  Created by apple on 14-8-31.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F3BarGauge.h"

@interface MasterCollectionVC : UICollectionViewController<UIActionSheetDelegate>

@property NSArray *poolList;
@property PoolVO *poolVO;
@property BOOL isOutofPool;
@property BOOL isUnGroup;
@property NSMutableArray *dataList;
@property NSArray *businessList;
@property NSArray *busDomainsList;
@property BusDomainsVO *busDomainVO;

@property UIActionSheet *poolListActionSheet;
@property UIActionSheet *businessListActionSheet;

@property BOOL isDetailPagePushed;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backActionButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *allPoolOptionBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *allBusinessOptionBarButton;

@property UIPopoverController *popover;

-(void)reloadData;

-(IBAction)backToCollectionVC:(UIStoryboardSegue*)segue;
-(IBAction)dismissModal:(id)sender;

- (float) formatCountData:(float) num;

-(IBAction)showWarningInfoVC:(id)sender;
-(IBAction)showControlRecordVC:(id)sender;

@end

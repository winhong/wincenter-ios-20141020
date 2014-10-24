//
//  DatacenterDetailCollectionVC.h
//  wincenterDemo01
//
//  Created by apple on 14-8-31.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "F3BarGauge.h"

@interface MasterCollectionVC : UICollectionViewController

@property NSMutableDictionary *pools;
@property NSMutableDictionary *pools_needMoreButton;
@property NSMutableDictionary *dataList;

@property BOOL isDetailPagePushed;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backActionButton;

@property UIPopoverController *popover;

-(void)reloadData;

-(IBAction)backToCollectionVC:(UIStoryboardSegue*)segue;
-(IBAction)dismissModal:(id)sender;

- (float) formatCountData:(float) num;

-(IBAction)showWarningInfoVC:(id)sender;
-(IBAction)showControlRecordVC:(id)sender;

@end

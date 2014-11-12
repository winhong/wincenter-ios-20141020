//
//  DatacenterDetailVC.h
//  wincenterDemo01
//
//  Created by huadi on 14-8-15.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatacenterDetailInfoVC.h"
#import "DatacenterTableVC.h"
#import "PopWarningInfoVC.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

@class DatacenterDetailInfoVC;

@interface MasterContainerVC : UIViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

- (void)switchPageVC:(NSInteger)index;
@property (weak, nonatomic) IBOutlet UIToolbar *topToolBar;
@property HMSegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UIView *pageVCContainer;
@property UIPageViewController *pageVC;
@property NSArray *pages;
@property NSInteger _selectedIndex;
@property NSInteger previousIndex;
@property NSInteger showIndex;

@property (weak, nonatomic) IBOutlet UIView *segmentView;

@property UIPopoverController *popover;
@property BOOL switchPageVC_withoutAnimation;
@property BOOL isPageVCDataSourceNil;
@property BOOL isOrientationVertical;

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;


@property (weak, nonatomic) IBOutlet UILabel *pathLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *bannerScrollView;

@property UIPopoverController *popoverVC;

-(IBAction)backToContainVC:(UIStoryboardSegue*)segue;

-(IBAction)backAction:(id)sender;

- (void)refresh;

@end

//
//  DatacenterDetailVC.m
//  wincenterDemo01
//
//  Created by huadi on 14-8-15.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "MasterContainerVC.h"
#import "DatacenterVO.h"
#import "DatacenterListResult.h"
#import "MasterCollectionVC.h"
#import "StorageDetailInfoVC.h"
#import "BusinessDetailInfoVC.h"
#import "PoolDetailInfoVC.h"
#import "HostDetailInfoVC.h"
#import "VmDetailInfoVC.h"
#import "VmDetailSnapshootVC.h"
@interface MasterContainerVC ()

@end

@implementation MasterContainerVC

- (void)viewDidLoad
{    
    [super viewDidLoad];
        
    //for change the bullets color
    [UIPageControl appearance].pageIndicatorTintColor = [UIColor colorWithRed:(129.0/255) green:(129.0/255) blue:(129.0/255) alpha:1.0];
    [UIPageControl appearance].currentPageIndicatorTintColor = [UIColor colorWithRed:(06.0/255) green:(122.0/255) blue:(145.0/255) alpha:1.0];
    
    [UIPageControl appearance].backgroundColor = [UIColor clearColor];
    
    [self refresh];
}

- (void)refresh{
    self.previousIndex = 0;
    self.showIndex = 0;
    
    NSDictionary *options;
    
    if(self.isOrientationVertical){
        options = @{UIPageViewControllerOptionInterPageSpacingKey: @200};
    }else{
        options = @{UIPageViewControllerOptionInterPageSpacingKey: @50};
    }
    
    self.pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:(self.isOrientationVertical ?UIPageViewControllerNavigationOrientationVertical : UIPageViewControllerNavigationOrientationHorizontal) options:options];
    [self addChildViewController:self.pageVC];
    for(UIView *subView in self.pageVCContainer.subviews){
        [subView removeFromSuperview];
    }
    [self.pageVCContainer addSubview:self.pageVC.view];
    self.pageVC.view.frame = self.pageVCContainer.bounds;
    [self.pageVC didMoveToParentViewController:self];
    self.view.gestureRecognizers = self.pageVC.gestureRecognizers;
    
    [self.pageVC setViewControllers:@[self.pages[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.pageVC.dataSource = self;
    self.pageVC.delegate = self;
    
    if(self.isPageVCDataSourceNil){
        self.pageVC.dataSource = nil;
    }
    
    if(self.pages.count==1){
        self.pageVC.dataSource = nil;
    }
    
}

- (void)switchPageVC:(NSInteger)index {
    self.showIndex = index;
    [self.pageVC setViewControllers:@[self.pages[index]] direction:(index>self.previousIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse) animated:!self.switchPageVC_withoutAnimation completion:nil];
    self.previousIndex = index;
    
}
- (void)setPageButtonSelected:(NSInteger)index{
    UIView *view = self.segmentView;
    if(view){
        for(UIView *subView in view.subviews){
            UIButton *subButton = (UIButton*)subView;
            subButton.selected = (subButton.tag == index);
        }
    }
}
- (IBAction)showPageBarItemClick:(id)sender {
    [self switchPageVC:((UIBarButtonItem*)sender).tag];
}
- (IBAction)showPageButtonClick:(id)sender{
    UIButton *button = sender;
    UIView *button_container = [button superview];
    for(UIView *subView in button_container.subviews){
        UIButton *subButton = (UIButton*)subView;
        subButton.selected = NO;
    }
    button.selected = true;
    [self switchPageVC:((UIButton*)sender).tag];
}


-(IBAction)backToContainVC:(UIStoryboardSegue*)segue{
    
}

-(IBAction)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if(self.pages.count==1) return nil;
    
    NSUInteger index =  [self.pages indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }else{
        index--;
        return self.pages[index];
    }
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index =  [self.pages indexOfObject:viewController];
    if (index == self.pages.count - 1) {
        return nil;
    }else{
        index++;
        return self.pages[index];
    }
    
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController{
    return self.pages.count;
}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return self.showIndex;
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers{
    self._selectedIndex = [self.pages indexOfObject:pendingViewControllers[0]];
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    if(completed){
        self.showIndex = self._selectedIndex;
        [self setPageButtonSelected:self.showIndex];
    }
}

-(IBAction)showWarningInfoVCWithBarItem:(id)sender{
    if(self.popover!=nil){
        [self.popover dismissPopoverAnimated:NO];
    }
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Warning" bundle:nil] instantiateInitialViewController];
    self.popover = [[UIPopoverController alloc] initWithContentViewController:vc];
    UIBarButtonItem *button = (UIBarButtonItem*)sender;
    [self.popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}


@end

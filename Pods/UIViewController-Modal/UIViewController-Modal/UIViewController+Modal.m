//
//  UIViewController+Modal.m
//  UIViewController-Modal
//
//  Created by Bruno Tortato Furtado on 14/12/13.
//  Copyright (c) 2013 No Zebra Network. All rights reserved.
//

#import "UIViewController+Modal.h"

@implementation UIViewController (Modal)

- (BOOL)isModal
{
    BOOL isModal = ((self.parentViewController && self.parentViewController.presentedViewController == self) ||
                    ( self.navigationController && self.navigationController.parentViewController &&
                     self.navigationController.parentViewController.presentedViewController == self.navigationController) ||
                    [self.tabBarController.parentViewController isKindOfClass:[UITabBarController class]]);
    
    if (!isModal && [self respondsToSelector:@selector(presentingViewController)]) {
        isModal = ((self.presentingViewController && self.presentingViewController.presentedViewController == self) ||
                   (self.navigationController && self.navigationController.presentingViewController &&
                    self.navigationController.presentingViewController.presentedViewController == self.navigationController) ||
                   [self.tabBarController.parentViewController isKindOfClass:[UITabBarController class]]);
        
    }
    
    return isModal;
}

@end
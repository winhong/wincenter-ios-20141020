//
//  DatacenterDetailCollectionHeader.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "BusinessDashboardHeader.h"


@implementation BusinessDashboardHeader


-(void)layoutSubviews{
    [super layoutSubviews];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.scrollView.contentSize = CGSizeMake(1600, self.scrollView.frame.size.height);
    }
}

@end

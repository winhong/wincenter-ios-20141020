//
//  DatacenterDetailCollectionHeader.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmDashboardHeader.h"


@implementation VmDashboardHeader


-(void)layoutSubviews{
    [super layoutSubviews];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.scrollView.contentSize = CGSizeMake(1750, self.scrollView.frame.size.height);
    }
}

@end

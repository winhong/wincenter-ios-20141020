//
//  DatacenterDetailCollectionHeader.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "HostDashboardHeader.h"


@implementation HostDashboardHeader

-(void)layoutSubviews{
    [super layoutSubviews];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.scrollView.contentSize = CGSizeMake(1700, self.scrollView.frame.size.height);
    }
}

@end

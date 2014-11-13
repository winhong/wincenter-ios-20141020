//
//  BusinessDomainTableVC.h
//  WinCenter
//
//  Created by fengzj on 14/11/13.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BusinessDomainTableVCDelegate
- (void)didFinishedBusDomainSelect:(BusDomainsVO *)vo withTitle:(NSString*)title;
@end


@interface BusinessDomainTableVC : UITableViewController
@property NSString *currentName;
@property (weak, nonatomic) id <BusinessDomainTableVCDelegate> delegate;
@end

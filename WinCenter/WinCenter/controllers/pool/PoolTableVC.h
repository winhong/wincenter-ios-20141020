//
//  PoolTableVC.h
//  WinCenter
//
//  Created by fengzj on 14/11/13.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PoolTableVCDelegate
- (void)didFinishedPoolSelect:(PoolVO *)vo withTitle:(NSString*)title;
@end


@interface PoolTableVC : UITableViewController
@property NSString *currentName;
@property (weak, nonatomic) id <PoolTableVCDelegate> delegate;
@end

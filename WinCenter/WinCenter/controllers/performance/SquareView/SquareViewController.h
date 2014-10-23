//
//  ViewController.h
//  DAPIPViewExample
//
//  Created by Daniel Amitay on 4/12/13.
//  xiaoshu.wb@taobao.com
//  Copyright (c) 2012 http://cia.taobao.org
//

#import <UIKit/UIKit.h>

#import "SquareDelegate.h"
#import "DAPIPView.h"
@interface SquareViewController : UIViewController<SquareDelegate>

extern NSString * const BNRChangedNotfication;
@property DAPIPView *pipView;

@end

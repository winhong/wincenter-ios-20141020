//
//  RealtimeCurveVC.h
//  WinCenter
//
//  Created by apple on 14-7-6.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RealtimeCurveVC : UIViewController<UIWebViewDelegate>

@property HostVO *hostVO;
@property VmVO *vmVO;
@property NSString *chartType;
@end

//
//  VmDetailShowVC.h
//  wincenterDemo01
//
//  Created by huadi on 14-8-21.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VmDetailInfoVC : UIViewController

@property VmVO *vmVO;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;


@end

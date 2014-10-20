//
//  BusinessDetailVC.h
//  wincenterDemo01
//
//  Created by huadi on 14-8-20.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessDetailInfoVC : UIViewController

@property BusinessVO *businessVO;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;
@end

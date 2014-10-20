//
//  StorageDetailVC.h
//  wincenterDemo01
//
//  Created by huadi on 14-8-18.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StorageDiskCollectionVC.h"

@interface StorageDetailInfoVC : UIViewController

@property StorageVO *storageVO;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;

@property PNCircleChart *circleChart;
@property PNCircleChart *circleChart2;

@end

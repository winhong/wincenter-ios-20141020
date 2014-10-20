//
//  PoolDetailBaseinfoVC.h
//  wincenterDemo01
//
//  Created by huadi on 14-8-21.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoolDetailInfoVC : UIViewController

@property PoolVO *poolVO;
@property PoolElasticInfo *elasticInfo;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;
@property PNCircleChart *circleChart;
@property PNCircleChart *circleChart2;
@property PNCircleChart *circleChart3;

@end

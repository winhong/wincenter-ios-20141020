//
//  ARViewController.m
//  ARLineChartDemo
//
//  Created by LongJun on 14-2-14.
//  Copyright (c) 2014年 Arwer Software. All rights reserved.
//

#import "DoubleYSeriesVC.h"
#import "ARLineChartView.h"
#import "ARLineChartCommon.h"

@interface DoubleYSeriesVC ()

@end

@implementation DoubleYSeriesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //************* Test: Create Data Source *************
    NSMutableArray *dataSource = [NSMutableArray array];
    // rand() /((double)(RAND_MAX)/100) //取0-100中间的浮点数
    double distanceMin = 10, distanceMax = 30;
    double altitudeMin = 10, altitudeMax = 30;
    double speedMin = 12, speedMax = 15;
    
    srand(time(NULL)); //Random seed
    
    for (int i=0; i< 7; i++) {
        
        RLLineChartItem *item = [[RLLineChartItem alloc] init];
        double randVal;
        
        randVal = rand() /((double)(RAND_MAX)/distanceMax) + distanceMin;
        item.xValue = randVal;
        
        randVal = rand() /((double)(RAND_MAX)/altitudeMax) + altitudeMin;
        item.y1Value = randVal;
        
        randVal = rand() /((double)(RAND_MAX)/speedMax) + speedMin;
        item.y2Value = randVal;
        
        NSLog(@"Random: item.xValue=%.2lf, item.y1Value=%.2lf, item.y2Value=%.2lf", item.xValue, item.y1Value, item.y2Value);
        [dataSource addObject:item];
    }
    [self.view addSubview:[[ARLineChartView alloc]
                           initWithFrame:CGRectMake(5, 70,self.view.frame.size.width - 10, self.view.frame.size.height - 90)
                              dataSource:dataSource
                                  xTitle:@"利用率统计"
                                 y1Title:@"物理主机 (资源利用率)"
                                 y2Title:@"虚拟主机 (资源利用率)"
                                   desc1:@"物理主机"
                                   desc2:@"虚拟主机"]];
    
}



@end


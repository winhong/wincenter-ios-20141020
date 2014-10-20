//
//  chatLineController.h
//  doubleChatline
//
//  Created by Z on 14-5-26.
//  Copyright (c) 2014年 carlsworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoView.h"
typedef enum{
    year=0,
    month,
    day,
    week
}State;

@interface DoubleLineChartVC : UIViewController

@property(nonatomic, strong)InfoView* info;

@end

//
//  ViewController.h
//  SY_Date
//
//  Created by 孙悦 on 14-2-7.
//  Copyright (c) 2014年 孙悦. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CalendarDateUtil.h"
#import "UIBaseClass.h"

@interface WeekStatVC : UIViewController
{
    NSString* _timeString;
    
    NSString* _nowDateString;
    NSMutableArray* _btnArray;
    
    UIView* _cBSView;
    UIView* _cBPView;
    UIView* _cBMIView;
    UIView* _lBSView;
    UIView* _lBPView;
    UIView* _lBMIView;
    UIView* _rBSView;
    UIView* _rBPView;
    UIView* _rBMIView;
    
    UILabel* _bsLable;
    UILabel* _bpLable;
    UILabel* _weightLable;
    UILabel* _appointLable;
    UILabel* _healthLable;
    UILabel* _manageLable;
    
    UILabel* _bsLableR;
    UILabel* _bpLableR;
    UILabel* _weightLableR;
    UILabel* _appointLableR;
    UILabel* _healthLableR;
    
    UILabel* _bsLableL;
    UILabel* _bpLableL;
    UILabel* _weightLableL;
    UILabel* _appointLableL;
    UILabel* _healthLableL;
    
    UIScrollView* _scrollView;
    UIView* _dateView;
    UIView* _workView;
    
    UILabel* dateLable;
    int _scrollDate;                    // 滑动控制中间日期
    int _btnDate;
    
    int _changeWeek;                    //控制滑动日期
    int _btnSelectDate;                 //btn选择的位置
    UIView* _changeDateR;
    UIView* _changeWorkR;
    UIView* _changeDateL;
    UIView* _changeWorkL;
    NSMutableArray* _changeBtnArrayR;   //RView的Btn数组
    NSMutableArray* _changeBtnArrayL;   //LView的Btn数组
    
    int _mmMainFX;
    int _mmMainFY;
    int _vFX;
    int _vFY;
}
@property(nonatomic, retain)NSString* nowDateString;
@property(nonatomic, retain)UILabel* bsLable;
@property(nonatomic, retain)UILabel* bpLable;
@property(nonatomic, retain)UILabel* weightLable;
@property(nonatomic, retain)UILabel* appointLable;
@property(nonatomic, retain)UILabel* healthLable;
@property(nonatomic, retain)NSMutableArray* btnArray;
@property(nonatomic, retain)UIScrollView* scrollView;
@property(nonatomic, retain)UIView* dateView;
@property(nonatomic, retain)UIView* workView;


@end

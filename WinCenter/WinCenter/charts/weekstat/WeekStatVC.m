//
//  ViewController.m
//  SY_Date
//
//  Created by 孙悦 on 14-2-7.
//  Copyright (c) 2014年 孙悦. All rights reserved.
//

#import "WeekStatVC.h"

@interface WeekStatVC ()
@property (weak, nonatomic) IBOutlet UIView *container;

@end

@implementation WeekStatVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"工作计划";
    self.view.backgroundColor = [UIColor whiteColor];
    _mmMainFX = self.container.bounds.origin.x;
    _mmMainFY = [[UIBaseClass shareInstance] getViewFramOY];
    
    _scrollDate = 0;
    _btnDate = 0;
    
    [self initBase];
    
    [self initView];
    [self initDateView];
    
    [self initSwipeGestureRecognizerLeft];
    [self initSwipeGestureRecognizerRight];
    [self initSwipeGestureRecognizerLeft2];
    [self initSwipeGestureRecognizerRight2];
    
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMdd"];
    _timeString = [dateformat stringFromDate:[NSDate date]];
    //    _timeString = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_scrollDate + _btnDate]];
    [self httpFuction];
    
	// Do any additional setup after loading the view.
}

-(void)initBase
{
    _btnArray = [[NSMutableArray alloc]init];
    _changeBtnArrayR = [[NSMutableArray alloc]init];
    _changeBtnArrayL = [[NSMutableArray alloc]init];
    
    _changeWeek = 0;
    _btnSelectDate = 0;
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, 48, 320, 40)];
    _dateView.backgroundColor = [UIColor clearColor];
    _changeDateR = [[UIView alloc]initWithFrame:CGRectMake(320, 48, 320, 40)];
    _changeDateL = [[UIView alloc]initWithFrame:CGRectMake(-320, 48, 320, 40)];
    _workView = [[UIView alloc]initWithFrame:CGRectMake(0, 146, 320, 460)];
    _changeWorkR = [[UIView alloc]initWithFrame:CGRectMake(320, 146, 320, 460)];
    _changeWorkL = [[UIView alloc]initWithFrame:CGRectMake(-320, 146, 320, 460)];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.container.bounds];
    _scrollView.contentSize = CGSizeMake(320, iPhone5?0:500);
    //    _scrollView.pagingEnabled = YES;
    //    _scrollView.userInteractionEnabled = YES; // 是否滑动
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.container addSubview:_scrollView];
}


-(void)initView
{
    _vFX = _mmMainFX;
    _vFY = _mmMainFY + 40;
    
    UIImageView* line1 = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 320, 1)];
    line1.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    _vFX = _vFX + 0;
    _vFY = _vFY + 55;
    UIImageView* line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 95, 320, 1)];
    line2.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    _vFX = _vFX + 0;
    _vFY = _vFY + line2.frame.size.height + 12;
    dateLable = [[UILabel alloc]initWithFrame:CGRectMake(_vFX + 74, _vFY, 180, 15)];
    dateLable.text = _nowDateString;
    dateLable.font = [UIFont systemFontOfSize:15];
    dateLable.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    dateLable.backgroundColor = [UIColor clearColor];
    dateLable.center = CGPointMake(160, dateLable.center.y);
    dateLable.textAlignment = NSTextAlignmentCenter;
    
    _vFX = _vFX + 0;
    _vFY = _vFY + dateLable.frame.size.height + 12;
    UIImageView* line3 = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 320, 1)];
    line3.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    
    /*****************
     5-btn init
     *****************/
    
    _vFX = _vFX + 15;
    _vFY = _vFY + line3.frame.size.height + 10;
    
    _vFX = _mmMainFX + 15;
    _vFY = _mmMainFY;
    UIImageView* bsImgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, _vFY, 40, 40)];
    bsImgView.image = [UIImage imageNamed:@"bs-80-80"];
    
    UILabel* xueTang = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    xueTang.text = @"血糖预警";
    xueTang.font = [UIFont boldSystemFontOfSize:15];
    xueTang.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    xueTang.center = CGPointMake(xueTang.center.x, bsImgView.center.y);
    
    _bsLable = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _bsLable.text = @"0";
    _bsLable.textAlignment = NSTextAlignmentRight;
    _bsLable.font = [UIFont boldSystemFontOfSize:45];
    _bsLable.textColor = [UIColor colorWithRed:220.0/255 green:10.0/255 blue:80.0/255 alpha:1.0];
    _bsLable.center = CGPointMake(_bsLable.center.x, bsImgView.center.y);
    
    UILabel* people1 = [[UILabel alloc]initWithFrame:CGRectMake(294, _bsLable.frame.origin.y + 25, 15, 13)];
    people1.text = @"人";
    people1.font = [UIFont boldSystemFontOfSize:13];
    people1.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + bsImgView.frame.size.height + 10;
    UIImageView* bsLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    bsLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    UIButton* bsBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, 320, 61)];
    bsBtn.backgroundColor = [UIColor clearColor];
    bsBtn.center = CGPointMake(bsBtn.center.x, bsImgView.center.y);
    
    _cBSView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 61)];
    
    _vFX = _vFX + 0;
    _vFY = _mmMainFY;
    UIImageView* bpImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 40, 40)];
    bpImgView.image = [UIImage imageNamed:@"bp-80-80"];
    
    UILabel* xueYa = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    xueYa.text = @"血压预警";
    xueYa.font = [UIFont boldSystemFontOfSize:15];
    xueYa.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    xueYa.center = CGPointMake(xueTang.center.x, bpImgView.center.y);
    
    _bpLable = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _bpLable.text = @"0";
    _bpLable.textAlignment = NSTextAlignmentRight;
    _bpLable.font = [UIFont boldSystemFontOfSize:45];
    _bpLable.textColor = [UIColor colorWithRed:220.0/255 green:10.0/255 blue:80.0/255 alpha:1.0];
    _bpLable.center = CGPointMake(_bpLable.center.x, bpImgView.center.y);
    
    UILabel* people2 = [[UILabel alloc]initWithFrame:CGRectMake(294, _bpLable.frame.origin.y + 25, 15, 13)];
    people2.text = @"人";
    people2.font = [UIFont boldSystemFontOfSize:13];
    people2.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + bpImgView.frame.size.height + 10;
    UIImageView* bpLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    bpLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    UIButton* bpBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, 320, 61)];
    bpBtn.backgroundColor = [UIColor clearColor];
    bpBtn.center = CGPointMake(bpBtn.center.x, bpImgView.center.y);
    
    _cBPView = [[UIView alloc]initWithFrame:CGRectMake(0, 61, 320, 61)];
    
    _vFX = _vFX + 0;
    _vFY = _mmMainFY;
    UIImageView* weightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 40, 40)];
    weightImgView.image = [UIImage imageNamed:@"bmi-80-80"];
    
    UILabel* tiZhong = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    tiZhong.text = @"体重预警";
    tiZhong.font = [UIFont boldSystemFontOfSize:15];
    tiZhong.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    tiZhong.center = CGPointMake(tiZhong.center.x, weightImgView.center.y);
    
    _weightLable = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _weightLable.text = @"0";
    _weightLable.textAlignment = NSTextAlignmentRight;
    _weightLable.font = [UIFont boldSystemFontOfSize:45];
    _weightLable.textColor = [UIColor colorWithRed:220.0/255 green:10.0/255 blue:80.0/255 alpha:1.0];
    _weightLable.center = CGPointMake(_weightLable.center.x, weightImgView.center.y);
    
    UILabel* people3 = [[UILabel alloc]initWithFrame:CGRectMake(294, _weightLable.frame.origin.y + 25, 15, 13)];
    people3.text = @"人";
    people3.font = [UIFont boldSystemFontOfSize:13];
    people3.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + weightImgView.frame.size.height + 10;
    UIImageView* weightLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    weightLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    UIButton* weightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, 320, 61)];
    weightBtn.backgroundColor = [UIColor clearColor];
    weightBtn.center = CGPointMake(bsBtn.center.x, weightImgView.center.y);
    
    _cBMIView = [[UIView alloc]initWithFrame:CGRectMake(0, 122, 320, 61)];
    
    _vFX = _vFX + 0;
    _vFY = _mmMainFY + 183;
    UIImageView* appointImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 40, 40)];
    appointImgView.image = [UIImage imageNamed:@"appoint-80-80"];
    
    UILabel* menZhen = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    menZhen.text = @"门诊预约";
    menZhen.font = [UIFont boldSystemFontOfSize:15];
    menZhen.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    menZhen.center = CGPointMake(menZhen.center.x, appointImgView.center.y);
    
    _appointLable = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _appointLable.text = @"0";
    _appointLable.textAlignment = NSTextAlignmentRight;
    _appointLable.font = [UIFont boldSystemFontOfSize:45];
    _appointLable.textColor = [UIColor colorWithRed:220.0/255 green:10.0/255 blue:80.0/255 alpha:1.0];
    _appointLable.center = CGPointMake(_appointLable.center.x, appointImgView.center.y);
    
    UILabel* people4 = [[UILabel alloc]initWithFrame:CGRectMake(294, _appointLable.frame.origin.y + 25, 15, 13)];
    people4.text = @"人";
    people4.font = [UIFont boldSystemFontOfSize:13];
    people4.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + appointImgView.frame.size.height + 10;
    UIImageView* appointLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    appointLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    UIButton* appointBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, 320, 61)];
    appointBtn.backgroundColor = [UIColor clearColor];
    appointBtn.center = CGPointMake(appointBtn.center.x, appointImgView.center.y);
    
    _vFX = _vFX + 0;
    _vFY = _vFY + appointLine.frame.size.height + 10;
    UIImageView* healthImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 40, 40)];
    healthImgView.image = [UIImage imageNamed:@"health-80-80"];
    
    UILabel* jianKang = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    jianKang.text = @"健康指导";
    jianKang.font = [UIFont boldSystemFontOfSize:15];
    jianKang.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    jianKang.center = CGPointMake(jianKang.center.x, healthImgView.center.y);
    
    _healthLable = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _healthLable.text = @"0";
    _healthLable.textAlignment = NSTextAlignmentRight;
    _healthLable.font = [UIFont boldSystemFontOfSize:45];
    _healthLable.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    _healthLable.center = CGPointMake(_healthLable.center.x, healthImgView.center.y);
    
    UILabel* people5 = [[UILabel alloc]initWithFrame:CGRectMake(294, _healthLable.frame.origin.y + 25, 15, 13)];
    people5.text = @"人";
    people5.font = [UIFont boldSystemFontOfSize:13];
    people5.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + healthImgView.frame.size.height + 10;
    UIImageView* healthLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    healthLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    UIButton* healthBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, 320, 61)];
    healthBtn.backgroundColor = [UIColor clearColor];
    healthBtn.center = CGPointMake(healthBtn.center.x, healthImgView.center.y);
    
    //btn Target
    [bsBtn addTarget:self action:@selector(pushBS) forControlEvents:UIControlEventTouchUpInside];
    [bpBtn addTarget:self action:@selector(pushBP) forControlEvents:UIControlEventTouchUpInside];
    [weightBtn addTarget:self action:@selector(pushBMI) forControlEvents:UIControlEventTouchUpInside];
    [appointBtn addTarget:self action:@selector(pushAppoint) forControlEvents:UIControlEventTouchUpInside];
    [healthBtn addTarget:self action:@selector(pushHealth) forControlEvents:UIControlEventTouchUpInside];
    //btn Target
    
    [_scrollView addSubview:line1];
    [_scrollView addSubview:line2];
    [_scrollView addSubview:dateLable];
    [_scrollView addSubview:line3];
    
    
    [_cBSView addSubview:bsImgView];
    [_cBSView addSubview:xueTang];
    [_cBSView addSubview:_bsLable];
    [_cBSView addSubview:bsLine];
    [_cBSView addSubview:bsBtn];
    [_cBSView addSubview:people1];
    [_workView addSubview:_cBSView];
    
    [_cBPView addSubview:bpImgView];
    [_cBPView addSubview:xueYa];
    [_cBPView addSubview:_bpLable];
    [_cBPView addSubview:bpLine];
    [_cBPView addSubview:bpBtn];
    [_cBPView addSubview:people2];
    [_workView addSubview:_cBPView];
    
    [_cBMIView addSubview:weightImgView];
    [_cBMIView addSubview:tiZhong];
    [_cBMIView addSubview:_weightLable];
    [_cBMIView addSubview:weightLine];
    [_cBMIView addSubview:weightBtn];
    [_cBMIView addSubview:people3];
    [_workView addSubview:_cBMIView];
    
    [_workView addSubview:appointImgView];
    [_workView addSubview:menZhen];
    [_workView addSubview:_appointLable];
    [_workView addSubview:appointLine];
    [_workView addSubview:appointBtn];
    [_workView addSubview:people4];
    
    [_workView addSubview:healthImgView];
    [_workView addSubview:jianKang];
    [_workView addSubview:_healthLable];
    [_workView addSubview:healthLine];
    [_workView addSubview:healthBtn];
    [_workView addSubview:people5];
    
    //    [_scrollView addSubview:_changeWorkL];
    //    [_scrollView addSubview:_changeWorkR];
    [_scrollView addSubview:_workView];
}

-(void)workViewR
{
    _vFX = _mmMainFX + 15;
    _vFY = _mmMainFY;
    UIImageView* bsImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 40, 40)];
    bsImgView.image = [UIImage imageNamed:@"bs-80-80"];
    
    UILabel* xueTang = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    xueTang.text = @"血糖预警";
    xueTang.font = [UIFont boldSystemFontOfSize:15];
    xueTang.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    xueTang.center = CGPointMake(xueTang.center.x, bsImgView.center.y);
    
    _bsLableR = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _bsLableR.text = @"0";
    _bsLableR.textAlignment = NSTextAlignmentRight;
    _bsLableR.font = [UIFont boldSystemFontOfSize:45];
    _bsLableR.textColor = [UIColor colorWithRed:220.0/255 green:10.0/255 blue:80.0/255 alpha:1.0];
    _bsLableR.center = CGPointMake(_bsLable.center.x, bsImgView.center.y);
    
    UILabel* people1 = [[UILabel alloc]initWithFrame:CGRectMake(294, _bsLable.frame.origin.y + 25, 15, 13)];
    people1.text = @"人";
    people1.font = [UIFont boldSystemFontOfSize:13];
    people1.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + bsImgView.frame.size.height + 10;
    UIImageView* bsLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    bsLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    _vFX = _vFX + 0;
    _vFY = _mmMainFY;
    UIImageView* bpImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 40, 40)];
    bpImgView.image = [UIImage imageNamed:@"bp-80-80"];
    
    _rBSView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 61)];
    
    UILabel* xueYa = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    xueYa.text = @"血压预警";
    xueYa.font = [UIFont boldSystemFontOfSize:15];
    xueYa.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    xueYa.center = CGPointMake(xueTang.center.x, bpImgView.center.y);
    
    _bpLableR = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _bpLableR.text = @"0";
    _bpLableR.textAlignment = NSTextAlignmentRight;
    _bpLableR.font = [UIFont boldSystemFontOfSize:45];
    _bpLableR.textColor = [UIColor colorWithRed:220.0/255 green:10.0/255 blue:80.0/255 alpha:1.0];
    _bpLableR.center = CGPointMake(_bpLable.center.x, bpImgView.center.y);
    
    UILabel* people2 = [[UILabel alloc]initWithFrame:CGRectMake(294, _bpLable.frame.origin.y + 25, 15, 13)];
    people2.text = @"人";
    people2.font = [UIFont boldSystemFontOfSize:13];
    people2.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + bpImgView.frame.size.height + 10;
    UIImageView* bpLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    bpLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    _rBPView = [[UIView alloc]initWithFrame:CGRectMake(0, 61, 320, 61)];
    
    _vFX = _vFX + 0;
    _vFY = _mmMainFY;
    UIImageView* weightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 40, 40)];
    weightImgView.image = [UIImage imageNamed:@"bmi-80-80"];
    
    UILabel* tiZhong = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    tiZhong.text = @"体重预警";
    tiZhong.font = [UIFont boldSystemFontOfSize:15];
    tiZhong.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    tiZhong.center = CGPointMake(tiZhong.center.x, weightImgView.center.y);
    
    _weightLableR = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _weightLableR.text = @"0";
    _weightLableR.textAlignment = NSTextAlignmentRight;
    _weightLableR.font = [UIFont boldSystemFontOfSize:45];
    _weightLableR.textColor = [UIColor colorWithRed:220.0/255 green:10.0/255 blue:80.0/255 alpha:1.0];
    _weightLableR.center = CGPointMake(_weightLable.center.x, weightImgView.center.y);
    
    UILabel* people3 = [[UILabel alloc]initWithFrame:CGRectMake(294, _weightLable.frame.origin.y + 25, 15, 13)];
    people3.text = @"人";
    people3.font = [UIFont boldSystemFontOfSize:13];
    people3.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + weightImgView.frame.size.height + 10;
    UIImageView* weightLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    weightLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    _rBMIView = [[UIView alloc]initWithFrame:CGRectMake(0, 122, 320, 61)];
    
    _vFX = _vFX + 0;
    _vFY = _mmMainFY + 183;
    UIImageView* appointImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 40, 40)];
    appointImgView.image = [UIImage imageNamed:@"appoint-80-80"];
    
    UILabel* menZhen = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    menZhen.text = @"门诊预约";
    menZhen.font = [UIFont boldSystemFontOfSize:15];
    menZhen.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    menZhen.center = CGPointMake(menZhen.center.x, appointImgView.center.y);
    
    _appointLableR = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _appointLableR.text = @"0";
    _appointLableR.textAlignment = NSTextAlignmentRight;
    _appointLableR.font = [UIFont boldSystemFontOfSize:45];
    _appointLableR.textColor = [UIColor colorWithRed:220.0/255 green:10.0/255 blue:80.0/255 alpha:1.0];
    _appointLableR.center = CGPointMake(_appointLable.center.x, appointImgView.center.y);
    
    UILabel* people4 = [[UILabel alloc]initWithFrame:CGRectMake(294, _appointLable.frame.origin.y + 25, 15, 13)];
    people4.text = @"人";
    people4.font = [UIFont boldSystemFontOfSize:13];
    people4.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + appointImgView.frame.size.height + 10;
    UIImageView* appointLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    appointLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    _vFX = _vFX + 0;
    _vFY = _vFY + appointLine.frame.size.height + 10;
    UIImageView* healthImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 40, 40)];
    healthImgView.image = [UIImage imageNamed:@"health-80-80"];
    
    UILabel* jianKang = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    jianKang.text = @"健康指导";
    jianKang.font = [UIFont boldSystemFontOfSize:15];
    jianKang.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    jianKang.center = CGPointMake(jianKang.center.x, healthImgView.center.y);
    
    _healthLableR = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _healthLableR.text = @"0";
    _healthLableR.textAlignment = NSTextAlignmentRight;
    _healthLableR.font = [UIFont boldSystemFontOfSize:45];
    _healthLableR.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    _healthLableR.center = CGPointMake(_healthLable.center.x, healthImgView.center.y);
    
    UILabel* people5 = [[UILabel alloc]initWithFrame:CGRectMake(294, _healthLable.frame.origin.y + 25, 15, 13)];
    people5.text = @"人";
    people5.font = [UIFont boldSystemFontOfSize:13];
    people5.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + healthImgView.frame.size.height + 10;
    UIImageView* healthLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    healthLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    [_rBSView addSubview:bsImgView];
    [_rBSView addSubview:xueTang];
    [_rBSView addSubview:_bsLableR];
    [_rBSView addSubview:bsLine];
    [_rBSView addSubview:people1];
    [_changeWorkR addSubview:_rBSView];
    
    [_rBPView addSubview:bpImgView];
    [_rBPView addSubview:xueYa];
    [_rBPView addSubview:_bpLableR];
    [_rBPView addSubview:bpLine];
    [_rBPView addSubview:people2];
    [_changeWorkR addSubview:_rBPView];
    
    [_rBMIView addSubview:weightImgView];
    [_rBMIView addSubview:tiZhong];
    [_rBMIView addSubview:_weightLableR];
    [_rBMIView addSubview:weightLine];
    [_rBMIView addSubview:people3];
    [_changeWorkR addSubview:_rBMIView];
    
    [_changeWorkR addSubview:appointImgView];
    [_changeWorkR addSubview:menZhen];
    [_changeWorkR addSubview:_appointLableR];
    [_changeWorkR addSubview:appointLine];
    [_changeWorkR addSubview:people4];
    
    [_changeWorkR addSubview:healthImgView];
    [_changeWorkR addSubview:jianKang];
    [_changeWorkR addSubview:_healthLableR];
    [_changeWorkR addSubview:healthLine];
    [_changeWorkR addSubview:people5];
    
    [_scrollView addSubview:_changeWorkR];
}
-(void)workViewL
{
    _vFX = _mmMainFX + 15;
    _vFY = _mmMainFY;
    UIImageView* bsImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 40, 40)];
    bsImgView.image = [UIImage imageNamed:@"bs-80-80"];
    
    UILabel* xueTang = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    xueTang.text = @"血糖预警";
    xueTang.font = [UIFont boldSystemFontOfSize:15];
    xueTang.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    xueTang.center = CGPointMake(xueTang.center.x, bsImgView.center.y);
    
    _bsLableL = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _bsLableL.text = @"0";
    _bsLableL.textAlignment = NSTextAlignmentRight;
    _bsLableL.font = [UIFont boldSystemFontOfSize:45];
    _bsLableL.textColor = [UIColor colorWithRed:220.0/255 green:10.0/255 blue:80.0/255 alpha:1.0];
    _bsLableL.center = CGPointMake(_bsLable.center.x, bsImgView.center.y);
    
    UILabel* people1 = [[UILabel alloc]initWithFrame:CGRectMake(294, _bsLable.frame.origin.y + 25, 15, 13)];
    people1.text = @"人";
    people1.font = [UIFont boldSystemFontOfSize:13];
    people1.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + bsImgView.frame.size.height + 10;
    UIImageView* bsLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    bsLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    _lBSView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 61)];
    
    _vFX = _vFX + 0;
    _vFY = _mmMainFY;
    UIImageView* bpImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 40, 40)];
    bpImgView.image = [UIImage imageNamed:@"bp-80-80"];
    
    UILabel* xueYa = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    xueYa.text = @"血压预警";
    xueYa.font = [UIFont boldSystemFontOfSize:15];
    xueYa.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    xueYa.center = CGPointMake(xueTang.center.x, bpImgView.center.y);
    
    _bpLableL = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _bpLableL.text = @"0";
    _bpLableL.textAlignment = NSTextAlignmentRight;
    _bpLableL.font = [UIFont boldSystemFontOfSize:45];
    _bpLableL.textColor = [UIColor colorWithRed:220.0/255 green:10.0/255 blue:80.0/255 alpha:1.0];
    _bpLableL.center = CGPointMake(_bpLable.center.x, bpImgView.center.y);
    
    UILabel* people2 = [[UILabel alloc]initWithFrame:CGRectMake(294, _bpLable.frame.origin.y + 25, 15, 13)];
    people2.text = @"人";
    people2.font = [UIFont boldSystemFontOfSize:13];
    people2.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + bpImgView.frame.size.height + 10;
    UIImageView* bpLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    bpLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    _lBPView = [[UIView alloc]initWithFrame:CGRectMake(0, 61, 320, 61)];
    
    _vFX = _vFX + 0;
    _vFY = _mmMainFY;
    UIImageView* weightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 40, 40)];
    weightImgView.image = [UIImage imageNamed:@"bmi-80-80"];
    
    UILabel* tiZhong = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    tiZhong.text = @"体重预警";
    tiZhong.font = [UIFont boldSystemFontOfSize:15];
    tiZhong.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    tiZhong.center = CGPointMake(tiZhong.center.x, weightImgView.center.y);
    
    _weightLableL = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _weightLableL.text = @"0";
    _weightLableL.textAlignment = NSTextAlignmentRight;
    _weightLableL.font = [UIFont boldSystemFontOfSize:45];
    _weightLableL.textColor = [UIColor colorWithRed:220.0/255 green:10.0/255 blue:80.0/255 alpha:1.0];
    _weightLableL.center = CGPointMake(_weightLable.center.x, weightImgView.center.y);
    
    UILabel* people3 = [[UILabel alloc]initWithFrame:CGRectMake(294, _weightLable.frame.origin.y + 25, 15, 13)];
    people3.text = @"人";
    people3.font = [UIFont boldSystemFontOfSize:13];
    people3.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + weightImgView.frame.size.height + 10;
    UIImageView* weightLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    weightLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    _lBMIView = [[UIView alloc]initWithFrame:CGRectMake(0, 122, 320, 61)];
    
    _vFX = _vFX + 0;
    _vFY = _mmMainFY + 183;
    UIImageView* appointImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 40, 40)];
    appointImgView.image = [UIImage imageNamed:@"appoint-80-80"];
    
    UILabel* menZhen = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    menZhen.text = @"门诊预约";
    menZhen.font = [UIFont boldSystemFontOfSize:15];
    menZhen.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    menZhen.center = CGPointMake(menZhen.center.x, appointImgView.center.y);
    
    _appointLableL = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _appointLableL.text = @"0";
    _appointLableL.textAlignment = NSTextAlignmentRight;
    _appointLableL.font = [UIFont boldSystemFontOfSize:45];
    _appointLableL.textColor = [UIColor colorWithRed:220.0/255 green:10.0/255 blue:80.0/255 alpha:1.0];
    _appointLableL.center = CGPointMake(_appointLable.center.x, appointImgView.center.y);
    
    UILabel* people4 = [[UILabel alloc]initWithFrame:CGRectMake(294, _appointLable.frame.origin.y + 25, 15, 13)];
    people4.text = @"人";
    people4.font = [UIFont boldSystemFontOfSize:13];
    people4.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + appointImgView.frame.size.height + 10;
    UIImageView* appointLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    appointLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    _vFX = _vFX + 0;
    _vFY = _vFY + appointLine.frame.size.height + 10;
    UIImageView* healthImgView = [[UIImageView alloc]initWithFrame:CGRectMake(_vFX, _vFY, 40, 40)];
    healthImgView.image = [UIImage imageNamed:@"health-80-80"];
    
    UILabel* jianKang = [[UILabel alloc]initWithFrame:CGRectMake(65, 1, 80, 15)];
    jianKang.text = @"健康指导";
    jianKang.font = [UIFont boldSystemFontOfSize:15];
    jianKang.textColor = [UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0];
    jianKang.center = CGPointMake(jianKang.center.x, healthImgView.center.y);
    
    _healthLableL = [[UILabel alloc]initWithFrame:CGRectMake(220, 1, 70, 45)];
    _healthLableL.text = @"0";
    _healthLableL.textAlignment = NSTextAlignmentRight;
    _healthLableL.font = [UIFont boldSystemFontOfSize:45];
    _healthLableL.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    _healthLableL.center = CGPointMake(_healthLable.center.x, healthImgView.center.y);
    
    UILabel* people5 = [[UILabel alloc]initWithFrame:CGRectMake(294, _healthLable.frame.origin.y + 25, 15, 13)];
    people5.text = @"人";
    people5.font = [UIFont boldSystemFontOfSize:13];
    people5.textColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    
    _vFY = _vFY + healthImgView.frame.size.height + 10;
    UIImageView* healthLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, _vFY, 320, 1)];
    healthLine.image = [UIImage imageNamed:@"infoLine-200-1"];
    
    [_lBSView addSubview:bsImgView];
    [_lBSView addSubview:xueTang];
    [_lBSView addSubview:_bsLableL];
    [_lBSView addSubview:bsLine];
    [_lBSView addSubview:people1];
    [_changeWorkL addSubview:_lBSView];
    
    [_lBPView addSubview:bpImgView];
    [_lBPView addSubview:xueYa];
    [_lBPView addSubview:_bpLableL];
    [_lBPView addSubview:bpLine];
    [_lBPView addSubview:people2];
    [_changeWorkL addSubview:_lBPView];
    
    [_lBMIView addSubview:weightImgView];
    [_lBMIView addSubview:tiZhong];
    [_lBMIView addSubview:_weightLableL];
    [_lBMIView addSubview:weightLine];
    [_lBMIView addSubview:people3];
    [_changeWorkL addSubview:_lBMIView];
    
    [_changeWorkL addSubview:appointImgView];
    [_changeWorkL addSubview:menZhen];
    [_changeWorkL addSubview:_appointLableL];
    [_changeWorkL addSubview:appointLine];
    [_changeWorkL addSubview:people4];
    
    [_changeWorkL addSubview:healthImgView];
    [_changeWorkL addSubview:jianKang];
    [_changeWorkL addSubview:_healthLableL];
    [_changeWorkL addSubview:healthLine];
    [_changeWorkL addSubview:people5];
    
    [_scrollView addSubview:_changeWorkL];
}

#pragma mark-
#pragma mark Push
-(void)pushBS
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)pushBP
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)pushBMI
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)pushAppoint
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)pushHealth
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)pushManage
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark-
#pragma mark Date
-(void)initDateView
{
    for (int i = 0; i < 7; i++)
    {
        UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(320/7*i, 13, 320/7, 15)];
        lab.font = [UIFont boldSystemFontOfSize:15];
        lab.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
        lab.backgroundColor = [UIColor clearColor];
        NSString* week;
        switch (i) {
            case 0:{
                week=@"日";
                break;
            }
            case 1:{
                week=@"一";
                break;
            }
            case 2:{
                week=@"二";
                break;
            }
            case 3:{
                week=@"三";
                break;
            }
            case 4:{
                week=@"四";
                break;
            }
            case 5:{
                week=@"五";
                break;
            }
            case 6:{
                week=@"六";
                break;
            }
                
                
            default:
                break;
        }
        lab.text = [NSString stringWithFormat:@"%@",week];
        lab.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:lab];
    }
    
    NSMutableArray* tempArr = [self switchDay];
    
    for (int i = 0; i < 7; i++)
    {
        UIButton* lab = [[UIButton alloc]initWithFrame:CGRectMake(320/7*i, 0, 320/7, 40)];
        lab.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [lab setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        lab.backgroundColor = [UIColor clearColor];
        [lab setTitle:[tempArr objectAtIndex:i] forState:UIControlStateNormal];
        [lab addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
        if ([lab.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%d",[CalendarDateUtil getCurrentDay]]])
        {
            [lab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [lab setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            lab.tag = 0;
            _btnSelectDate = i;
        }
        [_btnArray addObject:lab];
        [_dateView addSubview:lab];
    }
    //设置tag
    for (int i = 0; i < _btnSelectDate; i++)
    {
        int tagInt = i - _btnSelectDate;
        UIButton* tempBtn = [_btnArray objectAtIndex:i];
        tempBtn.tag = tagInt;
    }
    for (int i = 1; i < 7 - _btnSelectDate; i++)
    {
        int tagInt = i;
        UIButton* tempBtn = [_btnArray objectAtIndex:_btnSelectDate + i];
        tempBtn.tag = tagInt;
    }
    
    
    for (int i = 0; i < 7; i++)
    {
        UIButton* lab = [[UIButton alloc]initWithFrame:CGRectMake(320/7*i, 0, 320/7, 40)];
        lab.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [lab setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        lab.backgroundColor = [UIColor clearColor];
        [lab setTitle:[tempArr objectAtIndex:i] forState:UIControlStateNormal];
        [lab addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
        if ([lab.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%d",[CalendarDateUtil getCurrentDay]]])
        {
            [lab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [lab setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
        }
        [_changeBtnArrayR addObject:lab];
        [_changeDateR addSubview:lab];
    }
    for (int i = 0; i < 7; i++)
    {
        UIButton* lab = [[UIButton alloc]initWithFrame:CGRectMake(320/7*i, 0, 320/7, 40)];
        lab.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [lab setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        lab.backgroundColor = [UIColor clearColor];
        [lab setTitle:[tempArr objectAtIndex:i] forState:UIControlStateNormal];
        [lab addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
        if ([lab.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%d",[CalendarDateUtil getCurrentDay]]])
        {
            [lab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [lab setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
        }
        [_changeBtnArrayL addObject:lab];
        [_changeDateL addSubview:lab];
    }
    
    [_scrollView addSubview:_changeDateR];
    [_scrollView addSubview:_changeDateL];
    [_scrollView addSubview:_dateView];
}

-(NSMutableArray*)switchDay
{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    
    int head = 0;
    int foot = 0;
    switch ([self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]]) {
        case 1:{
            head = 0;
            foot = 6;
            break;
        }
        case 2:{
            head = 1;
            foot = 5;
            break;
        }
        case 3:{
            head = 2;
            foot = 4;
            break;
        }
        case 4:{
            head = 3;
            foot = 3;
            break;
        }
        case 5:{
            head = 4;
            foot = 2;
            break;
        }
        case 6:{
            head = 5;
            foot = 1;
            break;
        }
        case 7:{
            head = 6;
            foot = 0;
            break;
        }
            
            
        default:
            break;
    }
    
    NSLog(@"%d , %d", head, foot);
    
    //    NSLog(@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:-1]]);
    
    for (int i = -head; i < 0; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:i]]];
        [array addObject:str];
    }
    
    [array addObject:[NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:0]]]];
    
    //sy 添加日期
    int tempNum = 1;
    for (int i = 0; i < foot; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:tempNum]]];
        [array addObject:str];
        tempNum++;
    }
    
    NSLog(@"weekArray = %d", [array count]);
    
    return array;
}

-(NSInteger)weekDate:(NSDate*)date
{
    // 获取当前年月日和周几
    //    NSDate *_date=[NSDate date];
    NSCalendar *_calendar=[NSCalendar currentCalendar];
    NSInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents *com=[_calendar components:unitFlags fromDate:date];
    NSString *_dayNum=@"";
    NSInteger dayInt = 0;
    switch ([com weekday]) {
        case 1:{
            _dayNum=@"日";
            dayInt = 1;
            break;
        }
        case 2:{
            _dayNum=@"一";
            dayInt = 2;
            break;
        }
        case 3:{
            _dayNum=@"二";
            dayInt = 3;
            break;
        }
        case 4:{
            _dayNum=@"三";
            dayInt = 4;
            break;
        }
        case 5:{
            _dayNum=@"四";
            dayInt = 5;
            break;
        }
        case 6:{
            _dayNum=@"五";
            dayInt = 6;
            break;
        }
        case 7:{
            _dayNum=@"六";
            dayInt = 7;
            break;
        }
            
            
        default:
            break;
    }
    
    //    _scrollDate
    //    + (NSInteger)getMonthWithDate:(NSDate*)date;
    //    + (NSInteger)getDayWithDate:(NSDate*)date;
    //    + (NSDate*)dateSinceNowWithInterval:(NSInteger)dayInterval;
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyy年MM月dd日"];
    NSString* dateStr = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_scrollDate + _btnDate]];
    
//    _nowDateString = [[NSString alloc]initWithFormat:@"%@ 星期%@", dateStr, _dayNum];
    _nowDateString = [[NSString alloc]initWithFormat:@"%@", dateStr];
    dateLable.text = _nowDateString;
    NSLog(@"week = %@", _dayNum);
    
    return dayInt;
}

-(void)selectData:(id)sender
{
    UIButton* sendBtn = sender;
    NSLog(@"btn = %@", sendBtn.titleLabel.text);
    NSLog(@"btn.tag = %d", sendBtn.tag);
    
    for (int i = 0; i < [_btnArray count]; i++)
    {
        UIButton* tmpBtn = [_btnArray objectAtIndex:i];
        [tmpBtn setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if ([tmpBtn.titleLabel.text isEqualToString:sendBtn.titleLabel.text])
        {
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
    }
    if ([sendBtn.titleLabel.text isEqualToString:@"29"])
    {
        _bsLable.text = @"0";
        _bpLable.text = @"0";
    }
    else
    {
        _bsLable.text = @"0";
        _bpLable.text = @"0";
    }
    
    
    _btnDate = sendBtn.tag;
    
    //按日期确定星期
    
    [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate]];
    
    NSLog(@"%@",_nowDateString);
    
    
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMdd"];
    _timeString = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]]; // _scrollDate
    
    [self httpFuction];
}

#pragma mark -
#pragma mark setButtonTitle
-(void)setBtnTitle  // 修改Btn的日期
{
    int chooseInt = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1;
    
    for (int i = 0; i < [_btnArray count]; i++)
    {
        [[_btnArray objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
    }
}
-(void)setBtnTitleR
{
    int chooseInt = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1;
    for (int i = 0; i < [_changeBtnArrayR count]; i++)
    {
        [[_changeBtnArrayR objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
        
        UIButton* tmpBtn = [_changeBtnArrayR objectAtIndex:i];
        [tmpBtn setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (_btnSelectDate == i)
        {
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
    }
}
-(void)setBtnTitleL
{
    int chooseInt = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1;
    for (int i = 0; i < [_changeBtnArrayL count]; i++)
    {
        [[_changeBtnArrayL objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
        
        UIButton* tmpBtn = [_changeBtnArrayL objectAtIndex:i];
        [tmpBtn setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (_btnSelectDate == i)
        {
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
    }
}

#pragma mark -
#pragma mark UISwipeGestureRecognizer
-(void)initSwipeGestureRecognizerLeft
{
    UISwipeGestureRecognizer *oneFingerSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeUp:)];
    
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_dateView addGestureRecognizer:oneFingerSwipeUp];
}
-(void)initSwipeGestureRecognizerLeft2
{
    UISwipeGestureRecognizer *oneFingerSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeUp:)];
    
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_workView addGestureRecognizer:oneFingerSwipeUp];
}
-(void)initSwipeGestureRecognizerRight
{
    UISwipeGestureRecognizer *oneFingerSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeDown:)];
    
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionRight];
    [_dateView addGestureRecognizer:oneFingerSwipeUp];
}
-(void)initSwipeGestureRecognizerRight2
{
    UISwipeGestureRecognizer *oneFingerSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeDown:)];
    
    [oneFingerSwipeUp setDirection:UISwipeGestureRecognizerDirectionRight];
    [_workView addGestureRecognizer:oneFingerSwipeUp];
}

- (void)oneFingerSwipeUp:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:[self view]];
    NSLog(@"Swipe up - start location: %f,%f", point.x, point.y);
    
    _scrollDate += 7;
    
    _changeWeek += 7;
    [self setBtnTitleR];
    [self workViewR];
    NSDateFormatter *scDateformat=[[NSDateFormatter  alloc]init];
    [scDateformat setDateFormat:@"yyyyMMdd"];
//    NSString* scollTime = [scDateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]];
//    [self timeHidenButton:scollTime];
    
    CGRect oldFrame = _dateView.frame;
    CGRect oldFrameWork = _workView.frame;
    CGRect changeFrameDate = _changeDateR.frame;
    CGRect changeFrameWork = _changeWorkR.frame;
    
    [UIView animateWithDuration:0.75f
                            delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction|
                                    UIViewAnimationOptionBeginFromCurrentState)
                        animations:^(void) {
                            [_dateView setFrame:CGRectMake(-320, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height)];
                            [_workView setFrame:CGRectMake(-320, oldFrameWork.origin.y, oldFrameWork.size.width, oldFrameWork.size.height)];
                            [_changeDateR setFrame:CGRectMake(0, changeFrameDate.origin.y, changeFrameDate.size.width, changeFrameDate.size.height)];
                            [_changeWorkR setFrame:CGRectMake(0, changeFrameWork.origin.y, changeFrameWork.size.width, changeFrameWork.size.height)];
                        }
                        completion:^(BOOL finished) {
                            [_dateView setFrame:CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height)];
                            [_workView setFrame:CGRectMake(oldFrameWork.origin.x, oldFrameWork.origin.y, oldFrameWork.size.width, oldFrameWork.size.height)];
                            [_changeDateR setFrame:changeFrameDate];
                            [_changeWorkR setFrame:changeFrameWork];
                            [self setBtnTitle];
                            [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate]];

                            NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
                            [dateformat setDateFormat:@"yyyyMMdd"];
                            _timeString = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]];
    
                            [self httpFuction];
                            
                        }];
    
}
- (void)oneFingerSwipeDown:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer locationInView:[self view]];
    NSLog(@"Swipe up - start location: %f,%f", point.x, point.y);
    
    _scrollDate -= 7;
    
    _changeWeek -= 7;
    //    [self setBtnTitle];
    [self setBtnTitleL];
    [self workViewL];
    NSDateFormatter *scDateformat=[[NSDateFormatter  alloc]init];
    [scDateformat setDateFormat:@"yyyyMMdd"];
//    NSString* scollTime = [scDateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]];
//    [self timeHidenButton:scollTime];
    
    
    CGRect oldFrame = _dateView.frame;
    CGRect oldFrameWork = _workView.frame;
    CGRect changeFrameDate = _changeDateL.frame;
    CGRect changeFrameWork = _changeWorkL.frame;
    
    [UIView animateWithDuration:0.75f
                            delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction|
                                    UIViewAnimationOptionBeginFromCurrentState)
                        animations:^(void) {
                            [_dateView setFrame:CGRectMake(320, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height)];
                            [_workView setFrame:CGRectMake(320, oldFrameWork.origin.y, oldFrameWork.size.width, oldFrameWork.size.height)];
                            [_changeDateL setFrame:CGRectMake(0, changeFrameDate.origin.y, changeFrameDate.size.width, changeFrameDate.size.height)];
                            [_changeWorkL setFrame:CGRectMake(0, changeFrameWork.origin.y, changeFrameWork.size.width, changeFrameWork.size.height)];
                        }
                        completion:^(BOOL finished) {
                            [_dateView setFrame:CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height)];
                            [_workView setFrame:CGRectMake(oldFrameWork.origin.x, oldFrameWork.origin.y, oldFrameWork.size.width, oldFrameWork.size.height)];
                            [_changeDateL setFrame:changeFrameDate];
                            [_changeWorkL setFrame:changeFrameWork];
                            [self setBtnTitle];
                            [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate]];

                            NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
                            [dateformat setDateFormat:@"yyyyMMdd"];
                            _timeString = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]];

                            [self httpFuction];

                        }];
    
}


#pragma mark -
#pragma mark TimeHidenButton

-(void)timeHidenButton:(NSString*)timeStr
{
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMdd"];
    NSString* nowTimeStr = [dateformat stringFromDate:[NSDate date]];
    int nowTime = [nowTimeStr integerValue];
    int selectTime = [timeStr integerValue];
    
    if (selectTime > nowTime)
    {
        _cBSView.hidden = YES;
        _cBPView.hidden = YES;
        _cBMIView.hidden = YES;
        _lBSView.hidden = YES;
        _lBPView.hidden = YES;
        _lBMIView.hidden = YES;
        _rBSView.hidden = YES;
        _rBPView.hidden = YES;
        _rBMIView.hidden = YES;
        [_workView setFrame:CGRectMake(0, 146 - 61*3, 320, 460)];
        [_changeWorkR setFrame:CGRectMake(320, 146 - 61*3, 320, 460)];
        [_changeWorkL setFrame:CGRectMake(-320, 146 - 61*3, 320, 460)];
    }
    else
    {
        _cBSView.hidden = NO;
        _cBPView.hidden = NO;
        _cBMIView.hidden = NO;
        _lBSView.hidden = NO;
        _lBPView.hidden = NO;
        _lBMIView.hidden = NO;
        _rBSView.hidden = NO;
        _rBPView.hidden = NO;
        _rBMIView.hidden = NO;
        [_workView setFrame:CGRectMake(0, 146, 320, 460)];
        [_changeWorkR setFrame:CGRectMake(320, 146, 320, 460)];
        [_changeWorkL setFrame:CGRectMake(-320, 146, 320, 460)];
    }
}



#pragma mark -
#pragma mark request delegate

-(void)httpFuction
{
    NSLog(@"%s",__FUNCTION__);
}

@end

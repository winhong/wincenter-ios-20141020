//
//  chatLineController.m
//  doubleChatline
//
//  Created by Z on 14-5-26.
//  Copyright (c) 2014年 carlsworld. All rights reserved.
//

#import "DoubleLineChartVC.h"
#import "chatView.h"
#define IPHONE_WIDTH 69

@interface DoubleLineChartVC ()
{
    
    UISegmentedControl* segmentControl;
    chatView* chat;
    UIView* dayView;
    UIView* dateView;
    UILabel* dateLab;
    int goD;
    int goW;
    int goM;
    
}
@end

@implementation DoubleLineChartVC

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor blackColor];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    UIImage* img = [UIImage imageNamed:@"guide_background.jpg"];
    UIImageView* imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    imgView.image = img;
    [self.view addSubview:imgView];
    
    segmentControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(15, IPHONE_WIDTH+410, 290, 30)];
    [segmentControl insertSegmentWithTitle:@"日" atIndex:0 animated:YES];
    [segmentControl insertSegmentWithTitle:@"周" atIndex:1 animated:YES];
    [segmentControl insertSegmentWithTitle:@"月" atIndex:2 animated:YES];
    [segmentControl insertSegmentWithTitle:@"年" atIndex:3 animated:YES];
    [segmentControl setSelectedSegmentIndex:0];
    [segmentControl setEnabled:NO forSegmentAtIndex:3];
    [segmentControl setTintColor: [UIColor whiteColor]];
    [segmentControl setAlpha:.5];
    [segmentControl setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
    segmentControl.segmentedControlStyle = UISegmentedControlStylePlain;
    [self.view addSubview:segmentControl];
    
    [segmentControl addTarget:self action:@selector(controlPress:) forControlEvents:UIControlEventValueChanged];
    [self controlPressOne];
    
//    [self drawLineWithCount];
    // Do any additional setup after loading the view.
}

- (void)initDateView
{
    if(!dateView){
        dateView = [[UIView alloc]initWithFrame:CGRectMake(15, segmentControl.frame.origin.y-segmentControl.frame.size.height-20, 290, 35)];
        dateView.opaque = NO;
        [self.view addSubview:dateView];
        
        UIImageView* imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, dateView.frame.size.width, dateView.frame.size.height)];
        imageV.image = [UIImage imageNamed:@"dh"];
        [dateView addSubview:imageV];
        
        dateLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, dateView.frame.size.width-100, 25)];
        [dateLab setBackgroundColor:[UIColor clearColor]];
        [dateLab setTextColor:[UIColor whiteColor]];
        [dateLab setFont:[UIFont fontWithName:@"Arial" size:15]];
        [dateLab setTextAlignment:NSTextAlignmentCenter];
        [dateView addSubview:dateLab];
        
        for(int i=0; i<2; i++){
            UIImage* image =[UIImage imageNamed:[NSString stringWithFormat:@"go_%d", i]];
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(250*i, 0, image.size.width, image.size.height);
            btn.tag = i;
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(goOrBack:) forControlEvents:UIControlEventTouchUpInside];
            [dateView addSubview:btn];
        }
    }
    
    for(int i=0; i<5; i++){
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(5,196+i*45, 30, 20)];
        [label setText:[NSString stringWithFormat:@"%d", 40-i*10]];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:11]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:label];
    }
}

- (void)goOrBack:(UIButton* )btn
{
    for(id obj in chat.subviews){
        if([obj isKindOfClass:[InfoView class]]){
            [obj removeFromSuperview];
        }
    }
    if(chat.lines){
        [chat.lines removeAllObjects];
        [chat.points removeAllObjects];
        [dayView removeFromSuperview];
        dayView = nil;
        [chat setNeedsDisplay];
    }
    if(btn.tag==1){
        switch ([segmentControl selectedSegmentIndex]) {
            case 0:{
                goD++;
                
                [dateLab setText:[self returnCurrentDay:goD]];
                [self readyDrawLineWithTip:0];
                break;
            }
            case 1:{
                goW++;
                [dateLab setText:[self returnWeekDayWithD:[self getCurrentTimeWith:week] W:goW]];
                [self readyDrawLineWithTip:1];
                break;
            }
            case 2:{
                goM++;
                [dateLab setText:[self returnMonthDayWithM:[self getCurrentTimeWith:month] andDay:[self getCurrentTimeWith:day] W:goM]];
                //                [self readyDrawLineWithTip:2];
                break;
            }
            case 3:{
                
            }
            default:
                break;
        }
    }else{
        
        switch ([segmentControl selectedSegmentIndex]) {
            case 0:{
                goD--;
                [dateLab setText:[self returnCurrentDay:goD]];
                [self readyDrawLineWithTip:0];
                break;
            }
            case 1:{
                goW--;
                [dateLab setText:[self returnWeekDayWithD:[self getCurrentTimeWith:week] W:goW]];
                [self readyDrawLineWithTip:1];
                break;
            }
            case 2:{
                goM--;
                [dateLab setText:[self returnMonthDayWithM:[self getCurrentTimeWith:month] andDay:[self getCurrentTimeWith:day] W:goM]];
                //                [self readyDrawLineWithTip:2];
                break;
            }
            case 3:{
                
            }
            default:
                break;
        }
    }
}
//获取当前年月日，星期
- (int)getCurrentTimeWith:(State)state
{
    NSDate* date = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit) fromDate:date];
    switch (state) {
        case year:{
            return [comps year];
        }
            break;
        case month:{
            return [comps month];
            break;
        }
        case day:{
            return [comps day];
            break;
        }
        case week:{
            return [comps weekday]-1>0?[comps weekday]-1:7;
            break;
        }
        default:
            break;
    }
}

- (NSString* )returnCurrentDay:(int)d
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:d*24*60*60];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd"];
    NSString* str = [formatter stringFromDate:date];
    return [NSString stringWithFormat:@"%@月%@日",[[str componentsSeparatedByString:@"-"] objectAtIndex:0], [[str componentsSeparatedByString:@"-"] objectAtIndex:1]];
}

//返回本周的日期范围
- (NSString* )returnWeekDayWithD:(int)w W:(int)n
{
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:60*60*24*(n*7-w+1)];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:60*60*24*(n*7-w+7)];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd"];
    NSString* str1 = [formatter stringFromDate:date1];
    NSString* str2 = [formatter stringFromDate:date2];
    return [NSString stringWithFormat:@"%@月%@日 - %@月%@日", [[str1 componentsSeparatedByString:@"-"] objectAtIndex:0], [[str1 componentsSeparatedByString:@"-"] objectAtIndex:1], [[str2 componentsSeparatedByString:@"-"] objectAtIndex:0], [[str2 componentsSeparatedByString:@"-"] objectAtIndex:1]];
}

int backDaysM(int m){
    switch (m) {
        case 2:{
            return 28;
            break;
        }
        case 4:
        case 6:
        case 9:
        case 11:{
            return 30;
            break;
        }
        default:
            return 31;
            break;
    }
    
}

- (int)backDaysWithM:(int)m andW:(int)w
{
    int days=0;
    if(w>0){
        for(int i=1; i<=w; i++){
            m++;
            if(m>12)m=1;
            days+=backDaysM(m);
        }
    }else if(w<0){
        for(int i=1; i<=(-w); i++){
            m--;
            if(m<=0)m=12;
            days-=backDaysM(m);
        }
    }else{
        days = 0;
    }
    return days;
}

- (int)backaDaysWithM:(int)m andW:(int)w
{
    int days=0;
    if(w>0){
        for(int i=0; i<w; i++){
            if(i!=0)m++;
            if(m>12)m=1;
            days+=backDaysM(m);
        }
    }else if(w<0){
        for(int i=0; i<(-w); i++){
            if(i!=0)m--;
            if(m<=0){
                m=12;
            }
            days-=backDaysM(m);
        }
    }else{
        days = 0;
    }
    return days;
}

//返回当月的日期范围
- (NSString* )returnMonthDayWithM:(int)m andDay:(int)d W:(int)w
{
    int day=backDaysM(m);
    int days=0;
    int days2=0;
    if(w>0){
        days = [self backaDaysWithM:m andW:w];
        days2 = [self backDaysWithM:m andW:w];
    }else{
        days = [self backDaysWithM:m andW:w];
        days2 = [self backaDaysWithM:m andW:w];
    }
    
    NSLog(@"%d-%d", days, days2);
    NSDate* date1 = [NSDate dateWithTimeIntervalSinceNow:60*60*24*(days-d+1)];
    NSDate* date2 = [NSDate dateWithTimeIntervalSinceNow:60*60*24*(days2+day-d)];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd"];
    NSString* str1 = [formatter stringFromDate:date1];
    NSString* str2 = [formatter stringFromDate:date2];
    return [NSString stringWithFormat:@"%@月%@日 - %@月%@日", [[str1 componentsSeparatedByString:@"-"] objectAtIndex:0], [[str1 componentsSeparatedByString:@"-"] objectAtIndex:1], [[str2 componentsSeparatedByString:@"-"] objectAtIndex:0], [[str2 componentsSeparatedByString:@"-"] objectAtIndex:1]];
}
//根据按钮返回dateView日期的值
- (NSString* )returnCurrentTimeStrWithTip:(int)tip
{
    switch (tip) {
        case 0:{
            return [self returnCurrentDay:0];
            break;
        }
        case 1:{
            return [self returnWeekDayWithD:[self getCurrentTimeWith:week] W:0];
            break;
        }
        case 2:{
            return [self returnMonthDayWithM:[self getCurrentTimeWith:month] andDay:[self getCurrentTimeWith:day] W:0];
            break;
        }
        case 3:{
            break;
        }
        default:
            return nil;
            break;
    }
    return nil;
}

- (NSArray* )returnPointXandYWithTip:(int)tip
{
    NSMutableArray* bfPoints = [[NSMutableArray alloc]init];
    NSMutableArray* afPoints = [[NSMutableArray alloc]init];
    int gap = chat.frame.size.width/([self rePointCountWithTip:tip]-2);
    if(([self rePointCountWithTip:tip]-2)*gap>=250){
        gap-=2;
    }
    for(int i=0; i<[self rePointCountWithTip:tip]-1; i++){
        CGPoint point1 =CGPointMake(1+gap*i, arc4random()%180);
        CGPoint point2 =CGPointMake(1+gap*i, arc4random()%180+20);
        [bfPoints addObject:[NSValue valueWithCGPoint:point1]];
        [afPoints addObject:[NSValue valueWithCGPoint:point2]];
    }
    return [NSArray arrayWithObjects:bfPoints,afPoints, nil];
    
}

//根据tip画线
- (void)readyDrawLineWithTip:(int)tip
{
    [self initDateView];
    if(!chat){
        chat = [[chatView alloc]initWithFrame:CGRectMake(30, 190, 250, 210)];
        //        [chat setBackgroundColor:[UIColor blackColor]];
        chat.opaque= NO;
        [self.view addSubview:chat];
    }
    if(!dayView){
        dayView = [[UIView alloc]initWithFrame:CGRectMake(0, chat.frame.origin.y+chat.frame.size.height, [[UIScreen mainScreen] bounds].size.width, 10)];
        dayView.opaque = NO;
        [self.view addSubview:dayView];
    }
    if(!chat.lines.count){
        int gap = chat.frame.size.width/([self reLineCountWithTip:tip]-2);
        if(([self reLineCountWithTip:tip]-2)*gap>=250){
            gap-=2;
        }
        for(int i=0; i<[self reLineCountWithTip:tip]; i++){
            Line* line = [[Line alloc]init];
            if(i!=[self reLineCountWithTip:tip]-1){
                line.firstPoint = CGPointMake(1+gap*i, 0);
                line.secondPoint = CGPointMake(1+gap*i, 205);
                UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(25+gap*i, 0, 12, 10)];
                [lab setText:[self reWeeksWithDay:i UseTip:tip]];
                [lab setBackgroundColor:[UIColor clearColor]];
                [lab setTextColor:[UIColor whiteColor]];
                [lab setFont:[UIFont systemFontOfSize:12]];
                [dayView addSubview:lab];
            }else{
                line.firstPoint = CGPointMake(0, 200);
                line.secondPoint = CGPointMake(247, 200);
            }
            [chat.lines addObject:line];
        }
        
        int gap2 = chat.frame.size.width/([self rePointCountWithTip:tip]-2);
        if(([self rePointCountWithTip:tip]-2)*gap2>=250){
            gap2-=2;
        }
        chat.points = [[self returnPointXandYWithTip:tip] mutableCopy];
        //        if([chat.points count]){
        //            for(int i=0; i<[[chat.points objectAtIndex:0] count]-1; i++){
        //                Line* line = [[Line alloc]init];
        //                line.firstPoint = [[[chat.points objectAtIndex:0] objectAtIndex:i] CGPointValue];
        //                line.secondPoint = [[[chat.points objectAtIndex:0] objectAtIndex:i+1] CGPointValue];
        //                line.color = [UIColor colorWithRed:123.0/255.0 green:207.0/255.0 blue:35.0/255.0 alpha:1.0];
        //                [chat.bfLines addObject:line];
        //            }
        //            for(int i=0; i<[[chat.points lastObject] count]-1; i++){
        //                Line* line = [[Line alloc]init];
        //                line.firstPoint = [[[chat.points lastObject] objectAtIndex:i] CGPointValue];
        //                line.secondPoint = [[[chat.points lastObject]objectAtIndex:i+1] CGPointValue];
        //                line.color = [UIColor colorWithRed:97.0/255.0 green:173.0/255.0 blue:244.0/255.0 alpha:1.0];
        //                [chat.afLines addObject:line];
        //            }
        if(tip==0){
            if([[chat.points objectAtIndex:0] count]<8){
                for(int i =0; i<[[chat.points objectAtIndex:0] count]; i++){
                    self.info = [[InfoView alloc]init];
                    [chat addSubview:self.info];
                    self.info.tapPoint = [[[chat.points objectAtIndex:0]objectAtIndex:i] CGPointValue];
                    self.info.infoLabel.text = @"09:23";
                    [self.info sizeToFit];
                }
            }else{
                chat.isDrawPoint=YES;
            }
            if([[chat.points lastObject] count]<8){
                for(int i =0; i<[[chat.points lastObject] count]; i++){
                    self.info = [[InfoView alloc]init];
                    [chat addSubview:self.info];
                    self.info.tapPoint = [[[chat.points lastObject]objectAtIndex:i] CGPointValue];
                    self.info.infoLabel.text = @"09:24";
                    [self.info sizeToFit];
                }
            }else{
                chat.isDrawPoint=YES;
            }
            [self.info setNeedsDisplay];
        }
        //
        //        }
        //        for(int i=0; i<[self rePointCountWithTip:tip]-2; i++){
        //            Line* line = [[Line alloc]init];
        //            if(chat.bfLines.count){
        //                line.firstPoint = [(Line*)[chat.bfLines objectAtIndex:i-1] secondPoint];
        //            }else
        //                line.firstPoint = CGPointMake(1+gap2*i, arc4random()%180);
        //            line.secondPoint = CGPointMake(1+gap2*(i+1), arc4random()%180);
        //            line.color = [UIColor colorWithRed:123.0/255.0 green:207.0/255.0 blue:35.0/255.0 alpha:1.0];
        //            [chat.bfLines addObject:line];
        //
        //            Line* line2 = [[Line alloc]init];
        //            line2.color = [UIColor colorWithRed:97.0/255.0 green:173.0/255.0 blue:244.0/255.0 alpha:1.0];
        //            line2.firstPoint = CGPointMake(line.firstPoint.x, line.firstPoint.y+20);
        //            line2.secondPoint = CGPointMake(line.secondPoint.x, line.secondPoint.y+20);
        //            [chat.afLines addObject:line2];
        //
        //            if(tip==0){
        //                self.info = [[InfoView alloc]init];
        //                [chat addSubview:self.info];
        //                self.info.tapPoint = line2.firstPoint;
        //                self.info.infoLabel.text = @"09:23";
        //                [self.info sizeToFit];
        //                [self.info setNeedsDisplay];
        //            }
        //
        //        }
        [chat setNeedsDisplay];
    }
}

- (int)rePointCountWithTip:(int)tip
{
    switch (tip) {
        case 0:{
            return 6;
            break;
        }
        case 1:{
            return 8;
            break;
        }
        case 2:{
            return 7;
            break;
        }
        case 3:{
            return 5;
        }
        default:
            return 0;
            break;
    }
}
//根据tip返回线的条数
- (int)reLineCountWithTip:(int)tip{
    switch (tip) {
        case 0:{
            return 3;
            break;
        }
        case 1:{
            return 8;
            break;
        }
        case 2:{
            return 7;
            break;
        }
        case 3:{
            return 4;
        }
        default:
            return 0;
            break;
    }
}

- (NSString* )reWeeksWithDay:(int)day UseTip:(int)tip
{
    if(tip==0){
        return nil;
    }else if(tip==1){
        switch (day) {
            case 0:{
                return @"一";
            }
                break;
            case 1:{
                return @"二";
                break;
            }
            case 2:{
                return @"三";
                break;
            }
            case 3:{
                return @"四";
                break;
            }
            case 4:{
                return @"五";
                break;
            }
            case 5:{
                return @"六";
                break;
            }
            case 6:{
                return @"日";
                break;
            }
            default:
                return @"无";
                break;
        }
        
    }else if(tip==2){
        return [NSString stringWithFormat:@"%d", 1+6*day];
    }else{
        return nil;
    }
}

- (void)controlPressOne
{
    for(id obj in chat.subviews){
        if([obj isKindOfClass:[InfoView class]]){
            [obj removeFromSuperview];
        }
    }
    if(chat.lines){
        [chat.lines removeAllObjects];
        [chat.points removeAllObjects];
        [dayView removeFromSuperview];
        dayView = nil;
        [chat setNeedsDisplay];
    }
    [self readyDrawLineWithTip:0];
    [dateLab setText:[self returnCurrentTimeStrWithTip:0]];
}

- (void)controlPress:(id)sender
{
    for(id obj in chat.subviews){
        if([obj isKindOfClass:[InfoView class]]){
            [obj removeFromSuperview];
        }
    }
    switch ([segmentControl selectedSegmentIndex]) {
        case 0:{
            if(chat.lines){
                [chat.lines removeAllObjects];
                [chat.points removeAllObjects];
                [dayView removeFromSuperview];
                dayView = nil;
                [chat setNeedsDisplay];
            }
            goW=0;
            goM=0;
            [self readyDrawLineWithTip:0];
            [dateLab setText:[self returnCurrentTimeStrWithTip:0]];
            break;
        }
        case 1:{
            if(chat.lines){
                [chat.lines removeAllObjects];
                [chat.points removeAllObjects];
                [dayView removeFromSuperview];
                dayView = nil;
                [chat setNeedsDisplay];
            }
            goD=0;
            goM=0;
            [self readyDrawLineWithTip:1];
            [dateLab setText:[self returnCurrentTimeStrWithTip:1]];
            break;
        }
        case 2:{
            if(chat.lines){
                [chat.lines removeAllObjects];
                [chat.points removeAllObjects];
                [dayView removeFromSuperview];
                dayView = nil;
                [chat setNeedsDisplay];
            }
            goD=0;
            goW=0;
            [self readyDrawLineWithTip:2];
            [dateLab setText:[self returnCurrentTimeStrWithTip:2]];
            break;
        }
        case 3:{
            NSLog(@"3");
            break;
        }
        default:
            break;
    }
}

- (void)drawLineWithCount
{
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 10, 10)];
    [self.view addSubview:imageView1];
    
    UIGraphicsBeginImageContext(imageView1.frame.size);   //开始画线
    [imageView1.image drawInRect:CGRectMake(0, 0, imageView1.frame.size.width, imageView1.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(line, [UIColor whiteColor].CGColor);
    CGPoint p = CGPointMake(0, 0);
    CGContextFillEllipseInRect(line, CGRectMake(p.x, p.y, 8, 8));
    imageView1.image = UIGraphicsGetImageFromCurrentImageContext();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

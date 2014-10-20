//
//  MPViewController.m
//  MPPlot
//
//  Created by Alex Manzella on 19/05/14.
//  Copyright (c) 2014 mpow. All rights reserved.
//

#import "MPPlotVC.h"

@interface MPPlotVC ()

@end

@implementation MPPlotVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    graph=[MPPlot plotWithType:MPPlotTypeGraph frame:self.container1.bounds];
    graph.fillColors=@[[UIColor colorWithRed:0.251 green:0.232 blue:1.000 alpha:1.000],[UIColor colorWithRed:0.282 green:0.945 blue:1.000 alpha:1.000]];
    graph.values=@[@2.5,@2.6,@2.8,@3,@3.3,@3,@3.6,@3.8,@3.2,@3.6,@4,@4.5];
    graph.graphColor=[UIColor colorWithRed:0.500 green:0.158 blue:1.000 alpha:1.000];
    graph.detailBackgroundColor=[UIColor colorWithRed:0.444 green:0.842 blue:1.000 alpha:1.000];
    graph.graphColor=[UIColor clearColor];

    [self.container1 addSubview:graph];
    
    
    graph2=[[MPGraphView alloc] initWithFrame:self.container1.bounds];
    graph2.waitToUpdate=YES;
    graph2.values=@[@2.5,@2.6,@2.8,@3,@2.8,@3.2,@3.6,@4,@4.5,@5,@4,@3.6];
    //graph2.fillColors=@[[UIColor orangeColor],[UIColor colorWithRed:1.000 green:0.827 blue:0.000 alpha:1.000]];
    graph2.graphColor=[UIColor redColor];
    graph2.curved=YES;
    [self.container1 addSubview:graph2];
    
    
    graph3=[[MPGraphView alloc] initWithFrame:self.container2.bounds];
    graph3.waitToUpdate=YES;
    [graph3 setAlgorithm:^CGFloat(CGFloat x) {
        return sin((double)x);
    } numberOfPoints:13];
    graph3.curved=YES;
    graph3.graphColor=[UIColor colorWithRed:0.500 green:0.158 blue:1.000 alpha:1.000];
    graph3.detailBackgroundColor=[UIColor colorWithRed:0.444 green:0.842 blue:1.000 alpha:1.000];
    [self.container2 addSubview:graph3];
    
    
    graph4=[[MPGraphView alloc] initWithFrame:self.container2.bounds];
    graph4.values=@[@2.5,@2.6,@2.8,@3.8,@3.2,@3.6,@4,@4.5,@2.6,@2.8,@3,@2.8,@3.2];
    graph4.fillColors=@[[UIColor orangeColor],[UIColor colorWithRed:1.000 green:0.827 blue:0.000 alpha:1.000]];
    graph4.graphColor=[UIColor redColor];
    graph4.curved=YES;
    [self.container2 addSubview:graph4];
    

    
    
    graph5=[MPPlot plotWithType:MPPlotTypeBars frame:self.container3.bounds];
    graph5.waitToUpdate=YES;
    graph5.detailView=(UIView <MPDetailView> *)[self customDetailView];
    [graph5 setAlgorithm:^CGFloat(CGFloat x) {
        return tan(x);
    } numberOfPoints:8];
    graph5.graphColor=[UIColor colorWithRed:0.120 green:0.806 blue:0.157 alpha:1.000];
    [self.container3 addSubview:graph5];
    

}


- (UIView *)customDetailView{
    
    UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor blueColor];
    label.backgroundColor=[UIColor whiteColor];
    label.layer.borderColor=label.textColor.CGColor;
    label.layer.borderWidth=.5;
    label.layer.cornerRadius=label.width*.5;
    label.adjustsFontSizeToFitWidth=YES;
    label.clipsToBounds=YES;
    
    return label;
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self animate:nil];

}

- (IBAction)animate:(id)sender{
    
    [graph2 animate];
    [graph3 animate];
    [graph5 animate];

}

@end

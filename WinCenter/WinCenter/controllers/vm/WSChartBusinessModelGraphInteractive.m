//
//  WSChartBusinessModelGraphInteractive.m
//  PowerPlot
//
//  Created by Dr. Wolfram Schroers on 3/8/14.
//  Copyright (c) 2014 NuAS. All rights reserved.
//

#import "WSChartBusinessModelGraphInteractive.h"

#import <PowerPlot_lib/PowerPlot.h>

@implementation WSChartBusinessModelGraphInteractive

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // Get the nodes and connections of the graph.
    WSData *graphTest = [WSData dataWithValues:@[@1.0, @0.5, @0.5, @0.2, @0.8, @0.25, @0.14]
                                       valuesX:@[@0.5, @0.2, @0.7, @0.9, @0.8, @0.4,  @0.1]
                                   annotations:@[@"Customer", @"Product", @"Marketing",
                                                 @"Development", @"Competition",
                                                 @"Customize", @"Operation"]];
    
    WSGraphConnections *connections = [[WSGraphConnections alloc] init];
    [connections addConnection:[WSConnection connectionFrom:1 to:0]];
    [connections addConnection:[WSConnection connectionFrom:2 to:0 strength:5]];
    [connections addConnection:[WSConnection connectionFrom:1 to:2]];
    [connections addConnection:[WSConnection connectionFrom:3 to:1 strength:5]];
    [connections addConnection:[WSConnection connectionFrom:4 to:0 strength:3]];
    [connections addConnection:[WSConnection connectionFrom:5 to:1 strength:2]];
    [connections addConnection:[WSConnection connectionFrom:6 to:1]];
    
    
    WSGraph *myGraph = [WSGraph graphWithNodes:graphTest
                                   connections:connections];
    
    // Create the chart.
    WSChart *gChart = [WSChart graphPlotWithFrame:self.view.bounds
                                            graph:myGraph
                                           colors:kColorWhite];
    
    // Manually add a gesture recognizer.
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(userDidTap:)];
    [gChart addGestureRecognizer:tapRecognizer];
        
    [self.view addSubview:gChart];
}

#pragma mark -

- (void)userDidTap:(UITapGestureRecognizer *)sender
{
    // Identify tap target.
    WSChart *theChart = (WSChart *)sender.view;
    
    WSPlotGraph *graph = (WSPlotGraph *)theChart[0].view;
    CGPoint tap = [sender locationInView:sender.view];
    NSInteger nodeNum = [graph nodeForPoint:tap];

    if (nodeNum > -1) {
        // User tapped on a node.
        WSData *graphTest = [WSData dataWithValues:@[@1.0, @0.5, @0.5, @0.2, @0.8, @0.25, @0.14]
                                           valuesX:@[@0.5, @0.2, @0.7, @0.9, @0.8, @0.4,  @0.1]
                                       annotations:@[@"Customer", @"Product", @"Marketing",
                                                     @"Development", @"Competition",
                                                     @"Customize", @"Operation"]];
        
        WSDatum *node = graphTest[nodeNum];
        NSLog([NSString stringWithFormat:@"Tap on: %@.",
                               node.annotation]);
    } else {
        // User tapped elsewhere.
        NSLog(@"Tap outside of nodes.");
    }
}

@end

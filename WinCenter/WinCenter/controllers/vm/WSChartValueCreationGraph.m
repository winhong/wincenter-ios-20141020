//
//  WSChartValueCreationGraph.m
//  PowerPlot
//
//  Created by Dr. Wolfram Schroers on 3/8/14.
//  Copyright (c) 2014 NuAS. All rights reserved.
//

#import "WSChartValueCreationGraph.h"

#import <PowerPlot_lib/PowerPlot.h>

@implementation WSChartValueCreationGraph

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // Create the graph model with nodes and connections.
    WSData *graphTest = [WSData dataWithValues:@[@2, @2, @2, @1, @1, @0.25, @-0.5]
                                       valuesX:@[@1, @2, @3, @1, @2, @3, @2]
                                   annotations:@[@"Content", @"Broker", @"Customer",
                                                 @"Knowledge", @"Transmission", @"Value",
                                                 @"Value = Knowledge*Transmission"]];
    
    WSGraphConnections *connections = [[WSGraphConnections alloc] init];
    [connections addConnection:[WSConnection connectionFrom:0 to:1]];
    [connections addConnection:[WSConnection connectionFrom:1 to:2 strength:5]];
    [connections addConnection:[WSConnection connectionFrom:3 to:0 strength:2]];
    [connections addConnection:[WSConnection connectionFrom:4 to:1 strength:3]];
    [connections addConnection:[WSConnection connectionFrom:5 to:2 strength:5]];
    [[connections connectionBetweenNode:5 andNode:2] setDirection:kGDirectionBoth];
    [connections addConnection:[WSConnection connectionFrom:3 to:5]];
    [connections addConnection:[WSConnection connectionFrom:4 to:5 strength:4]];
    
    WSGraph *myGraph = [WSGraph graphWithNodes:graphTest
                                   connections:connections];
    
    // Create the chart.
    WSChart *gChart = [WSChart graphPlotWithFrame:self.view.frame
                                            graph:myGraph
                                           colors:kColorDark];
    WSPlotGraph *graph = (WSPlotGraph *)gChart[0].view;
    
    // Configure node boxes individually.
    graph.propDefault.shadowEnabled = YES;
    graph.propDefault.outlineStroke = 0;
    graph.style = kCustomStyleIndividual;
    [graph distributeDefaultPropertiesToAllCustomDatum];
    ((WSNodeProperties *)graphTest[0].customDatum).nodeColor = [UIColor darkGrayColor];
    ((WSNodeProperties *)graphTest[3].customDatum).nodeColor = [UIColor darkGrayColor];
    ((WSNodeProperties *)graphTest[5].customDatum).nodeColor = [UIColor redColor];
    ((WSNodeProperties *)graphTest[6].customDatum).nodeColor = [UIColor CSSColorGreen];
    ((WSNodeProperties *)graphTest[6].customDatum).size = CGSizeMake(200, 40);
    
    [self.view addSubview:gChart];
}

@end

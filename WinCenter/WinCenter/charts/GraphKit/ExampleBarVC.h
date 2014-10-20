//
//  ExampleViewVC.h
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GraphKit.h"

@interface ExampleBarVC : UIViewController<GKBarGraphDataSource,GKLineGraphDataSource>

@property (nonatomic, weak) IBOutlet GKLineGraph *lineGraph;
@property (nonatomic, weak) IBOutlet GKBarGraph *barGraph;
@property (nonatomic, weak) IBOutlet GKBar *bar;

@property (nonatomic, strong) NSArray *barData;
@property (nonatomic, strong) NSArray *barLabels;

@property (nonatomic, strong) NSArray *lineData;
@property (nonatomic, strong) NSArray *lineLabels;

- (IBAction)onButtonAdd:(id)sender;
- (IBAction)onButtonMinus:(id)sender;
- (IBAction)onButtonChange:(id)sender;
- (IBAction)onButtonReset:(id)sender;
- (IBAction)onButtonFill:(id)sender;

@end

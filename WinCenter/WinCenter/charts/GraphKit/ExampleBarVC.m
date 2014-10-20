//
//  ExampleViewVC.m
//  GraphKit
//
//  Created by Michal Konturek on 16/04/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import "ExampleBarVC.h"

#import "GraphKit.h"

@interface ExampleBarVC ()

@property (nonatomic, assign) BOOL green;

@end

@implementation ExampleBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bar.animationDuration = 0.4;
    self.bar.percentage = 40;
    
    self.green = YES;
    
    self.barData = @[@65, @10, @40, @90, @50, @75];
    self.barLabels = @[@"US", @"UK", @"DE", @"PL", @"CN", @"JP"];
    
    //    self.barGraph.barWidth = 22;
    //    self.barGraph.barHeight = 140;
    //    self.barGraph.marginBar = 25;
    //    self.barGraph.animationDuration = 2.0;
    
    self.barGraph.dataSource = self;
    [self.barGraph draw];
    
    [self _setupExampleGraph];
    //    [self _setupTestingGraphLow];
    //    [self _setupTestingGraphHigh];
}

- (IBAction)onButtonAdd:(id)sender {
    self.bar.animated = YES;
    self.bar.percentage += 20;
}

- (IBAction)onButtonMinus:(id)sender {
    self.bar.percentage -= 20;
}

- (IBAction)onButtonChange:(id)sender {
    self.green = !self.green;
    self.bar.foregroundColor = (self.green) ? [UIColor gk_turquoiseColor] : [UIColor gk_amethystColor];;
}

- (IBAction)onButtonReset:(id)sender {
    [self.bar reset];
}


- (IBAction)onButtonFill:(id)sender {
    [self.barGraph draw];
    
    [self.lineGraph reset];
    [self.lineGraph draw];
}

//barGraph


#pragma mark - GKBarGraphDataSource

- (NSInteger)numberOfBars {
    return [self.barData count];
}

- (NSNumber *)valueForBarAtIndex:(NSInteger)index {
    return [self.barData objectAtIndex:index];
}

- (UIColor *)colorForBarAtIndex:(NSInteger)index {
    id colors = @[[UIColor gk_turquoiseColor],
                  [UIColor gk_peterRiverColor],
                  [UIColor gk_alizarinColor],
                  [UIColor gk_amethystColor],
                  [UIColor gk_emerlandColor],
                  [UIColor gk_sunflowerColor]
                  ];
    return [colors objectAtIndex:index];
}

//- (UIColor *)colorForBarBackgroundAtIndex:(NSInteger)index {
//    return [UIColor redColor];
//}

- (CFTimeInterval)animationDurationForBarAtIndex:(NSInteger)index {
    CGFloat percentage = [[self valueForBarAtIndex:index] doubleValue];
    percentage = (percentage / 100);
    return (self.barGraph.animationDuration * percentage);
}

- (NSString *)titleForBarAtIndex:(NSInteger)index {
    return [self.barLabels objectAtIndex:index];
}

//lineGraph

- (void)_setupExampleGraph {
    
    self.lineData = @[
                  @[@20, @40, @20, @60, @40, @140, @80],
                  @[@40, @20, @60, @100, @60, @20, @60],
                  @[@80, @60, @40, @160, @100, @40, @110],
                  @[@120, @150, @80, @120, @140, @100, @0],
                  //                  @[@620, @650, @580, @620, @540, @400, @0]
                  ];
    
    self.lineLabels = @[@"2001", @"2002", @"2003", @"2004", @"2005", @"2006", @"2007"];
    
    self.lineGraph.dataSource = self;
    self.lineGraph.lineWidth = 3.0;
    
    self.lineGraph.valueLabelCount = 6;
    
    [self.lineGraph draw];
}

- (void)_setupTestingGraphLow {
    
    /*
     A custom max and min values can be achieved by adding
     values for another line and setting its color to clear.
     */
    
    self.lineData = @[
                  @[@10, @4, @8, @2, @9, @3, @6],
                  @[@1, @2, @3, @4, @5, @6, @10]
                  ];
    
    self.lineLabels = @[@"2001", @"2002", @"2003", @"2004", @"2005", @"2006", @"2007"];
    
    self.lineGraph.dataSource = self;
    self.lineGraph.lineWidth = 3.0;
    
    //    self.lineGraph.startFromZero = YES;
    self.lineGraph.valueLabelCount = 10;
    
    [self.lineGraph draw];
}

- (void)_setupTestingGraphHigh {
    
    self.lineData = @[
                  @[@1000, @2000, @3000, @4000, @5000, @6000, @10000]
                  ];
    
    self.lineLabels = @[@"2001", @"2002", @"2003", @"2004", @"2005", @"2006", @"2007"];
    
    self.lineGraph.dataSource = self;
    self.lineGraph.lineWidth = 3.0;
    
    //    self.lineGraph.startFromZero = YES;
    self.lineGraph.valueLabelCount = 10;
    
    [self.lineGraph draw];
}

#pragma mark - GKLineGraphDataSource

- (NSInteger)numberOfLines {
    return [self.lineData count];
}

- (UIColor *)colorForLineAtIndex:(NSInteger)index {
    id colors = @[[UIColor gk_turquoiseColor],
                  [UIColor gk_peterRiverColor],
                  [UIColor gk_alizarinColor],
                  [UIColor gk_sunflowerColor]
                  ];
    return [colors objectAtIndex:index];
}

- (NSArray *)valuesForLineAtIndex:(NSInteger)index {
    return [self.lineData objectAtIndex:index];
}

- (CFTimeInterval)animationDurationForLineAtIndex:(NSInteger)index {
    return [[@[@1, @1.6, @2.2, @1.4] objectAtIndex:index] doubleValue];
}

- (NSString *)titleForLineAtIndex:(NSInteger)index {
    return [self.lineLabels objectAtIndex:index];
}


@end

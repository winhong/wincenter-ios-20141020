//
//  MZViewController.m
//  MZGraph
//
//  Created by Serghei Mazur on 11/26/13.
//  Copyright (c) 2013 Serghei Mazur. All rights reserved.
//

#import "MZViewController.h"

#import "iPadGraphView.h"
#import "iPhoneGraphView.h"

@interface MZViewController ()
@property (weak, nonatomic) IBOutlet UIView *container;
@property (nonatomic, retain) iPhoneGraphView *iPhoneGraph;
@property (nonatomic, retain) iPadGraphView *iPadGraph;
@end

@implementation MZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [self setupIphone];
    }else{
        [self setupIpad];
    }
}

- (void) setupIphone{
    
    _iPhoneGraph = [[iPhoneGraphView alloc]initWithFrame:self.container.bounds];
    
    _iPhoneGraph.fistArray = @[[NSNumber numberWithInt:12],[NSNumber numberWithInt:8],[NSNumber numberWithInt:1],[NSNumber numberWithInt:16],[NSNumber numberWithInt:19],[NSNumber numberWithInt:32],[NSNumber numberWithInt:22],[NSNumber numberWithInt:-12],[NSNumber numberWithInt:16],[NSNumber numberWithInt:19],[NSNumber numberWithInt:22],[NSNumber numberWithInt:32]];
    _iPhoneGraph.secondArray = @[[NSNumber numberWithInt:2],[NSNumber numberWithInt:-18],[NSNumber numberWithInt:-5],[NSNumber numberWithInt:12],[NSNumber numberWithInt:13],[NSNumber numberWithInt:30],[NSNumber numberWithInt:19],[NSNumber numberWithInt:-10],[NSNumber numberWithInt:10],[NSNumber numberWithInt:10],[NSNumber numberWithInt:32],[NSNumber numberWithInt:12]];
    
    //change style graph (Yes = For lines, No = For charts)
    [_iPhoneGraph setLinesGraph:NO];
    [self.container addSubview:_iPhoneGraph];
    
}

- (void) setupIpad{
    // For iPad
    
    _iPadGraph = [[iPadGraphView alloc]initWithFrame:self.container.bounds];
    _iPadGraph.fistArray = @[[NSNumber numberWithInt:12],[NSNumber numberWithInt:8],[NSNumber numberWithInt:1],[NSNumber numberWithInt:16],[NSNumber numberWithInt:19],[NSNumber numberWithInt:32],[NSNumber numberWithInt:22],[NSNumber numberWithInt:-12],[NSNumber numberWithInt:16],[NSNumber numberWithInt:19],[NSNumber numberWithInt:22],[NSNumber numberWithInt:32]];
    _iPadGraph.secondArray = @[[NSNumber numberWithInt:2],[NSNumber numberWithInt:-18],[NSNumber numberWithInt:-5],[NSNumber numberWithInt:12],[NSNumber numberWithInt:13],[NSNumber numberWithInt:30],[NSNumber numberWithInt:19],[NSNumber numberWithInt:-10],[NSNumber numberWithInt:10],[NSNumber numberWithInt:10],[NSNumber numberWithInt:32],[NSNumber numberWithInt:12]];
    
    //change style graph (Yes = For lines, No = For charts)
    [_iPadGraph setLinesGraph:NO];
    [self.container addSubview:_iPadGraph];
    
}


@end

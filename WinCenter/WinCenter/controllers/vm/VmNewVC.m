//
//  VmNewVC.m
//  wincenterDemo01
//
//  Created by huadi on 14-8-25.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmNewVC.h"

@interface VmNewVC ()
@property NSMutableArray *tempData;
@property NSMutableArray *sizeData;
@property NSMutableArray *networkData;
@end

@implementation VmNewVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tempData = [NSMutableArray new];
    self.sizeData = [NSMutableArray new];
    self.networkData = [NSMutableArray new];
    for (int i =0; i< 11; i++) {
        [self.tempData addObject:[NSString stringWithFormat:@"虚拟机模版－%d",i]];
        [self.sizeData addObject:[NSString stringWithFormat:@"规格－%d",i]];
        [self.networkData addObject:[NSString stringWithFormat:@"网络－%d",i]];
    }

//    self.vmTemp.text = self.tempData[0];
//
//    self.vmSize.text = self.sizeData[0];
//
//    self.vmNetwork.text = self.networkData[0];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.tempData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return self.tempData[row];
        case 1:
            return self.sizeData[row];
        case 2:
            return self.networkData[row];
        default:
            break;
    }
    return @"";
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    switch (component) {
        case 0:
            self.vmTemp.text = self.tempData[row];
            break;
        case 1:
            self.vmSize.text = self.sizeData[row];
            break;
        case 2:
            self.vmNetwork.text = self.networkData[row];
            break;
        default:
            break;
    }

}
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

//
//  VmNewVC.h
//  wincenterDemo01
//
//  Created by huadi on 14-8-25.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VmNewVC : UITableViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *vmTemp;
@property (weak, nonatomic) IBOutlet UILabel *vmSize;
@property (weak, nonatomic) IBOutlet UILabel *vmNetwork;
@property (weak, nonatomic) IBOutlet UIPickerView *vmNewPicker;

@end

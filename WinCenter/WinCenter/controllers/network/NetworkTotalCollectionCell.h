//
//  NetworkTotalCollectionCell.h
//  WinCenter
//
//  Created by 黄茂坚 on 14/10/27.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkTotalCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *vlan;
@property (weak, nonatomic) IBOutlet UILabel *ipSegment;
@property (weak, nonatomic) IBOutlet UILabel *ipTotal;
@property (weak, nonatomic) IBOutlet UILabel *ipUsable;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *ipUsed;
@property (weak, nonatomic) IBOutlet UIImageView *linkState;

@end

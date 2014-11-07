//
//  VmIsoCollectionCell.h
//  WinCenter
//
//  Created by 黄茂坚 on 14/11/7.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VmIsoCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *isoName;
@property (weak, nonatomic) IBOutlet UILabel *isoPath;
@property (weak, nonatomic) IBOutlet UILabel *isoSize;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end

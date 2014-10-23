//
//  HostVmMemoryTop5CellCollectionViewCell.h
//  WinCenter
//
//  Created by huadi on 14/10/23.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HostVmMemoryTop5CollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *blockColor;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *percent;
@property (weak, nonatomic) IBOutlet UILabel *size;

@end

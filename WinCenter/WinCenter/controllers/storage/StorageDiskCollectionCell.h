//
//  StorageDetailCell.h
//  wincenterDemo01
//
//  Created by huadi on 14-8-18.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StorageDiskCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *isASnapshot;
@property (weak, nonatomic) IBOutlet UILabel *size;
@property (weak, nonatomic) IBOutlet UILabel *belongsVM;
@property (weak, nonatomic) IBOutlet UITextView *belongsVM_textView;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UIImageView *share_image;

@end

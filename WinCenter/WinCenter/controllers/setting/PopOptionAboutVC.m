//
//  PopOptionAboutVC.m
//  WinCenter
//
//  Created by apple on 14/10/20.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "PopOptionAboutVC.h"
#import <ObjQREncoder/QREncoder.h>

@interface PopOptionAboutVC ()
@property (weak, nonatomic) IBOutlet UIView *qrImage;

@end

@implementation PopOptionAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[QREncoder encode:@"http://www.winhong.com/wap/"]];
    imageView.frame = self.qrImage.bounds;
    [imageView layer].magnificationFilter = kCAFilterNearest;
    [self.qrImage addSubview:imageView];
    
}

@end

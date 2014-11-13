//
//  BusinessDetailVC.m
//  wincenterDemo01
//
//  Created by huadi on 14-8-20.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "BusinessDetailInfoVC.h"
#import "BusinessVmCollectionVC.h"
#import "BusinessVmCollectionCell.h"
#import "VmContainerVC.h"

@interface BusinessDetailInfoVC ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *managerId;
@property (weak, nonatomic) IBOutlet UILabel *platform;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *createUser;
@property (weak, nonatomic) IBOutlet UITextView *desc;
@property (weak, nonatomic) IBOutlet UILabel *vmCount;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation BusinessDetailInfoVC

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"toBusinessVm"]){
        BusinessVmCollectionVC *vmCollectionVC = segue.destinationViewController;
        vmCollectionVC.businessVO = self.businessVO;
    }
}

- (void)viewDidLayoutSubviews{
    if(self.scrollView){
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            self.scrollView.contentSize = CGSizeMake(320, 700);
        }
    }
}

- (void)viewDidLoad
{
    for(UILabel *label in self.allLabels){
        label.text = @"";
    }
    self.view.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
    
    [self.scrollView addHeaderWithCallback:^{
        [self reloadData];
    }];
    [self reloadData];
}

- (IBAction)refreshAction:(id)sender {
    [self.scrollView headerBeginRefreshing];
}

-(void) reloadData{
    [self.businessVO getBusinessVOAsync:^(id object, NSError *error) {
        self.businessVO = object;
        [self refresh];
        [self.scrollView headerEndRefreshing];
        self.parentViewController.parentViewController.navigationItem.rightBarButtonItem.enabled = true;
    }];
}

- (void)refresh{
    self.name.text = self.businessVO.name;
    self.vmCount.text = [NSString stringWithFormat:@"%d",self.businessVO.vmNum];
    self.managerId.text = self.businessVO.managerId;
    self.platform.text = [self.businessVO sysSrc_text];
    self.createTime.text = [self.businessVO.createTime stringByReplacingOccurrencesOfString:@" 000" withString:@""];
    self.createUser.text = self.businessVO.createUser;
    self.desc.text = self.businessVO.desc;
}


@end

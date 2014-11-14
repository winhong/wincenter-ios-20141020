//
//  OptionsVC.m
//  wincenterDemo01
//
//  Created by huadi on 14-8-25.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "PopOptionsVC.h"
#import <TOWebViewController/TOWebViewController.h>
#import <THPinViewController/THPinViewController.h>
#import <REFrostedViewController/REFrostedViewController.h>

@interface PopOptionsVC ()
@property int remainingPinEntries;
@property NSString *correctPin;
@end

@implementation PopOptionsVC

- (IBAction)showMenu:(id)sender {
    [self.frostedViewController presentMenuViewController];
}


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
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
    }else{
        if(!self.navigationItem.leftBarButtonItem){
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showMenu:)];
        }
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.remainingPinEntries = 3;
    self.correctPin = @"1234";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSUInteger)pinLengthForPinViewController:(THPinViewController *)pinViewController
{
    return 4;
}

- (BOOL)pinViewController:(THPinViewController *)pinViewController isPinValid:(NSString *)pin
{
    if ([pin isEqualToString:self.correctPin]) {
        return YES;
    } else {
        self.remainingPinEntries--;
        return NO;
    }
}

- (BOOL)userCanRetryInPinViewController:(THPinViewController *)pinViewController
{
    return (self.remainingPinEntries > 0);
}

- (void)showPinView{
    THPinViewController *pinViewController = [[THPinViewController alloc] initWithDelegate:self];
    pinViewController.promptTitle = @"Enter PIN";
    pinViewController.promptColor = [UIColor darkTextColor];
    pinViewController.view.tintColor = [UIColor darkTextColor];
    pinViewController.hideLetters = YES;
    
    // for a solid color background, use this:
    pinViewController.backgroundColor = [UIColor whiteColor];
    
    // for a translucent background, use this:
    self.view.tag = THPinViewControllerContentViewTag;
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    pinViewController.translucentBackground = YES;
    
    [self presentViewController:pinViewController animated:YES completion:nil];
    
    // mandatory delegate methods
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row == 3){
            [self showPinView];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"PASSWORD"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)exitSystem:(id)sender {
    NSString *prompt;
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        prompt = @"感谢您的体验，确定要退出吗？";
    }else{
        prompt = @"确定要退出吗？";
    }
    
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"操作提示" message:prompt delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [view show];
}
@end

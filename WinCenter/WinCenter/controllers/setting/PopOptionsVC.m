//
//  OptionsVC.m
//  wincenterDemo01
//
//  Created by huadi on 14-8-25.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "PopOptionsVC.h"
#import <TOWebViewController/TOWebViewController.h>

@interface PopOptionsVC ()

@end

@implementation PopOptionsVC

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==2){
        if(indexPath.row==1){
            TOWebViewController *webView = [[TOWebViewController alloc] initWithURLString:@"http://support.winhong.com"];
            [self.navigationController pushViewController:webView animated:YES];
        }else if(indexPath.row==2){
            TOWebViewController *webView = [[TOWebViewController alloc] initWithURLString:@"https://192.168.100.147:8090/pages/help/helpWord.htm"];
            [self.navigationController pushViewController:webView animated:YES];

        }
    }
}
@end

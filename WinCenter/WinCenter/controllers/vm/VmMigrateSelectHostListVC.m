//
//  VmMigrateSelectHostListVC.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-27.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "VmMigrateSelectHostListVC.h"
#import "VmMigrateSelectHostListCell.h"
#import "VmMigrateVC.h"

@interface VmMigrateSelectHostListVC ()
@property NSMutableArray *hosts;
@property int selectedHostId;
@property NSString *selectedHostName;
@end

@implementation VmMigrateSelectHostListVC

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
    self.hosts = [NSMutableArray new];
    
    [super viewDidLoad];
    
    __unsafe_unretained typeof(self) week_self = self;
    
    [self.tableView addHeaderWithCallback:^{
        [week_self.hosts removeAllObjects];
        [week_self reloadData];
    }];
    [self.tableView addFooterWithCallback:^{
        [week_self reloadData];
    }];
    [self reloadData];
    
}

- (IBAction)refreshAction:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = false;
    [self.tableView headerBeginRefreshing];
}

-(void)reloadData{
    [self.vmVO vmGetMigrateTargets:^(id object, NSError *error) {
        for(VmMigrateTargetVO *targetVO in ((VmMigrateTargetsVO*)object).targets){
            for(VmMigrateTargetHostVO *hostVO in targetVO.hosts){
                if(hostVO.targetId!=self.vmVO.ownerHostId && hostVO.isFit){
                    [self.hosts addObject:hostVO];
                }
            }
        }
        [self.tableView headerEndRefreshing];
        [self.tableView footerFinishingLoading];
        [self.tableView reloadData];
        self.navigationItem.rightBarButtonItem.enabled = true;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hosts.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{    
    [self.delegate didSelecteded:self.hosts[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VmMigrateSelectHostListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VmMigrateSelectHostListCell" forIndexPath:indexPath];
    
    if(self.hosts.count==0) return cell;
    
    cell.textLabel.text = ((VmMigrateTargetHostVO*)self.hosts[indexPath.row]).targetName;
    
    return cell;
}



- (IBAction)done:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

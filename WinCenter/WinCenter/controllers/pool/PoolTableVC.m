//
//  PoolTableVC.m
//  WinCenter
//
//  Created by fengzj on 14/11/13.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "PoolTableVC.h"

@interface PoolTableVC ()
@property NSArray *dataList;
@property NSMutableArray *nameList;

@end

@implementation PoolTableVC

- (IBAction)exitAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)refreshAction:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = false;
    [self.tableView headerBeginRefreshing];
}


- (void)viewDidLoad {
    self.nameList = [[NSMutableArray alloc] initWithCapacity:0];
    [super viewDidLoad];
    
    __unsafe_unretained typeof(self) week_self = self;
    
    [self.tableView addHeaderWithCallback:^{
        [week_self.nameList removeAllObjects];
        [week_self reloadData];
    } dateKey:@"collection"];
    
    [self.tableView addFooterWithCallback:^{
        [week_self reloadData];
    }];

    [self reloadData];
}

-(void)reloadData{
    [[RemoteObject getCurrentDatacenterVO] getPoolListAsync:^(id object, NSError *error) {
        self.dataList = ((PoolListResult*)object).resourcePools;
        [self.nameList addObject:@"全部"];
        for(PoolVO *pool in self.dataList){
            [self.nameList addObject:pool.resourcePoolName];
        }
        [self.nameList addObject:@"游离物理主机"];
        [self.tableView headerEndRefreshing];
        [self.tableView footerFinishingLoading];
        [self.tableView reloadData];
        self.navigationItem.rightBarButtonItem.enabled = true;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.nameList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PoolTableCell" forIndexPath:indexPath];
    
    if(self.nameList.count==0) return cell;
    
    cell.textLabel.text = self.nameList[indexPath.row];
    if([cell.textLabel.text isEqualToString:self.currentName]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PoolVO *vo = nil;
    NSString *title = self.nameList[indexPath.row];
    if(indexPath.row>0 && indexPath.row<self.nameList.count-1){
        vo = self.dataList[indexPath.row-1];
    }
    [self.delegate didFinishedPoolSelect:vo withTitle:title];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

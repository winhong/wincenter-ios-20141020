//
//  DatacenterPopVC.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-29.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "DatacenterTableVC.h"
#import "DatacenterTableCell.h"

@interface DatacenterTableVC ()
@property NSMutableArray *datacenters;
@end

@implementation DatacenterTableVC

- (void)viewDidLoad
{
    self.datacenters = [[NSMutableArray alloc] initWithCapacity:0];
    
    [super viewDidLoad];
    
    __unsafe_unretained typeof(self) week_self = self;
    
    [self.tableView addHeaderWithCallback:^{
        [week_self.datacenters removeAllObjects];
        [week_self reloadData];
    }];
    [self.tableView addFooterWithCallback:^{
    }];
    [self reloadData];
}

- (void)reloadData{
    [DatacenterVO getDatacenterListAsync:^(id object, NSError *error) {
        [self.datacenters addObjectsFromArray:((DatacenterListResult*)object).dataCenters];
        [self.tableView headerEndRefreshing];
        [self.tableView footerFinishingLoading];
        [self.tableView reloadData];
    }];
}
- (IBAction)refreshAction:(id)sender {
    [self.tableView headerBeginRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datacenters.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DatacenterTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DatacenterCell" forIndexPath:indexPath];
    
    if(self.datacenters.count==0) return cell;
    
    DatacenterVO *vo = self.datacenters[indexPath.row];
    
    cell.name.text = vo.name;
    cell.ip.text = [NSString stringWithFormat:@"%@:%d", vo.wceIpAddress, vo.wcePort];
    if([[RemoteObject getCurrentDatacenterVO].name isEqualToString:vo.name]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate didFinished:self.datacenters[indexPath.row]];
}

@end

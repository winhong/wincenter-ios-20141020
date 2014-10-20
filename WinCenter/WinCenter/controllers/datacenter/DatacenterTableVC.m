//
//  DatacenterPopVC.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-29.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "DatacenterTableVC.h"

@interface DatacenterTableVC ()
@property NSArray *datacenters;
@end

@implementation DatacenterTableVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.datacenters = @[];
    
    [DatacenterVO getDatacenterListAsync:^(NSArray *allRemote, NSError *error) {
        self.datacenters = allRemote;
        [self.tableView reloadData];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datacenters.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DatacenterCell" forIndexPath:indexPath];
    
    DatacenterVO *vo = self.datacenters[indexPath.row];
    
    cell.textLabel.text = vo.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@:%d", vo.wceIpAddress, vo.wcePort];
    if([[RemoteObject getCurrentDatacenterVO].name isEqualToString:vo.name]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate didFinished:self];
}

@end

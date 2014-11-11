//
//  WarningInfoVC.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-26.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "PopWarningInfoVC.h"
#import "PopWarningInfoCell.h"
#import "PopWarningInfoCellForTime.h"


@interface PopWarningInfoVC ()

@end

@implementation PopWarningInfoVC

- (void)viewDidLoad
{
    self.dataList = [[NSMutableArray alloc] initWithCapacity:0];
    [super viewDidLoad];
    
    NSString *prefix = @"";
    if(self.remoteObject==nil){
        prefix = [RemoteObject getCurrentDatacenterVO].name;
    }else if([self.remoteObject isKindOfClass:PoolVO.class]){
        prefix = ((PoolVO*)self.remoteObject).resourcePoolName;
    }else if([self.remoteObject isKindOfClass:HostVO.class]){
        prefix = ((HostVO*)self.remoteObject).hostName;
    }else if([self.remoteObject isKindOfClass:StorageVO.class]){
        prefix = ((StorageVO*)self.remoteObject).storagePoolName;
    }else if([self.remoteObject isKindOfClass:VmVO.class]){
        prefix = ((VmVO*)self.remoteObject).name;
    }
    self.title = [NSString stringWithFormat:@"%@的告警信息", prefix];
    
    __unsafe_unretained typeof(self) week_self = self;
    
    [self.tableView addHeaderWithCallback:^{
        [week_self.dataList removeAllObjects];
        [week_self reloadData];
    }];
    
    [self.tableView addFooterWithCallback:^{
        [week_self reloadData];
    }];

    [self reloadData];
}

- (void)reloadData{
    [WarningInfoVO getWarningInfoListViaObject:self.remoteObject Async:^(id object, NSError *error) {
        [self.dataList addObjectsFromArray:((WarningInfoListResult*)object).alarms];
        [self.tableView headerEndRefreshing];
        if(self.dataList.count>=((WarningInfoListResult*)object).recordTotal){
            [self.tableView footerFinishingLoading];
        }else{
            [self.tableView footerEndRefreshing];
        }
        [self.tableView reloadData];
        self.navigationItem.rightBarButtonItem.enabled = true;
    } referTo:self.dataList];
}
- (IBAction)refreshAction:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = false;
    [self.tableView headerBeginRefreshing];
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //PopWarningInfoCellForTime *cell = [tableView dequeueReusableCellWithIdentifier:@"WarningInfoCellForTime" forIndexPath:indexPath];
    
    //cell.label1.text = warningVO.createTime;
    PopWarningInfoCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"WarningInfoCell" forIndexPath:indexPath];
    
    if(self.dataList.count==0) return cell2;
    
    WarningInfoVO *warningVO = self.dataList[indexPath.row];
    
    cell2.label1.text = warningVO.name;
    cell2.label2.text = warningVO.createTime;
    cell2.label3.text = warningVO.objectName;
    cell2.label4.text = warningVO.body;
    cell2.label5.text = [warningVO readed_text ];
    cell2.label5.textColor = [warningVO readed_Color];

//    switch (indexPath.row) {
//        case 0:{
//            PopWarningInfoCellForTime *cell = [tableView dequeueReusableCellWithIdentifier:@"WarningInfoCellForTime" forIndexPath:indexPath];
//            
//            cell.label1.text = warningVO.createTime;
//            
//            
//            return cell;
//        }
//        case 1:{
//            PopWarningInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WarningInfoCell" forIndexPath:indexPath];
//
//            cell.label1.text = warningVO.name;
//            
//            return cell;
//        }
//        case 2:{
//            PopWarningInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WarningInfoCell" forIndexPath:indexPath];
//
//            cell.label2.text = warningVO.createTime;
//            return cell;
//        }
//        case 3:{
//            PopWarningInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WarningInfoCell" forIndexPath:indexPath];
//
//            cell.label3.text = warningVO.objectName;
//            return cell;
//        }
//        case 4:{
//            PopWarningInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WarningInfoCell" forIndexPath:indexPath];
//
//            cell.label4.text = warningVO.body;
//            return cell;
//        }
//        case 5:{
//            PopWarningInfoCellForTime *cell = [tableView dequeueReusableCellWithIdentifier:@"WarningInfoCellForTime" forIndexPath:indexPath];
//            
//            //cell.label1.text = warningVO.name;
//            
//            return cell;
//        }
//        default:{
//            PopWarningInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WarningInfoCell" forIndexPath:indexPath];
//            
//            //cell.label1.text = warningVO.name;
//            
//            return cell;
//        }
  //  }
    
    return cell2;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    switch (indexPath.row) {
//        case 0:{
//            return 44;
//        }
//        case 1:{
//            return 120;
//        }
//        case 2:{
//            return 120;
//        }
//        case 3:{
//            return 120;
//        }
//        case 4:{
//            return 40;
//        }
//        case 5:{
//            return 40;
//        }
//        default:
//            break;
//    }
    return 120;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

@end

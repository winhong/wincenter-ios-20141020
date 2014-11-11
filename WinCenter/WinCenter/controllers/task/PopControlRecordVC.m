//
//  ControlRecordVC.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-26.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "PopControlRecordVC.h"
#import "PopControlRecordCell.h"
#import "PopControlRecordCellForTime.h"
#import "ControlRecordListResult.h"
@interface PopControlRecordVC ()



@end

@implementation PopControlRecordVC


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
    self.title = [NSString stringWithFormat:@"%@的操作日志", prefix];
    
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

-(void)reloadData{
    [ControlRecordVO getControlRecordListViaObject:self.remoteObject async:^(id object, NSError *error) {
        [self.dataList addObjectsFromArray:((ControlRecordListResult*)object).tasks];
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
    PopControlRecordCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ControlRecordCell" forIndexPath:indexPath];
    
    if(self.dataList.count==0) return cell;
    
    ControlRecordVO *controlRecordVO = self.dataList[indexPath.row];
    //时间格式化
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:controlRecordVO.executeTime/1000];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *nowtimeStr = [formatter stringFromDate:date];
    
    //状态转换
    NSString *state_text;
    if ([controlRecordVO.state isEqualToString:@"success"]) {
        state_text = @"成功";
    }else if ([controlRecordVO.state isEqualToString:@"completedAndError"]) {
        state_text = @"失败";
    }else if ([controlRecordVO.state isEqualToString:@"in-progress"]) {
        state_text = @"执行中";
    }
    cell.label1.text = controlRecordVO.taskName;
    cell.label2.text = [NSString stringWithFormat:@"%@",nowtimeStr];
    cell.label3.text = controlRecordVO.targetName;
    cell.label4.text = controlRecordVO.progress == 100 ? @"完成" : @"进行中";
    cell.label5.text = state_text;
    cell.label6.text = controlRecordVO.user;
    //"tasks": [
    //          {
    //              "taskName": "收集存储池",//名称
    //              "executeTime": 1407738165000,//开始时间
    //              "endTime": 1407738171000,//结束时间
    //              "progress": 100,//进度
    //              "state": "completedAndError",//状态
    //              "user": "admin",//操作用户
    //              "targetName": "168nfs",//目标名称
    //              "resPoolId": 1,
    //              "hostId": null,
    //              "vmId": null,
    //          }]
//    switch (indexPath.row) {
//        case 0:{
//            PopControlRecordCellForTime *cell = [tableView dequeueReusableCellWithIdentifier:@"ControlRecordCellForTime" forIndexPath:indexPath];
//            
//            return cell;
//        }
//        case 1:{
//            PopControlRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ControlRecordCell" forIndexPath:indexPath];
//            
//            return cell;
//        }
//        case 2:{
//            PopControlRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ControlRecordCell" forIndexPath:indexPath];
//            
//            return cell;
//        }
//        case 3:{
//            PopControlRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ControlRecordCell" forIndexPath:indexPath];
//            
//            return cell;
//        }
//        case 4:{
//            PopControlRecordCellForTime *cell = [tableView dequeueReusableCellWithIdentifier:@"ControlRecordCellForTime" forIndexPath:indexPath];
//            
//            return cell;
//        }
//        case 5:{
//            PopControlRecordCellForTime *cell = [tableView dequeueReusableCellWithIdentifier:@"ControlRecordCellForTime" forIndexPath:indexPath];
//            
//            return cell;
//        }
//        default:
//            break;
//    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    switch (indexPath.row) {
//        case 0:{
//            return 44;
//        }
//        case 1:{
//            return 90;
//        }
//        case 2:{
//            return 90;
//        }
//        case 3:{
//            return 90;
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
    return 75;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

@end

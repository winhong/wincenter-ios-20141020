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
    [super viewDidLoad];
    
    [ControlRecordVO getControlRecordListViaObject:self.remoteObject async:^(NSArray *allRemote, NSError *error) {
        self.dataList = allRemote;
        [self.tableView reloadData];
    }];
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
    
    ControlRecordVO *controlRecordVO = self.dataList[indexPath.row];
    cell.label1.text = controlRecordVO.taskName;
    cell.label2.text = [NSString stringWithFormat:@"%d 时",(controlRecordVO.executeTime)/3600];
    cell.label3.text = controlRecordVO.targetName;
    cell.label4.text = controlRecordVO.progress == 100 ? @"完成" : @"进行中";
    cell.label5.text = controlRecordVO.state;
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

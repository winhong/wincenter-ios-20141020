//
//  NetworkInsideVC.m
//  wincenterDemo01
//
//  Created by huadi on 14-8-15.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "NetworkCollectionVC.h"
#import "NetworkCollectionCell.h"
#import "VmContainerVC.h"
@interface NetworkCollectionVC ()

//@property NSMutableDictionary *vmDict;
//@property NSMutableArray *ipList;
@property NSMutableArray *vmList;

@end

@implementation NetworkCollectionVC

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
    self.title = @"虚拟机列表";
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    [[RemoteObject getCurrentDatacenterVO] getNetworkIpVmAsync:^(id object, NSError *error) {
//        self.vmDict = [NSMutableDictionary new];
//        for (NetworkIpVmVO *vmvo in ((NetworkIpVmListResult*)object).vms){
//            if (vmvo.ip) {
//                NSArray *iplist = [vmvo.ip componentsSeparatedByString:@","];
//                for(NSString *ip in iplist){
//                    [self.vmDict setObject:vmvo forKey:ip];
//                }
//            }
//        }
//    }];
    
    __unsafe_unretained typeof(self) week_self = self;
    
    [self.tableView addHeaderWithCallback:^{
        //[week_self.ipList removeAllObjects];
        [week_self.vmList removeAllObjects];
        [week_self reloadData];
    }];
    
    [self.tableView addFooterWithCallback:^{
    }];

}
- (IBAction)refreshAction:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = false;
    [self.tableView headerBeginRefreshing];
}

-(void)clearData{
    self.title = @"虚拟机列表";
    self.isExternal = true;
    //self.ipPoolVO = nil;
    self.network = nil;
    //if(self.ipList)
    //    [self.ipList removeAllObjects];

    if(self.vmList)
        [self.vmList removeAllObjects];
    
    [self.tableView reloadData];
}

-(void)reloadData{
    if(self.network)
        self.title = [NSString stringWithFormat:@"%@下的虚拟机列表", self.network.name];
    else
        self.title = @"虚拟机列表";
    
//    if(self.isExternal){
//        if(self.ipPoolVO){
//            [[RemoteObject getCurrentDatacenterVO] getIpPoolsDetailAsync:^(id object, NSError *error) {
//                self.ipList = [NSMutableArray new];
//                for(IpPoolsListDetail *detailVO in ((IpPoolsListDetailResult*)object).ipList){
//                    if(detailVO.state == 2){
//                        [self.ipList addObject:detailVO];
//                    }
//                }
//                [self.tableView headerEndRefreshing];
//                [self.tableView footerFinishingLoading];
//                [self.tableView reloadData];
//            } withPoolId:self.ipPoolVO.ipPoolId];
//        }else{
//            [self.tableView headerEndRefreshing];
//            [self.tableView footerFinishingLoading];
//            [self.tableView reloadData];
//        }
//    }else{
    if(self.network){
        [self.network getVmsByNetworkIdAsync:^(id object, NSError *error) {
            self.vmList = [NSMutableArray new];
            [self.vmList addObjectsFromArray:(NSArray*)object];
            [self.tableView headerEndRefreshing];
            [self.tableView footerFinishingLoading];
            [self.tableView reloadData];
            self.navigationItem.rightBarButtonItem.enabled = true;
        }];
    }else{
        [self.tableView headerEndRefreshing];
        [self.tableView footerFinishingLoading];
        [self.tableView reloadData];
        self.navigationItem.rightBarButtonItem.enabled = true;
    }
    //}
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
    //if(self.isExternal){
    //    return self.ipList ? self.ipList.count : 0;
    //}else{
        return self.vmList ? self.vmList.count : 0;
    //}
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NetworkCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NetworkCollectionCell" forIndexPath:indexPath];
    
//    if(self.isExternal){
//        if(self.ipList.count==0) return cell;
//        
//        cell.backgroundColor = (indexPath.row%2==1) ? ([UIColor whiteColor]) : ([UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1]);
//        
//        IpPoolsListDetail *detailVO = self.ipList[indexPath.row];
//        
//        NetworkIpVmVO *vm = [self.vmDict objectForKey:detailVO.ip];
//        if(vm){
//            cell.vmName.text = vm.name;
//            cell.vmState.text = [vm state_text];
//            cell.vmState.textColor = [vm state_color];
//        }else{
//            cell.vmName.text = @"";
//            cell.vmState.text = @"";
//        }
//        
//        cell.vmIp.text = detailVO.ip;
//        
//        
//        return cell;
//    }else{
        if(self.vmList.count==0) return cell;
        
        cell.backgroundColor = (indexPath.row%2==1) ? ([UIColor whiteColor]) : ([UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1]);

        VmVO *vm = self.vmList[indexPath.row];
        if(vm){
            cell.vmName.text = vm.name;
            
            HostVO *hostVO = [HostVO new];
            hostVO.hostId = vm.ownerHostId;
            [hostVO getHostVOAsync:^(id object, NSError *error) {
                HostVO *hostVO = (HostVO*) object;
                if([hostVO.state isEqualToString:@"DISCONNECT"]){
                    cell.vmState.text = @"未知";
                    cell.vmState.text = [UIColor lightGrayColor];
                }else{
                    cell.vmState.text = [vm state_text];
                    cell.vmState.textColor = [vm state_color];
                }
            }];
        }else{
            cell.vmName.text = @"";
            cell.vmState.text = @"";
        }
        
        cell.vmIp.text = vm.ip;

        return cell;
    //}
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @"网络名称 （Vlan：20   IP段：192.168.1.1/28 IP总数：30 IP可用数：10）";
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 88;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *header = [UIView new];
//    header.backgroundColor = [UIColor clearColor];
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 88)];
//    title.numberOfLines = 0;
//    title.text = @"网络名称 （Vlan：20   IP段：192.168.1.1/28 IP总数：30 IP可用数：10）";
//    title.textColor = [UIColor whiteColor];
//    [header addSubview:title];
//    return header;
//}
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *root = [[UIStoryboard storyboardWithName:@"VM" bundle:nil] instantiateInitialViewController];
    VmContainerVC *vc;
    if([root isKindOfClass:[VmContainerVC class]]){
        vc = (VmContainerVC*) root;
    }else{
        vc = [[root childViewControllers] firstObject];
    }
    
//    if(self.isExternal){
//        IpPoolsListDetail *detailVO = self.ipList[indexPath.row];
//        
//        NetworkIpVmVO *vm = [self.vmDict objectForKey:detailVO.ip];
//        if(vm){
//            VmVO *vmvo = [[VmVO alloc] init];
//            vmvo.vmId = vm.vmId;
//            vmvo.name = vm.name;
//            vc.vmVO = vmvo;
//            if(self.isDetailPagePushed){
//                [self.parentViewController.parentViewController.parentViewController.navigationController pushViewController:vc animated:YES];
//            }else{
//                [self presentViewController:root animated:YES completion:nil];
//            }
//        }
//    }else{
        VmVO *vm = self.vmList[indexPath.row];
        if(vm){
            VmVO *vmvo = [[VmVO alloc] init];
            vmvo.vmId = vm.vmId;
            vmvo.name = vm.name;
            vc.vmVO = vmvo;
            if(self.isDetailPagePushed){
                [self.parentViewController.parentViewController.parentViewController.navigationController pushViewController:vc animated:YES];
            }else{
                [self presentViewController:root animated:YES completion:nil];
            }
        }
    //}
}
@end

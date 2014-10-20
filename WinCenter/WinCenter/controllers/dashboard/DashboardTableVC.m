//
//  DatacenterContainerTableVC.m
//  WinCenter-iPhone
//
//  Created by apple on 14-10-9.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "DashboardTableVC.h"
#import "MSCalendarViewController.h"


@interface DashboardTableVC ()

@end

@implementation DashboardTableVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 20, 320, 150)
                                                          ImageArray:[NSArray arrayWithObjects:@"EScrollerView_1.jpg",@"EScrollerView_2.jpg",@"EScrollerView_3.jpg", nil]
                                                          TitleArray:[NSArray arrayWithObjects:@"EScrollerView_1",@"EScrollerView_2",@"EScrollerView_3", nil]];
    scroller.delegate=self;
    self.tableView.tableHeaderView = scroller;
    
    [DatacenterVO getDatacenterListAsync:^(NSArray *allRemote, NSError *error) {
        if(allRemote.count>0){
            [RemoteObject setCurrentDatacenterVO:[allRemote firstObject]];
            [self.infoVC refresh];
            [self refresh];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"尚没有配置任何数据中心，请联系虚拟化平台管理员！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
            [alert show];
        }
    }];
}

-(void)EScrollerViewDidClicked:(NSUInteger)index
{
    NSLog(@"index--%d",index);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toSelect"]){
        UINavigationController *nav = segue.destinationViewController;
        DatacenterTableVC *vc = [[nav viewControllers] firstObject];
        vc.delegate = self;
    }else if([segue.identifier isEqualToString:@"toInfoVC"]){
        self.infoVC = segue.destinationViewController;
    }
}

- (void)refresh{
    self.title = [RemoteObject getCurrentDatacenterVO].name;
}

- (void)gotoPage:(NSNumber*)index{
    NSArray *viewControllers = @[@"PoolDashboardVCNav",@"HostDashboardVCNav",@"VmDashboardVCNav",
                                 @"StorageDashboardVCNav", @"BusinessDashboardVCNav", @""];
    NSString *viewControllerName = viewControllers[index.intValue];
    if(![viewControllerName isEqualToString:@""]){
        UINavigationController *nav = [self.storyboard instantiateViewController:viewControllerName];
        UIViewController *vc = [[nav childViewControllers] firstObject];
        DTNavigationController *navigation = [DTNavigationController navigationWithRootViewController:vc folderStyle:DTFolderBarStyleNormal];
        navigation.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:navigation animated:YES completion:nil];
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
    
    }
    else if(indexPath.section==2){
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Charts" bundle:nil] instantiateViewController:@"ChartTableVC"] animated:YES];
    }
    else if(indexPath.section==3){
        if(indexPath.row==0){
            [self showWarningInfoVC:nil];
        }else if(indexPath.row==1){
            [self showControlRecordVC:nil];
        }
    }else if(indexPath.section==4){
        [self.navigationController pushViewController:[MSCalendarViewController new] animated:YES];
    }
}

- (void)didFinished:(DatacenterTableVC *)controller{
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
    if(self.infoVC){
        [self.infoVC refresh];
    }
    [self refresh];
}
- (IBAction)showMenu:(id)sender {
    [self.frostedViewController presentMenuViewController];
}
- (IBAction)showSelectForm:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewController:@"DatacenterTableVCNav"];
    DatacenterTableVC *tableVC = [[vc childViewControllers] firstObject];
    tableVC.delegate = self;
    [self mz_presentFormSheetWithViewController:vc animated:YES completionHandler:nil];
}

-(IBAction)showOptionsVC:(id)sender{
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Setting" bundle:nil]  instantiateViewController:@"PopOptionsVCNav"];
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(IBAction)showWarningInfoVC:(id)sender{
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Warning" bundle:nil] instantiateInitialViewController];
    [self presentViewController:vc animated:YES completion:nil];
}

-(IBAction)showControlRecordVC:(id)sender{
    UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

@end

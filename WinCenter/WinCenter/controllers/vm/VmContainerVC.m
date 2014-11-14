//
//  VmContainerVC.m
//  WinCenter-iPad
//
//  Created by apple on 14-10-5.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmContainerVC.h"
#import "MasterCollectionVC.h"
#import "VmDetailInfoVC.h"
#import "VmDetailSnapshootVC.h"
#import "VmNetworkCollectionVC.h"
#import "VmNetworkCollectionCell.h"
#import "VmDiskCollectionVC.h"
#import "VmIsoCollectionVC.h"
#import "PopControlRecordVC.h"
#import "VmMigrateVC.h"
#import "VmDetailCPUConfigVC.h"
#import "VmDetailMemoryConfigVC.h"
#import "VmDetailSnapshootVC.h"
#import "RealtimeCurveVC.h"

@implementation VmContainerVC

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openMenu:)];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(openMenu:)];
        self.navigationItem.rightBarButtonItem = item;
        
        self.btnStart.title = @"";
        self.btnStart.enabled = NO;
        self.btnStop.title = @"";
        self.btnStop.enabled = NO;
        self.btnRestart.title = @"";
        self.btnRestart.enabled = NO;
        self.btnMigrate.title = @"";
        self.btnMigrate.enabled = NO;
        
    }
}

-(void)reloadData{
    [self.vmVO getVmVOAsync:^(id object, NSError *error) {
        self.vmVO = object;
        [self refreshMainInfo];
    }];
}
-(void)refreshMainInfo{
    self.pathLabel.text = [NSString stringWithFormat:@"%@ → %@ → %@", [RemoteObject getCurrentDatacenterVO].name, self.vmVO.poolName, self.vmVO.ownerHostName];
    self.titleLabel.text = self.vmVO.name;
    self.ipLabel.text = self.vmVO.ip;
    if(self.vmVO.ip == nil || [self.vmVO.ip isEqualToString:@""]){
        self.ipLabel.text = @"无法获取网络";
    }
    HostVO *hostVO = [HostVO new];
    hostVO.hostId = self.vmVO.ownerHostId;
    [hostVO getHostVOAsync:^(id object, NSError *error) {
        HostVO *hostVO = (HostVO*) object;
        if([hostVO.state isEqualToString:@"DISCONNECT"]){
            self.statusLabel.text = @"未知";
            self.statusLabel.text = [UIColor lightGrayColor];
        }else{
            self.statusLabel.text = [self.vmVO state_text];
            //self.statusLabel.textColor = [self.vmVO state_color];            
        }
    }];

    self.name.text = self.vmVO.name;
    if (self.name.text.length > 26) {
        self.name.font = [UIFont systemFontOfSize:24.0f];
    }
    self.poolName.text = self.vmVO.poolName;
    if ([self.vmVO.poolName isEqualToString:@"null"]) {
        self.poolName.text = @"无";
    }
    self.hostName.text = self.vmVO.ownerHostName;
    
    int time = self.vmVO.runTime/1000;
    int Day = time/(3600*24.0);
    int Hour = (time - 3600*24.0*Day)/3600.0;
    int Minute = (time - 3600*24.0*Day - 3600.0*Hour)/60.0;
    self.runningTime.text = [NSString stringWithFormat:@"%d天%d小时%d分钟",Day,Hour,Minute];
    
    self.title = self.vmVO.name;
    
    self.btnStart.enabled = false;
    self.btnStop.enabled = false;
    self.btnRestart.enabled = false;
    self.btnMigrate.enabled = false;
    
    //中间状态
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        self.btnStart.enabled = true;
        self.btnStop.enabled = true;
        self.btnRestart.enabled = true;
        self.btnMigrate.enabled = true;
    }else if(self.vmVO.operationState && !([self.vmVO.operationState isEqualToString:@""])){
        self.btnStart.enabled = false;
        self.btnStop.enabled = false;
        self.btnRestart.enabled = false;
        self.btnMigrate.enabled = false;
    }else if ([self.vmVO.state isEqualToString:@"OK"] || [self.vmVO.state isEqualToString:@"STOPPED"]){

        HostVO *hostVO = [HostVO new];
        hostVO.hostId = self.vmVO.ownerHostId;
        [hostVO getHostVOAsync:^(id object, NSError *error) {
            HostVO *hostVO = (HostVO*) object;
            if([hostVO.state isEqualToString:@"DISCONNECT"]){
                self.btnStart.enabled = false;
                self.btnStop.enabled = false;
                self.btnRestart.enabled = false;
            }
            else if ([self.vmVO.state isEqualToString:@"OK"])
            {
                self.btnStart.enabled = false;
                self.btnStop.enabled = true;
                self.btnRestart.enabled = true;
            }
            else if([self.vmVO.state isEqualToString:@"STOPPED"])
            {
                self.btnStart.enabled = true;
                self.btnStop.enabled = false;
                self.btnRestart.enabled = false;
            }
            
            if([hostVO.state isEqualToString:@"DISCONNECT"]){
                //虚拟机所在物理机处于故障状态时，不支持虚拟机迁移
                self.btnMigrate.enabled = false;
            }
            else if([self.vmVO.poolName isEqualToString:@""]){
                //虚拟机在游离主机上时，不支持虚拟机迁移
                self.btnMigrate.enabled = false;
            }else{
                [self.vmVO getVmVolumnListAsync:^(id object, NSError *error) {
                    BOOL isLocalStorage = false;
                    for (StorageVolumnVO *volumn in  ((VmDiskListResult*)object).volumes) {
                        if ([volumn.storagePoolName isEqualToString:@"Local storage"]) {
                            isLocalStorage = true;
                            break;
                        }
                    }
                    //没有本地存储时，处于开机、关机状态时，非游离主机中，不在维护状态的物理机中时，可以迁移
                    if(!isLocalStorage){
                        self.btnMigrate.enabled = true;
                    }
                }];
            }
            
        }];
    }
}
-(void)refresh{
    [self refreshMainInfo];
    
    NSMutableArray *pages = [[NSMutableArray alloc] initWithCapacity:4];
    
    VmDetailInfoVC *detailVC = [self.storyboard instantiateViewController:@"VmDetailInfoVC"];
    detailVC.vmVO = self.vmVO;
    [pages addObject:detailVC];
    
    if(self.hasPerformancePage){
        RealtimeCurveVC *performVC = [[UIStoryboard storyboardWithName:@"Performance" bundle:nil] instantiateViewController:@"VmDetailPerformanceVC"];
        performVC.vmVO = self.vmVO;
        performVC.chartType = @"vm";
        [pages addObject:performVC];
    }
        
    VmNetworkCollectionVC *vmNetworkCollectionVC1 = [self.storyboard instantiateViewController:@"VmNetworkCollectionVC"];
    vmNetworkCollectionVC1.vmVO = self.vmVO;
    vmNetworkCollectionVC1.isExternal = true;
    [pages addObject:vmNetworkCollectionVC1];
    
    VmNetworkCollectionVC *vmNetworkCollectionVC2 = [self.storyboard instantiateViewController:@"VmNetworkCollectionVC"];
    vmNetworkCollectionVC2.vmVO = self.vmVO;
    vmNetworkCollectionVC2.isExternal = false;
    [pages addObject:vmNetworkCollectionVC2];
    
    VmDiskCollectionVC *vmDiskCollectionVC = [self.storyboard instantiateViewController:@"VmDiskCollectionVC"];
    vmDiskCollectionVC.vmVO = self.vmVO;
    [pages addObject:vmDiskCollectionVC];
    
    VmIsoCollectionVC *vmIsoCollectionVC = [self.storyboard instantiateViewController:@"VmIsoCollectionVC"];
    vmIsoCollectionVC.vmVO = self.vmVO;
    [pages addObject:vmIsoCollectionVC];
    
    VmDetailSnapshootVC *snapshot = [self.storyboard instantiateViewController:@"VmDetailSnapshootVC"];
    snapshot.vmVO = self.vmVO;
    [pages addObject:snapshot];
    
    self.pages = pages;
    
    [super refresh];
    
}
- (IBAction)operateAction:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"操作提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"开机",@"关机",@"重启",@"迁移", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self openVm:nil];
            break;
        case 1:
            [self shutdownVm:nil];
            break;
        case 2:
            [self restartVm:nil];
            break;
        case 3:
            [self migrateVm:nil];
            break;
//        case 4:
//            [self configCPU:nil];
//            break;
//        case 5:
//            [self configMemory:nil];
//            break;
        default:
            break;
    }
}

- (IBAction)showControlBtns:(id)sender {
    if(self.vmControlButtons){
        BOOL isHide = self.vmControlButtons.hidden;
        self.vmControlButtons.hidden = isHide == YES ? NO : YES;
    }
}
-(void)hideControlBtn{
    if(self.vmControlButtons){
        self.vmControlButtons.hidden = YES;
    }
}
- (IBAction)openVmWithoutPrompt:(id)sender{
    [self.vmVO vmStart:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"虚拟机正在开机..." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [self hideControlBtn];
    }];
}
- (IBAction)openVm:(id)sender {
    if(!self.openAlert){
        self.openAlert = [[UIAlertView alloc] initWithTitle:@"安全操作提示" message:@"确定开机吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    }
    [self.openAlert show];
    
//    UIAlertView *confirm = [[UIAlertView alloc] initWithTitle:@"安全操作" message:@"再次确认操作" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    confirm.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
//    [confirm show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(buttonIndex==1){
//        if(([[alertView textFieldAtIndex:0].text isEqualToString:@"admin"]) && ([[alertView textFieldAtIndex:1].text isEqualToString:@"passw0rd"])){
//            [self.vmVO vmStart:^(NSError *error) {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"虚拟机正在开机..." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                [alert show];
//                [self hideControlBtn];
//            }];
//        }else{
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"错误的用户名或密码！" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles: nil];
//            [alert show];
//        }
//    }
    
    if(buttonIndex==1){
        if(alertView==self.openAlert){
            [self openVmWithoutPrompt:nil];
        }else if(alertView==self.shutdownAlert){
            [self shutdownVmWithoutPrompt:nil];
        }else if(alertView==self.restartAlert){
            [self restartVmWithoutPrompt:nil];
        }
    }
}


- (IBAction)shutdownVmWithoutPrompt:(id)sender {
    [self.vmVO vmStop:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"虚拟机正在关机..." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [self hideControlBtn];
    }];
}
- (IBAction)shutdownVm:(id)sender{
    if(!self.shutdownAlert){
        self.shutdownAlert = [[UIAlertView alloc] initWithTitle:@"安全操作提示" message:@"确定关机吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    }
    [self.shutdownAlert show];
}
- (IBAction)restartVmWithoutPrompt:(id)sender {
    [self.vmVO vmRestart:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"虚拟机正在重启..." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [self hideControlBtn];
    }];
}
- (IBAction)restartVm:(id)sender{
    if(!self.restartAlert){
        self.restartAlert = [[UIAlertView alloc] initWithTitle:@"安全操作提示" message:@"确定重启吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    }
    [self.restartAlert show];
}
- (IBAction)migrateVm:(id)sender {
    [self performSegueWithIdentifier:@"toMigrateVm" sender:self];
}

- (IBAction)configCPU:(id)sender {
    [self performSegueWithIdentifier:@"toConfigCPU" sender:self];
}
- (IBAction)configMemory:(id)sender {
    [self performSegueWithIdentifier:@"toConfigMemory" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqual:@"toMigrateVm"]){
        UINavigationController *nav = segue.destinationViewController;
        VmMigrateVC *vc = [[nav childViewControllers] firstObject];
        vc.vmVO = self.vmVO;
    }else if([segue.identifier isEqual:@"toConfigCPU"]){
        UINavigationController *nav = segue.destinationViewController;
        VmDetailCPUConfigVC *vc = [[nav childViewControllers] firstObject];
        vc.vmVO = self.vmVO;
        
    }else if([segue.identifier isEqual:@"toConfigMemory"]){
        UINavigationController *nav = segue.destinationViewController;
        VmDetailMemoryConfigVC *vc = [[nav childViewControllers] firstObject];
        vc.vmVO = self.vmVO;
    }
}

-(IBAction)showControlRecordVC:(id)sender{
    if(self.popover!=nil){
        [self.popover dismissPopoverAnimated:NO];
    }
    UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
    PopControlRecordVC *controlVC = [[nav childViewControllers] firstObject];
    controlVC.remoteObject = self.vmVO;
    self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
    UIButton *button = (UIButton*)sender;
    //self.popover.passthroughViews=@[self.buttonTask];
    [self.popover presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

-(IBAction)showControlRecordVCWithBarItem:(id)sender{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
        PopControlRecordVC *controlVC = [[nav childViewControllers] firstObject];
        controlVC.remoteObject = self.vmVO;
        [self.navigationController pushViewController:controlVC animated:YES];
    }else{
        if(self.popover!=nil){
            [self.popover dismissPopoverAnimated:NO];
        }
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Task" bundle:nil] instantiateInitialViewController];
        PopControlRecordVC *controlVC = [[nav childViewControllers] firstObject];
        controlVC.remoteObject = self.vmVO;
        self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
        UIBarButtonItem *button = (UIBarButtonItem*)sender;
        [self.popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

-(IBAction)showWarningInfoVCWithBarItem:(id)sender{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Warning" bundle:nil] instantiateInitialViewController];
        PopWarningInfoVC *controlVC = [[nav childViewControllers] firstObject];
        controlVC.remoteObject = self.vmVO;
        [self.navigationController pushViewController:controlVC animated:YES];
    }else{
        if(self.popover!=nil){
            [self.popover dismissPopoverAnimated:NO];
        }
        UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Warning" bundle:nil] instantiateInitialViewController];
        PopWarningInfoVC *controlVC = [[nav childViewControllers] firstObject];
        controlVC.remoteObject = self.vmVO;
        self.popover = [[UIPopoverController alloc] initWithContentViewController:nav];
        UIBarButtonItem *button = (UIBarButtonItem*)sender;
        [self.popover presentPopoverFromBarButtonItem:button permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}


#pragma mark - circular menu

- (IBAction)openMenu:(id)sender{
    //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"虚拟机操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"开机",@"关机",@"重启",@"迁移"/*,@"调整CPU",@"调整内存"*/, nil];
        
        [sheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
        //[sheet showFromBarButtonItem:((UIBarButtonItem*)sender) animated:YES];
        return;
    //}
    
    if (menu) {
        [menu hideWithAnimationBlock:^{
            self.view.backgroundColor = [UIColor whiteColor];
        }];
        menu = nil;
        
        [self.view removeGestureRecognizer:tap];
    } else {
        menu = [[RRCircularMenu alloc] initWithFrame:CGRectMake((self.view.frame.size.width-320)/2, self.view.frame.size.height - 180, 320, 180)];
        menu.delegate = self;
        
        [self.view addSubview:menu];
        [menu showWithAnimationBlock:^{
            self.view.backgroundColor = [UIColor darkGrayColor];
        } settingSliderTo:3];
        
        [self.view addGestureRecognizer:tap];
    }
}

# pragma mark - Menu Delegate methods

- (void) menuItem:(RRCircularItem *)item didChangeActive:(BOOL)active {
    NSLog(@"Item %@ did change state to %d", item.text, active);
    if (active && ![menu isLabelActive]) {
        [menu setLabelActive:YES];
        [menu setSliderValue:1];
    } else if (!active && [menu isLabelActive]) {
        BOOL hasActive = NO;
        for (int i = 0; i < 6; i++) hasActive |= [menu isItemActive:i];
        if (!hasActive) {
            [menu setLabelActive:NO];
            [menu setSliderValue:0 animated:NO];
        }
    }
}
- (void) menuLabel:(RRCircularMenuLabel *)label didChangeActive:(BOOL)active {
    NSLog(@"Label did change state to %d (%@)", active, label.text);
    if (active && [menu sliderValue] == 0) {
        [menu setSliderValue:1];
        [menu setItem:0 active:YES];
    } else if (!active && [menu sliderValue] != 0) {
        [menu setSliderValue:0 animated:NO];
        for (int i = 0; i < 6; i++) [menu setItem:i active:NO];
    }
}

- (BOOL) ignoreClickFor:(RRCircularItem *)item {
    NSLog(@"Checking whether to ignore click for item %@", item.text);
    return NO;
}

- (void) sliderValueChanged:(RRCircularSlider *)slider {
    NSLog(@"Slider value changed to %d", slider.value);
    if (slider.value == 0) {
        [menu setLabelActive:NO];
        [menu setLabelText:@"CUES\nOFF"];
        for (int i = 0; i < 6; i++) [menu setItem:i active:NO];
    } else {
        [menu setLabelActive:YES];
        
        if (slider.value == 1) {
            [menu setLabelText:@"AUTO-\nMAGICAL"];
        } else if (slider.value == 2) {
            [menu setLabelText:@"EVERY\n5 min"];
        } else if (slider.value == 3) {
            [menu setLabelText:@"EVERY\n10 min"];
        } else if (slider.value == 4) {
            [menu setLabelText:@"EVERY\n1 km"];
        } else if (slider.value == 5) {
            [menu setLabelText:@"EVERY\n3 km"];
        }
    }
}


@end

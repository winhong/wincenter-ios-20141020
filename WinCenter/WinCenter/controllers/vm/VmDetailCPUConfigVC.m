//
//  VmDetailCPUConfigVC.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-26.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "VmDetailCPUConfigVC.h"

@interface VmDetailCPUConfigVC ()
@property (weak, nonatomic) IBOutlet UILabel *cpuCap;
@property (weak, nonatomic) IBOutlet UITextField *vcpu;
@property (weak, nonatomic) IBOutlet UITextField *vcpuWeight;

@property HostVO *OwnerHostVO;
@end

@implementation VmDetailCPUConfigVC

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
    [super viewDidLoad];
    [[DatacenterVO new] getHostByIdAsync:^(id object, NSError *error) {
        self.OwnerHostVO = object;
        self.cpuCap.text = [NSString stringWithFormat:@"%d",self.OwnerHostVO.cpu];
        self.vcpu.text = [NSString stringWithFormat:@"%d",self.vmVO.vcpu];
        //self.vcpuWeight.text = [NSString stringWithFormat:@"%d",self.vmVO. vcpuWeight];
    } widthHostId:self.vmVO.ownerHostId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)done:(id)sender {
    [self.vmVO vmConfigCPU:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改CPU配置成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    } withVCPU:(int)self.vcpu.text withCPUCap:(int)self.cpuCap.text withCPUWeight:384];
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

@end

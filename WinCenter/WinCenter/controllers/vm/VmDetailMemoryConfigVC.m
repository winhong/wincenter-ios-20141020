//
//  VmDetailMemryConfigVC.m
//  wincenterDemo01
//
//  Created by 黄茂坚 on 14-8-26.
//  Copyright (c) 2014年 黄茂坚. All rights reserved.
//

#import "VmDetailMemoryConfigVC.h"

@interface VmDetailMemoryConfigVC ()

@property (weak, nonatomic) IBOutlet UITextField *memoryModal;
@property (weak, nonatomic) IBOutlet UITextField *memorySize;
@property (weak, nonatomic) IBOutlet UITextField *memoryObligate;


@end

@implementation VmDetailMemoryConfigVC

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
    
    self.memoryModal.text = self.vmVO.memoryType_text;
    self.memorySize.text = [NSString stringWithFormat:@"%.2f",self.vmVO.memory/1024.0];
    self.memoryObligate.text = [NSString stringWithFormat:@"%.2f",self.vmVO.minMem/1024.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)done:(id)sender {
    [self.vmVO vmConfigMemory:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改内存配置成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [self dismissViewControllerAnimated:YES completion:nil];
    } withReservation:(int)self.memorySize.text withMinMem:(int)self.memoryObligate.text];
    
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

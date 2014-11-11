//
//  PopOptionsPasswordVC.m
//  WinCenter
//
//  Created by huadi on 14/10/28.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "PopOptionsPasswordVC.h"

@interface PopOptionsPasswordVC ()

@end

@implementation PopOptionsPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
        self.navigationItem.rightBarButtonItem.enabled = false;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(IBAction)nextOnKeyboard:(UITextField *)sender{
    if (sender == self.passwordOld) {
        [self.passwordNew becomeFirstResponder];
    }else if (sender == self.passwordNew){
        [self.passwordRepeat becomeFirstResponder];
    }
    
}
- (IBAction)done:(id)sender {
    NSString *msg = @"";
    if([self.passwordOld.text isEqualToString:@""])
    {
        msg = @"请输入原密码！";
    }
    else if ([self.passwordNew.text isEqualToString:@""])
    {
        msg = @"请输入新密码！";
    }
    else if (![self.passwordNew.text isEqualToString:self.passwordRepeat.text])
    {
        msg = @"重复新密码与新密码不一致！";
    }
    
    if([msg isEqualToString:@""])
    {
           [[UserVO new] modifyPassword:^(id object, NSError *error) {
               self.modifyPasswordResultVO = object;
               if ([self.modifyPasswordResultVO.exceptionCode isEqualToString:@"POCS008"]) {
                   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"原密码输入错误！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                   [alert show];
               }else{
                   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改密码成功！" delegate:self cancelButtonTitle:@"重新登录" otherButtonTitles:nil];
                   [alert show];
               }
           } withOldPassword:self.passwordOld.text withPassword:self.passwordNew.text];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"重新登录"]){
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"PASSWORD"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

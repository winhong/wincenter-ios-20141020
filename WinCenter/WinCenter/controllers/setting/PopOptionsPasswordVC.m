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
- (IBAction)exitPasswordOld:(id)sender {
    if(((UITextField*)sender).returnKeyType==UIReturnKeyNext){
        [self.passwordNew becomeFirstResponder];
    }else{
        [self.passwordOld resignFirstResponder];
    }
}
- (IBAction)exitPasswordNew:(id)sender {
    if(((UITextField*)sender).returnKeyType==UIReturnKeyNext){
        [self.passwordRepeat becomeFirstResponder];
    }else{
        [self.passwordNew resignFirstResponder];
    }
}
- (IBAction)exitPasswordConfirm:(id)sender {
    if(((UITextField*)sender).returnKeyType==UIReturnKeyGo){
        if([[[NSUserDefaults standardUserDefaults] stringForKey:@"isDemo"] isEqualToString:@"true"]){
            [self.passwordRepeat resignFirstResponder];
        }else{
            [self done:nil];
        }
    }else{
        [self.passwordRepeat resignFirstResponder];
    }
}


-(BOOL)matchPassword:( NSString*)str{
    NSString *urlString = str;
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\s`~!@#$%^&*()_+|{}?;:',.><\\-\\]\\[\\/\u0391-\uFFE5]*" options:0 error:&error];
    
    NSTextCheckingResult *firstMatch = [regex firstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
    
    NSRange resultRange = [firstMatch rangeAtIndex:0];
    NSString *result = [urlString substringWithRange:resultRange];
    if ([result isEqualToString:str]) {
        return NO;
    }else{
        return YES;
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
    }else if([self.passwordNew.text isEqualToString:self.passwordOld.text]){
        msg = @"新密码不能与原密码相同！";
    }else if([self matchPassword:self.passwordNew.text]){
        msg = @"密码不能包含特殊字符！";
    }else if(self.passwordNew.text.length < 6){
        msg = @"密码长度必须大于或等于6字符！";
    }else if (![self.passwordNew.text isEqualToString:self.passwordRepeat.text])
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{  //string就是此时输入的那个字符 textField就是此时正在输入的那个输入框 返回YES就是可以改变输入框的值 NO相反
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (self.passwordNew == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 20) { //如果输入框内容大于20则弹出警告
            self.passwordNew.text = [toBeString substringToIndex:20];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码长度最大只能是20个字符！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    // Check for non-numeric characters
//    NSUInteger lengthOfString = string.length;
//    for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {//只允许数字输入
//        unichar character = [string characterAtIndex:loopIndex];
//        if (character < 48) return NO; // 48 unichar for 0
//        if (character > 57) return NO; // 57 unichar for 9
//    }
//    // Check for total length
//    NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
//    if (proposedNewLength > 3) return NO;//限制长度
//    return YES;
//}


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

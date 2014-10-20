//
//  LoginVC.h
//  wincenterDemo01
//
//  Created by huadi on 14-8-20.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController<UITextFieldDelegate, NSURLSessionDelegate>
@property NSString *themeName;
@property (weak, nonatomic) IBOutlet UIView *formView;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *ip;
@property (weak, nonatomic) IBOutlet UIScrollView *formScrollView;
- (IBAction)backToLogin:(UIStoryboardSegue*)segue;

@end

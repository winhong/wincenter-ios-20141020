//
//  UIStoryboard+Universal.m
//  WinCenter
//
//  Created by apple on 14/10/18.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "UIStoryboard+Universal.h"

@implementation UIStoryboard (Universal)

- (id)instantiateViewController:(NSString *)identifier{
    UIViewController *result;
    @try{
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            result = [self instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%@_iPhone", identifier]];
        }else{
            result = [self instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%@_iPad", identifier]];
        }
    }
    @catch (NSException *exception) {
        result = [self instantiateViewControllerWithIdentifier:identifier];
    }
    
    return result;
}

@end

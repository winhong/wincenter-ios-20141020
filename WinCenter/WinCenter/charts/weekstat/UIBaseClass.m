//
//  UIBaseClass.m
//  simc_app
//
//  Created by mac on 13-7-24.
//  Copyright (c) 2013年 Byron. All rights reserved.
//

#import "UIBaseClass.h"

@implementation UIBaseClass


+ (UIBaseClass *)shareInstance {
    static UIBaseClass *__singletion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __singletion=[[self alloc] init];
    });
    return __singletion;
}




-(int) getScreenWidth
{
    static int s_scrWidth = 0;
    if (s_scrWidth == 0){
        CGRect screenFrame = [UIScreen mainScreen].bounds;
        s_scrWidth = screenFrame.size.width;
    }
    return s_scrWidth;
}

-(int) getScreenHeight
{
    static int s_scrHeight = 0;
    if (s_scrHeight == 0){
        CGRect screenFrame = [UIScreen mainScreen].bounds;
        s_scrHeight = screenFrame.size.height;
    }
    return s_scrHeight;
}


-(int) getViewFramOX
{

    return 0;
}

-(int) getViewFramOY
{
    return 0;
}




@end

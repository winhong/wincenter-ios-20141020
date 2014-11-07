//
//  VmIsoVO.m
//  WinCenter
//
//  Created by 黄茂坚 on 14/11/7.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmIsoVO.h"

@implementation VmIsoVO


-(NSString*) state_text{
    if([self.status isEqualToString:@"OK"]){
        return @"正常";
    }else if([self.status isEqualToString:@"MOVING"]){
        return @"移动中";
    }else if([self.status isEqualToString:@"USING"]){
        return @"使用中";
    }else if([self.status isEqualToString:@"DELETING"]){
        return @"删除中";
    }else if([self.status isEqualToString:@"DEPLOYING"]){
        return @"部署虚拟机中";
    }else if([self.status isEqualToString:@"MOUNTED"]){
        return @"已挂载";
    }else if([self.status isEqualToString:@"MOUNTING"]){
        return @"挂载中";
    }else{
        return @"其他";
    }
}

- (UIColor *)state_color{
    if([self.status isEqualToString:@"OK"]){
        return PNGreen;
    }else if([self.status isEqualToString:@"MOUNTED"]){
        return PNGreen;
    }else{
        return PNBlue;
    }
}

- (float)isoSize_value{
    if(self.isoSize > 1024.0*1024.0*1024.0 ){
        return (self.isoSize/(1024.0*1024.0*1024.0));
    }else{
        return self.isoSize/(1024.0*1024.0);
    }
    
}
- (NSString*)isoSize_unit{
    if(self.isoSize > 1024.0*1024.0*1024.0 ){
        return @"GB";
    }else{
        return @"MB";
    }
    
}

@end

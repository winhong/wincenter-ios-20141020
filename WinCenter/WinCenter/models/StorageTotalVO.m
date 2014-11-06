//
//  StorageShareVO.m
//  WinCenter
//
//  Created by huadi on 14/10/21.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "StorageTotalVO.h"

@implementation StorageTotalVO


- (float)totalStorage_value{
    if((self.true_field + self.false_field)> 1024.0 ){
        return ((self.true_field + self.false_field)/1024.0);
    }else{
        return (self.true_field + self.false_field);
    }
    
}
- (NSString*)totalStorage_unit{
    if((self.true_field + self.false_field) > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
    }
    
}

- (float)shareStorage_value{
    if(self.true_field > 1024.0 ){
        return (self.true_field/1024.0);
    }else{
        return self.true_field;
    }
    
}
- (NSString*)shareStorage_unit{
    if(self.true_field > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
    }
    
}

- (float)localStorage_value{
    if(self.false_field > 1024.0 ){
        return (self.false_field/1024.0);
    }else{
        return self.false_field;
    }
    
}
- (NSString*)localStorage_unit{
    if(self.false_field > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
    }
    
}

@end

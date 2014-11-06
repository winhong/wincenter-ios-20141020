//
//  StorageCapacityVO.m
//  WinCenter
//
//  Created by huadi on 14/10/21.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "StorageCapacityVO.h"

@implementation StorageCapacityVO

- (float)usedStorage_value{
    if(self.usedStorage > 1024.0 ){
        return (self.usedStorage/1024.0);
    }else{
        return self.usedStorage;
    }
    
}
- (NSString*)usedStorage_unit{
    if(self.usedStorage > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
    }
    
}

- (float)availStorage_value{
    if(self.availStorage > 1024.0 ){
        return (self.availStorage/1024.0);
    }else{
        return self.availStorage;
    }
    
}
- (NSString*)availStorage_unit{
    if(self.availStorage > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
    }
    
}

@end

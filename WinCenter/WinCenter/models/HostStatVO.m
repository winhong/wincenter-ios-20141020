//
//  HostStatVO.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-28.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "HostStatVO.h"

@implementation HostStatVO

-(float)cpuRatio{
    return self.cpuUsed/self.cpuTotal*100;
}

-(UIColor *)cpuRatioColor{
    float ratio = [self cpuRatio];
    if(ratio>80){
        return PNRed;
    }else if(ratio>60){
        return PNYellow;
    }else{
        return PNGreen;
    }
}


-(float)memoryRatio{
    return (self.totalMem - self.freeMem)/self.totalMem*100;
}

-(UIColor *)memoryRatioColor{
    float ratio = [self memoryRatio];
    if(ratio>80){
        return PNRed;
    }else if(ratio>60){
        return PNYellow;
    }else{
        return PNGreen;
    }
}

-(float)storageRatio{
    return self.usedStorage/self.totalStorage*100;
}

-(UIColor *)storageRatioColor{
    float ratio = [self storageRatio];
    if(ratio>80){
        return PNRed;
    }else if(ratio>60){
        return PNYellow;
    }else{
        return PNGreen;
    }
}

- (float)totalCpu_value{
    if(self.cpuTotal > 1000.0 ){
        return (self.cpuTotal/1000.0);
    }else{
        return self.cpuTotal;
    }
    
}
- (NSString*)totalCpu_unit{
    if(self.cpuTotal > 1000.0 ){
        return @"GHz";
    }else{
        return @"MHz";
    }
    
}

- (float)usedCpu_value{
    if(self.cpuUsed  > 1000.0 ){
        return (self.cpuUsed /1000.0);
    }else{
        return self.cpuUsed;
    }
    
}
- (NSString*)usedCpu_unit{
    if(self.cpuUsed > 1000.0 ){
        return @"GHz";
    }else{
        return @"MHz";
    }
    
}

- (float)availCpu_value{
    if((self.cpuTotal - self.cpuUsed) > 1000.0 ){
        return ((self.cpuTotal - self.cpuUsed)/1000.0);
    }else{
        return (self.cpuTotal - self.cpuUsed);
    }
    
}
- (NSString*)availCpu_unit{
    if((self.cpuTotal - self.cpuUsed) > 1000.0 ){
        return @"GHz";
    }else{
        return @"MHz";
    }
    
}

- (float)availStorage_value{
    if((self.totalStorage -self.usedStorage) > 1024.0 ){
        return ((self.totalStorage -self.usedStorage)/1024.0);
    }else{
        return (self.totalStorage -self.usedStorage);
    }
    
}
- (NSString*)availStorage_unit{
    if((self.totalStorage -self.usedStorage) > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
    }
    
}

- (float)totalStorage_value{
    if(self.totalStorage > 1024.0 ){
        return (self.totalStorage/1024.0);
    }else{
        return self.totalStorage;
    }
    
}
- (NSString*)totalStorage_unit{
    if(self.totalStorage > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
    }
    
}

- (float)usedStorage_value{
    if(self.usedStorage  > 1024.0 ){
        return (self.usedStorage/1024.0);
    }else{
        return (self.usedStorage);
    }
    
}
- (NSString*)usedStorage_unit{
    if(self.usedStorage > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
    }
    
}

@end

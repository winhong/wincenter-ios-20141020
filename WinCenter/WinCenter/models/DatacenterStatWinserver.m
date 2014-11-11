//
//  DatacenterStatWinserver.m
//  WinCenter-iPad
//
//  Created by huadi on 14-9-26.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "DatacenterStatWinserver.h"

@implementation DatacenterStatWinserver

-(id)init {
    self = [super init];
    if (self) {
        self.totalCpu = 0;
        self.totalMemory = 0;
        self.totalStorage = 0;
        self.availCpu = 0;
        self.availMemory = 0;
        self.availStorage = 0;
    }
    return self;
}

-(float)cpuRatio{
    return (self.totalCpu-self.availCpu)/self.totalCpu*100;
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
    return (self.totalMemory-self.availMemory)/self.totalMemory*100;
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
    return (self.totalStorage-self.availStorage)/self.totalStorage*100;
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
    if(self.totalCpu > 1000.0 ){
        return (self.totalCpu/1000.0);
    }else{
        return self.totalCpu;
    }
    
}
- (NSString*)totalCpu_unit{
    if(self.totalCpu > 1000.0 ){
        return @"GHz";
    }else{
        return @"MHz";
    }
    
}

- (float)availCpu_value{
    if(self.availCpu > 1000.0 ){
        return (self.availCpu/1000.0);
    }else{
        return self.availCpu;
    }
    
}
- (NSString*)availCpu_unit{
    if(self.availCpu > 1000.0 ){
        return @"GHz";
    }else{
        return @"MHz";
    }
    
}

- (float)totalMemory_value{
    if(self.totalMemory > 1024.0 ){
        return (self.totalMemory/1024.0);
    }else{
        return self.totalMemory;
    }
    
}
- (NSString*)totalMemory_unit{
    if(self.totalMemory > 1024.0 ){
        return @"GB";
    }else{
        return @"MB";
    }
    
}

- (float)availMemory_value{
    if(self.availMemory > 1024.0 ){
        return (self.availMemory/1024.0);
    }else{
        return self.availMemory;
    }
    
}
- (NSString*)availMemory_unit{
    if(self.availMemory > 1024.0 ){
        return @"GB";
    }else{
        return @"MB";
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

- (float)usedCpu_value{
    if((self.totalCpu - self.availCpu) > 1000.0 ){
        return ((self.totalCpu - self.availCpu)/1000.0);
    }else{
        return (self.totalCpu - self.availCpu);
    }
    
}
- (NSString*)usedCpu_unit{
    if((self.totalCpu - self.availCpu) > 1000.0 ){
        return @"GHz";
    }else{
        return @"MHz";
    }
    
}

- (float)usedMemory_value{
    if((self.totalMemory - self.availMemory) > 1024.0 ){
        return ((self.totalMemory - self.availMemory)/1024.0);
    }else{
        return (self.totalMemory - self.availMemory);
    }
    
}
- (NSString*)usedMemory_unit{
    if((self.totalMemory - self.availMemory) > 1024.0 ){
        return @"GB";
    }else{
        return @"MB";
    }
    
}


- (float)usedStorage_value{
    if((self.totalStorage -self.availStorage) > 1024.0 ){
        return ((self.totalStorage -self.availStorage)/1024.0);
    }else{
        return (self.totalStorage -self.availStorage);
    }
    
}
- (NSString*)usedStorage_unit{
    if((self.totalStorage -self.availStorage) > 1024.0 ){
        return @"TB";
    }else{
        return @"GB";
    }
    
}

@end

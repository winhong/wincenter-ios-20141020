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
    if(self.totalCpu > 1024.0 ){
        return (self.totalCpu/1024.0);
    }else{
        return self.totalCpu;
    }
    
}

- (NSString*)totalCpu_unit{
    if(self.totalCpu > 1024.0 ){
        return @"GHz";
    }else{
        return @"MHz";
    }
    
}

@end

//
//  chatView.h
//  test
//
//  Created by Z on 14-5-26.
//  Copyright (c) 2014年 carlsworld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Line;
@interface chatView : UIView

@property(nonatomic, strong)NSMutableArray* lines;
@property(nonatomic, strong)UIColor* afColor;
@property(nonatomic, strong)UIColor* bfColor;
@property(nonatomic, strong)NSMutableArray* points;
@property(nonatomic, strong)Line* line;
@property(assign)BOOL isDrawPoint;
@end

@interface Line : NSObject

@property(nonatomic, assign)CGPoint firstPoint;
@property(nonatomic, assign)CGPoint secondPoint;
@property(nonatomic, strong)UIColor* color;

@end
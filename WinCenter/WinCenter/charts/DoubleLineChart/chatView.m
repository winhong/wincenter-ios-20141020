//
//  chatView.m
//  test
//
//  Created by Z on 14-5-26.
//  Copyright (c) 2014年 carlsworld. All rights reserved.
//

#import "chatView.h"

@implementation chatView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.lines = [[NSMutableArray alloc]init];
        self.afColor = [UIColor colorWithRed:123.0/255.0 green:207.0/255.0 blue:35.0/255.0 alpha:1.0];
        self.bfColor = [UIColor colorWithRed:97.0/255.0 green:173.0/255.0 blue:244.0/255.0 alpha:1.0];
        self.points = [[NSMutableArray alloc]init];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    
    for(int i=0; i<self.lines.count; i++){
        Line* line = [self.lines objectAtIndex:i];
        if(i!=0 ||i!=6 || i!=7){
           CGContextSetLineWidth(context, 1);
        }else{
            CGContextSetLineWidth(context, 1);
        }
        CGContextMoveToPoint(context, line.firstPoint.x, line.firstPoint.y);
        CGContextAddLineToPoint(context, line.secondPoint.x, line.secondPoint.y);
    }
    CGContextDrawPath(context, kCGPathStroke);

    if([self.points count]){
        //画线
        UIBezierPath* path = [UIBezierPath bezierPath];
        [path setLineWidth:2];
        for(int i=0; i<[[self.points objectAtIndex:0] count]-1; i++){
            CGPoint firstPoint = [[[self.points objectAtIndex:0] objectAtIndex:i] CGPointValue];
            CGPoint secondPoint = [[[self.points objectAtIndex:0] objectAtIndex:i+1] CGPointValue];
            [path moveToPoint:firstPoint];
            [path addCurveToPoint:secondPoint controlPoint1:CGPointMake((secondPoint.x-firstPoint.x)/2+firstPoint.x, firstPoint.y) controlPoint2:CGPointMake((secondPoint.x-firstPoint.x)/2+firstPoint.x, secondPoint.y)];
            [self.bfColor set];
        }
        path.lineCapStyle = kCGLineCapRound;
        [path strokeWithBlendMode:kCGBlendModeNormal alpha:1];
        
        if(!self.isDrawPoint){
            for(int i=0; i<[[self.points objectAtIndex:0] count]; i++){
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                CGPoint point = [[[self.points objectAtIndex:0] objectAtIndex:i] CGPointValue];
                CGContextFillEllipseInRect(ctx, CGRectMake(point.x-4, point.y-4, 8, 8));
                CGContextSetFillColorWithColor(ctx, self.bfColor.CGColor);
                CGContextFillPath(ctx);
            }
        }
        
        UIBezierPath* path1 = [UIBezierPath bezierPath];
        [path1 setLineWidth:2];
        for(int i=0; i<[[self.points lastObject] count]-1; i++){
            CGPoint firstPoint = [[[self.points lastObject] objectAtIndex:i] CGPointValue];
            CGPoint secondPoint = [[[self.points lastObject] objectAtIndex:i+1] CGPointValue];
            [path1 moveToPoint:firstPoint];
            [UIView animateWithDuration:.1 animations:^(){
                [path1 addCurveToPoint:secondPoint controlPoint1:CGPointMake((secondPoint.x-firstPoint.x)/2+firstPoint.x, firstPoint.y) controlPoint2:CGPointMake((secondPoint.x-firstPoint.x)/2+firstPoint.x, secondPoint.y)];
            }];
            [self.afColor set];
            
        }
        path1.lineCapStyle = kCGLineCapRound;
        [path1 strokeWithBlendMode:kCGBlendModeNormal alpha:1];
        
        //画点
        if(!self.isDrawPoint){
//            for(int i=0; i<[[self.points objectAtIndex:0] count]; i++){
//                CGContextRef ctx = UIGraphicsGetCurrentContext();
//                CGPoint point = [[[self.points objectAtIndex:0] objectAtIndex:i] CGPointValue];
//                CGContextFillEllipseInRect(ctx, CGRectMake(point.x-4, point.y-4, 8, 8));
//                CGContextSetFillColorWithColor(ctx, self.bfColor.CGColor);
//                CGContextFillPath(ctx);
//            }
            
            for(int i=0; i<[[self.points lastObject] count]; i++){
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                CGPoint point = [[[self.points lastObject] objectAtIndex:i] CGPointValue];
                CGContextFillEllipseInRect(ctx, CGRectMake(point.x-4, point.y-4, 8, 8));
                CGContextSetFillColorWithColor(ctx, self.afColor.CGColor);
                CGContextFillPath(ctx);
            }
        }
    }
//    for(int i=0; i<self.bfLines.count; i++){
//        Line* line = [self.bfLines objectAtIndex:i];
//        [path moveToPoint:line.firstPoint];
//        [path addCurveToPoint:line.secondPoint controlPoint1:CGPointMake((line.secondPoint.x-line.firstPoint.x)/2+line.firstPoint.x, line.firstPoint.y) controlPoint2:CGPointMake((line.secondPoint.x-line.firstPoint.x)/2+line.firstPoint.x, line.secondPoint.y)];
//        [line.color set];
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        CGContextFillEllipseInRect(ctx, CGRectMake(line.firstPoint.x-4, line.firstPoint.y-4, 8, 8));
//        CGContextSetFillColorWithColor(ctx, line.color.CGColor);
//        CGContextFillPath(ctx);
//    }
//    path.lineCapStyle = kCGLineCapRound;
//    [path strokeWithBlendMode:kCGBlendModeNormal alpha:1];
    
//    UIBezierPath* path1 = [UIBezierPath bezierPath];
//    [path1 setLineWidth:2];
//    for(int i=0; i<self.afLines.count; i++){
//        
//        Line* line2 = [self.afLines objectAtIndex:i];
//        [path1 moveToPoint:line2.firstPoint];
//        [path1 addCurveToPoint:line2.secondPoint controlPoint1:CGPointMake((line2.secondPoint.x-line2.firstPoint.x)/2+line2.firstPoint.x, line2.firstPoint.y) controlPoint2:CGPointMake((line2.secondPoint.x-line2.firstPoint.x)/2+line2.firstPoint.x, line2.secondPoint.y)];
//        [line2.color set];
//        CGContextRef ctx = UIGraphicsGetCurrentContext();
//        CGContextFillEllipseInRect(ctx, CGRectMake(line2.firstPoint.x-4, line2.firstPoint.y-4, 8, 8));
//        CGContextSetFillColorWithColor(ctx, line2.color.CGColor);
//        CGContextFillPath(ctx);
//    }
//    path1.lineCapStyle = kCGLineCapRound;
//    [path1 strokeWithBlendMode:kCGBlendModeNormal alpha:1];
    
}

@end

@implementation Line

- (id)init
{
    if(self=[super init]){

    }
    return self;
}

@end
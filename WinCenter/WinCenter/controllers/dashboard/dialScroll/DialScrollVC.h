//
//  UIAViewController.h
//  UIA
//
//  Created by sk on 11-7-28.
//  Copyright 2011 sk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface DialScrollVC : UIViewController 
{
	UIImageView *addview;
	int  currenttag;
}
-(void)Clickup:(NSInteger)tag;
-(NSInteger)getblank:(NSInteger)tag;
-(CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num;
@end


//
//  UIAViewController.m
//  UIA
//
//  Created by sk on 11-7-28.
//  Copyright 2011 sk. All rights reserved.
//

#import "DialScrollVC.h"

#import"DialScrollImage.h"
#define RADIUS 100.0
#define PHOTONUM 6
#define PHOTOSTRING @"dial-icon"
#define TAGSTART 1000
#define TIME .3
#define SCALENUMBER 1.25
int array [PHOTONUM][PHOTONUM] ={
	{0,1,2,3,4,5},
	{5,0,1,2,3,4},
	{4,5,0,1,2,3},
	{3,4,5,0,1,2},
	{2,3,4,5,0,1},
    {1,2,3,4,5,0}
};
@implementation DialScrollVC


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
CATransform3D rotationTransform1[PHOTONUM];

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	//addview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Defaul11t.png"]];
	//NSLog(@"%@",NSStringFromCGRect(addview.bounds));
	/*
	addview.layer.anchorPoint = CGPointMake(0.5, 0.5);
	CGFloat centerY = self.view.center.y + (self.view.bounds.size.height/2);
	//addview.center = CGPointMake(self.view.center.x, centerY);
	addview.layer.position = CGPointMake(self.view.center.x, self.view.center.y);
	 */
	
	//self.view.backgroundColor = [UIColor clearColor];
//	UIImageView *backview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dial-121.png"]];
//	//backview.frame = self.view.frame;
//	backview.center = CGPointMake(backview.center.x, backview.center.y - 10);
//	
//	backview.alpha = 0.3;
//	[self.view addSubview:backview];
	
    NSArray *textArray = [NSArray arrayWithObjects:@"资源池",@"物理机",@"虚拟机",@"存储池",@"业务系统",@"网络",nil];
    
	float centery = 200 - 50;
	float centerx = self.view.center.x;
    
	for (int i = 0;i<PHOTONUM;i++ ) 
	{
		float tmpy =  centery + RADIUS*cos(2.0*M_PI *i/PHOTONUM);
		float tmpx =	centerx - RADIUS*sin(2.0*M_PI *i/PHOTONUM);
		DialScrollImage *addview1 =	[[DialScrollImage alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d",PHOTOSTRING,i]] text:[textArray objectAtIndex:i]];
        addview1.frame = CGRectMake(0.0, 0.0,120,140);
		[addview1 setdege:self];
		addview1.tag = TAGSTART + i;
		addview1.center = CGPointMake(tmpx,tmpy);
		rotationTransform1[i] = CATransform3DIdentity;	
		
		//float Scalenumber =atan2f(sin(2.0*M_PI *i/PHOTONUM));
		float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
		if (Scalenumber<0.3) 
		{
			Scalenumber = 0.4;
		}
		CATransform3D rotationTransform = CATransform3DIdentity;
		rotationTransform = CATransform3DScale (rotationTransform, Scalenumber*SCALENUMBER,Scalenumber*SCALENUMBER, 1);		
		addview1.layer.transform=rotationTransform;		
		[self.view addSubview:addview1];
		
	}
	currenttag = TAGSTART;


}
-(void)Clickup:(NSInteger)tag
{
	NSLog(@"点击TAG%d:",tag);
//	int = currenttag - tag;
	if(currenttag == tag)
	{
//		UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"点击" message: @"添加自己的处理" delegate:nil  cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		av.tag=110;
//		[av show];
//		[av release];
        [self.parentViewController performSelector:@selector(gotoPage:) withObject:[NSNumber numberWithInt:(tag-TAGSTART)]];
		return;
	}
	int t = [self getblank:tag];
	//NSLog(@"%d",t);
	int i = 0;
	for (i = 0;i<PHOTONUM;i++ ) 
	{
		
		UIImageView *imgview = (UIImageView*)[self.view viewWithTag:TAGSTART+i];
		[imgview.layer addAnimation:[self moveanimation:TAGSTART+i number:t] forKey:@"position"];
		[imgview.layer addAnimation:[self setscale:TAGSTART+i clicktag:tag] forKey:@"transform"];
		
		int j = array[tag - TAGSTART][i];
		float Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
		if (Scalenumber<0.3) 
		{
			Scalenumber = 0.4;
		}
		//CATransform3D dtmp = CATransform3DScale(rotationTransform1[i],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
		//imgview.layer.transform=dtmp;
		
	//	imgview.layer.needsDisplayOnBoundsChange = YES;
	}
	currenttag = tag;
//	[self performSelector:@selector(setcurrenttag) withObject:nil afterDelay:TIME];
}
-(void)setcurrenttag
{
	int i = 0;
	for (i = 0;i<PHOTONUM;i++ ) 
	{
		
		UIImageView *imgview = (UIImageView*)[self.view viewWithTag:TAGSTART+i];		
		int j = array[currenttag - TAGSTART][i];
		float Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
		if (Scalenumber<0.3) 
		{
			Scalenumber = 0.4;
		}
		CATransform3D dtmp = CATransform3DScale(rotationTransform1[i],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
		imgview.layer.transform=dtmp;
		
		//	imgview.layer.needsDisplayOnBoundsChange = YES;
	}
}

-(CAAnimation*)setscale:(NSInteger)tag clicktag:(NSInteger)clicktag
{
	
	
	int i = array[clicktag - TAGSTART][tag - TAGSTART];
	int i1 = array[currenttag - TAGSTART][tag - TAGSTART];
	float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
	float Scalenumber1 = fabs(i1 - PHOTONUM/2.0)/(PHOTONUM/2.0);
	if (Scalenumber<0.3) 
	{
		Scalenumber = 0.4;
	}
	//UIImageView *imgview = (UIImageView*)[self.view viewWithTag:tag];
	CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	animation.duration = TIME;
	animation.repeatCount =1;
	
	
   CATransform3D dtmp = CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
	animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber1*SCALENUMBER,Scalenumber1*SCALENUMBER, 1.0)];
	animation.toValue = [NSValue valueWithCATransform3D:dtmp ];
	animation.autoreverses = NO;	
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	//imgview.layer.transform=dtmp;
	
	return animation;
}

-(CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num
{
	// CALayer
	UIImageView *imgview = (UIImageView*)[self.view viewWithTag:tag];
    CAKeyframeAnimation* animation;
    animation = [CAKeyframeAnimation animation];	
	CGMutablePathRef path = CGPathCreateMutable();
	NSLog(@"原点%f原点%f",imgview.layer.position.x,imgview.layer.position.y);
	CGPathMoveToPoint(path, NULL,imgview.layer.position.x,imgview.layer.position.y);
	
	int p =  [self getblank:tag];
	NSLog(@"旋转%d",p);
	float f = 2.0*M_PI  - 2.0*M_PI *p/PHOTONUM;
	float h = f + 2.0*M_PI *num/PHOTONUM;
	float centery = self.view.center.y - 50;
	float centerx = self.view.center.x;
	float tmpy =  centery + RADIUS*cos(h);
	float tmpx =	centerx - RADIUS*sin(h);
	imgview.center = CGPointMake(tmpx,tmpy);
	
	CGPathAddArc(path,nil,self.view.center.x, self.view.center.y - 50,RADIUS,f+ M_PI/2,f+ M_PI/2 + 2.0*M_PI *num/PHOTONUM,0);	
	animation.path = path;
	CGPathRelease(path);
	animation.duration = TIME;
	animation.repeatCount = 1;
 	animation.calculationMode = @"paced"; 	
	return animation;
}


-(NSInteger)getblank:(NSInteger)tag
{
	if (currenttag>tag) 
	{
		return currenttag - tag;
	}
	else 
	{
		return PHOTONUM  - tag + currenttag;
	}

}

-(void)Scale
{
	[UIView beginAnimations:nil context:(__bridge void *)(self)];
	[UIView setAnimationRepeatCount:3];
    [UIView setAnimationDuration:1];	
	
	/*
	 + (void)setAnimationWillStartSelector:(SEL)selector;                // default = NULL. -animationWillStart:(NSString *)animationID context:(void *)context
	 + (void)setAnimationDidStopSelector:(SEL)selector;                  // default = NULL. -animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
	 + (void)setAnimationDuration:(NSTimeInterval)duration;              // default = 0.2
	 + (void)setAnimationDelay:(NSTimeInterval)delay;                    // default = 0.0
	 + (void)setAnimationStartDate:(NSDate *)startDate;                  // default = now ([NSDate date])
	 + (void)setAnimationCurve:(UIViewAnimationCurve)curve;              // default = UIViewAnimationCurveEaseInOut
	 + (void)setAnimationRepeatCount:(float)repeatCount;                 // default = 0.0.  May be fractional
	 + (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses;
	 */
	
	CATransform3D rotationTransform = CATransform3DIdentity;

    rotationTransform = CATransform3DRotate(rotationTransform,3.14, 1.0, 0.0, 0.0);	
	//rotationTransform = CATransform3DScale (rotationTransform, 0.1,0.1, 2);
    //self.view.transform=CGAffineTransformMakeScale(2,2);
	
	self.view.layer.transform=rotationTransform;
    [UIView setAnimationDelegate:self];	
    [UIView commitAnimations];
}


@end

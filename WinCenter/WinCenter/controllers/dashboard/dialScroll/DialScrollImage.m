//
//  myimgeview.m
//  UIA
//
//  Created by sk on 11-7-28.
//  Copyright 2011 sk. All rights reserved.
//

#import "DialScrollImage.h"
#import"DialScrollVC.h"

@implementation DialScrollImage

- (id)initWithImage:(UIImage *)image text:(NSString *)text
{
    self = [super init];
    if (self) 
    {
        UIImageView *imagview= [[UIImageView alloc]initWithImage:image];
        imagview.frame = CGRectMake(0,0,120,120);
        [self addSubview:imagview];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.0,120,120,20)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:20];
        label.text = text;
        label.textColor = [UIColor blackColor];
        label.textAlignment = UITextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}

-(void)setdege:(id)ID
{
	self.userInteractionEnabled = YES;
	dege = ID;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	DialScrollVC *tmp = (DialScrollVC *)dege;
	[tmp Clickup:self.tag];
}
@end

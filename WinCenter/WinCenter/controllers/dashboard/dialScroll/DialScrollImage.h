//
//  myimgeview.h
//  UIA
//
//  Created by sk on 11-7-28.
//  Copyright 2011 sk. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DialScrollImage : UIImageView
{
	id dege;
}
-(void)setdege:(id)ID;
- (id)initWithImage:(UIImage *)image text:(NSString *)text;
@end

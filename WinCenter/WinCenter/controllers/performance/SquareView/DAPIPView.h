//
//  DAPIPView.h
//  DAPIPViewExample
//
//  Created by Daniel Amitay on 4/12/13.
//  xiaoshu.wb@taobao.com
//  Copyright (c) 2012 http://cia.taobao.org
//

#import <UIKit/UIKit.h>
#import "SquareDelegate.h"

@interface DAPIPView : UIView

@property (nonatomic) UIEdgeInsets borderInsets;
@property (nonatomic,retain) id<SquareDelegate> delegate;

- (void)moveToTopLeftAnimated:(BOOL)animated;
- (void)moveToTopRightAnimated:(BOOL)animated;
- (void)moveToBottomLeftAnimated:(BOOL)animated;
- (void)moveToBottomRightAnimated:(BOOL)animated;

@end

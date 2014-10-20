//
//  SUNButtonBoard.m
//  ButtonBoardTest
//
//  Created by 孙 化育 on 13-8-28.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "SUNButtonBoard.h"

#define POST_NOTIFICATION(X) [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:X object:nil]];

#define TRY_TO_PERFORM(X) if ([_delegate respondsToSelector:@selector(X)]) {[_delegate X];}

static SUNButtonBoard *__board = nil;

NSString *const SUNButtonBoardWillOpenNotification = @"SUNButtonBoardWillOpenNotification";

NSString *const SUNButtonBoardDidOpenNotification = @"SUNButtonBoardDidOpenNotification";

NSString *const SUNButtonBoardWillCloseNotification = @"SUNButtonBoardWillCloseNotification";

NSString *const SUNButtonBoarDidCloseNotification = @"SUNButtonBoarDidCloseNotification";

NSString *const SUNButtonBoarButtonClickNotification = @"SUNButtonBoarButtonClickNotification";

@interface SUNButtonBoard()

@property (nonatomic,assign)BOOL  animating;
@property (nonatomic,assign)BOOL  movedWithKeyboard;

@end


@implementation SUNButtonBoard
@synthesize running = _running;
@synthesize animating = _animating;
@synthesize movedWithKeyboard = _movedWithKeyboard;


+ (SUNButtonBoard *)defaultButtonBoard{
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        __board = [[SUNButtonBoard alloc] init];
    });
    return __board;
}

- (id)init{
    self = [super init];
    if (self) {
        self.autoPosition = YES;
        _boardSize = 50;
        _boardWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 50, 50, 50)];
        _boardWindow.backgroundColor = [UIColor clearColor];
        _boardWindow.windowLevel = 3000;
        _boardWindow.clipsToBounds = NO;

        [_boardWindow makeKeyAndVisible];
        _boardWindow.hidden = YES;
        
        _boardView = [[BoardView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _boardView.backgroundColor = [UIColor clearColor];
        _boardView.selfBoard = self;
        _boardView.backgroundImageView.frame = CGRectMake(0, 0, 50, 50);
        _boardView.backgroundImageView.backgroundColor = [UIColor clearColor];
        _boardView.autoresizingMask = UIViewAutoresizingNone;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesHundel:)];
        [_boardView addGestureRecognizer:gesture];
        gesture.delegate = self;
        
        _boardView.userInteractionEnabled = YES;
        [_boardWindow addSubview:_boardView];
        
        _buttonArray = [[NSMutableArray alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)startRunning{
    if (_running) {
        return;
    }
    _boardWindow.hidden = NO;
    _running = YES;
}

- (void)stopRunning{
    if (!_running) {
        return;
    }
    
    _boardWindow.hidden = YES;
    _running = NO;
}

- (void)setBoardImage:(UIImage *)boardImage{
    _boardView.backgroundImageView.image = boardImage;
}

- (UIImage *)boardImage{
    return _boardView.backgroundImageView.image;
}

- (void)setBoardSize:(float)boardSize{
    if (_isOpen) {
        return;
    }
    _boardSize = boardSize;
    _boardWindow.frame = CGRectMake(_boardWindow.frame.origin.x,
                                    _boardWindow.frame.origin.y,
                                    boardSize,
                                    boardSize);
    _boardView.frame = CGRectMake(_boardView.frame.origin.x,
                                  _boardView.frame.origin.y,
                                  boardSize,
                                  boardSize);
}

- (CGRect)currentFrame{
    if (_isOpen) {
        return _boardView.frame;
    }else{
        return _boardWindow.frame;
    }
    
}

- (void)setBoardPosition:(CGPoint)point animate:(BOOL)animate{
    if (_isOpen) {
        return;
    }
    if (animate) {
        [UIView animateWithDuration:0.3 animations:^{
            _boardWindow.center = point;
        }];
    }else{
        _boardWindow.center = point;
    }
}


#pragma mark- gesture
- (void)tapGesHundel:(UITapGestureRecognizer *)gesture{
    if (_animating) {
        return;
    }
    if (!_isOpen) {
        [self boardOpen];
    }else{
        [self boardClose];
    }
}

- (void)windowTaped:(UITapGestureRecognizer *)gesture{
    if (_animating) {
        return;
    }else{
        
    }
    
    if (_isOpen) {
        [self boardClose];
    }
}


#pragma mark- button

- (void)buttonAction:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:SUNButtonBoarButtonClickNotification object:[NSNumber numberWithInt:sender.tag-100]]];
    
    if ([_delegate respondsToSelector:@selector(buttonBoardClickButtonAtIndex:)]){
        [_delegate buttonBoardClickButtonAtIndex:sender.tag-100];
    }
    
    
    [self boardClose];
}

#pragma mark- method

- (void)boardOpen{
    POST_NOTIFICATION(SUNButtonBoardWillOpenNotification)
    TRY_TO_PERFORM(buttonBoardWillOpen)
    _animating = YES;
    _boardRect = _boardWindow.frame;
    _boardWindow.frame = [[UIScreen mainScreen] bounds];
    _boardView.frame = _boardRect;
    for (int i = 0; i < _buttonNumber; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:_boardView.frame];
        button.adjustsImageWhenHighlighted = NO;
        [button setTitle:[_buttonTitleArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setBackgroundImage:[_buttonImageArray objectAtIndex:i] forState:UIControlStateNormal];
        [_boardWindow addSubview:button];
        [_boardWindow sendSubviewToBack:button];
        [_buttonArray addObject:button];
        button.backgroundColor = [UIColor clearColor];
        button.tag = i+100;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    int direction = [_boardView directByPoint:_boardView.center];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         for (int i = 0; i<_buttonArray.count; i++) {
                             UIButton *button = [_buttonArray objectAtIndex:i];
                             switch (direction) {
                                 case 0:
                                     button.frame = CGRectMake(button.frame.origin.x,
                                                               button.frame.origin.y+((i+1)*_boardSize),
                                                               _boardSize,
                                                               _boardSize);
                                     break;
                                 case 1:
                                     button.frame = CGRectMake(button.frame.origin.x-((i+1)*_boardSize),
                                                               button.frame.origin.y,
                                                               _boardSize,
                                                               _boardSize);
                                     break;
                                 case 2:
                                     button.frame = CGRectMake(button.frame.origin.x,
                                                               button.frame.origin.y-((i+1)*_boardSize),
                                                               _boardSize,
                                                               _boardSize);
                                     break;
                                 case 3:
                                     button.frame = CGRectMake(button.frame.origin.x+((i+1)*_boardSize),
                                                               button.frame.origin.y,
                                                               _boardSize,
                                                               _boardSize);
                                     break;
                                     
                                 default:
                                     break;
                             }
                         }
                     }
                     completion:^(BOOL finished) {
                         POST_NOTIFICATION(SUNButtonBoardDidOpenNotification)
                         TRY_TO_PERFORM(buttonBoardDidOpen)
                         _animating = NO;
                         _isOpen = YES;
                         UITapGestureRecognizer *windowTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowTaped:)];
                         [_boardWindow addGestureRecognizer:windowTapGes];
                     }];
}


- (void)boardClose{
    POST_NOTIFICATION(SUNButtonBoardWillCloseNotification)
    TRY_TO_PERFORM(buttonBoardWillClose)
    _animating = YES;
    [UIView animateWithDuration:0.3
                     animations:^{
                         for (int i = 0; i<_buttonArray.count; i++){
                             UIButton *button = [_buttonArray objectAtIndex:i];
                             button.frame = _boardRect;
                         }
                     }
                     completion:^(BOOL finished) {
                         for (int i = 0; i<_buttonArray.count; i++){
                             UIButton *button = [_buttonArray objectAtIndex:i];
                             [button removeFromSuperview];
                         }
                         [_buttonArray removeAllObjects];
                         POST_NOTIFICATION(SUNButtonBoarDidCloseNotification)
                         TRY_TO_PERFORM(buttonBoardDidClose)
                         _animating = NO;
                         _isOpen = NO;
                         _boardWindow.frame = _boardRect;
                         _boardView.frame = CGRectMake(0, 0, _boardSize, _boardSize);
                         [_boardWindow removeGestureRecognizer:[[_boardWindow gestureRecognizers] lastObject]];
                     }];
}


- (void)keyboardFrameWillChange:(NSNotification *)noti{
    NSValue *value = [noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    float yPoint = rect.origin.y;
    
    CGRect newRect;
    
    if (yPoint == [[UIScreen mainScreen] bounds].size.height) {
        if (_movedWithKeyboard) {
            newRect = CGRectMake(_boardWindow.frame.origin.x,
                                 yPoint - _boardWindow.frame.size.height,
                                 _boardWindow.frame.size.width,
                                 _boardWindow.frame.size.height);
            _movedWithKeyboard = NO;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 _boardWindow.frame = newRect;
                             }
                             completion:^(BOOL finished) {
                                 
                             }];
        }
    }else{
        if (_boardWindow.frame.origin.y > yPoint) {
            newRect = CGRectMake(_boardWindow.frame.origin.x,
                                 yPoint - _boardWindow.frame.size.height,
                                 _boardWindow.frame.size.width,
                                 _boardWindow.frame.size.height);
            _movedWithKeyboard = YES;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 _boardWindow.frame = newRect;
                             }
                             completion:^(BOOL finished) {
                                 
                             }];
        }
    }
    
}


@end

//-------------------------------------------------------------------------//


@implementation BoardView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundImageView = [[UIImageView alloc] init];
        [self addSubview:_backgroundImageView];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _backgroundImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_selfBoard.animating) {
        return;
    }

    UITouch *touch = [touches anyObject];
    _beginPoint = [touch locationInView:self.window];
    _selfBeginCenter = self.center;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_selfBoard.animating) {
        return;
    }
    if (_selfBoard.isOpen) {
        return;
    }
    _moving = YES;
    UITapGestureRecognizer *ges = [self.gestureRecognizers lastObject];
    ges.enabled = NO;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.window];
    self.center = CGPointMake(_selfBeginCenter.x+(point.x - _beginPoint.x),
                              _selfBeginCenter.y+(point.y - _beginPoint.y));
    
    UITouch *previousTouch = [touches anyObject];
    CGPoint previousPoint = [previousTouch previousLocationInView:self.window];
    
    _direction = NSNotFound;
    int velocity = [self velocityByPoint:point andPoint:previousPoint];
    if (abs(velocity) > 15) {
        int velocityX = point.x - previousPoint.x;
        int velocityY = point.y - previousPoint.y;
        if (abs(velocityX) > abs(velocityY)) {
            if (velocity>0) {
                _direction = 1;
            }else{
                _direction = 3;
            }
        }else{
            if (velocity>0) {
                _direction = 2;
            }else{
                _direction = 0;
            }
        }
    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_moving) {
        _moving = NO;
        UITapGestureRecognizer *ges = [self.gestureRecognizers lastObject];
        ges.enabled = YES;
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.window];
        self.window.center = CGPointMake(self.window.center.x + (point.x - _beginPoint.x),
                                         self.window.center.y + (point.y - _beginPoint.y));
        self.frame = CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height);
        
        
        if (self.selfBoard.autoPosition) {
            int direction = INT16_MAX;
            
            
            if (_direction != NSNotFound) {
                direction = _direction;
            }else{
                direction = [self directByPoint:self.window.center];
            }
            
            
            
            CGRect newRect;
            
            switch (direction) {
                case 0:
                    newRect = CGRectMake(self.window.frame.origin.x,
                                         0,
                                         self.window.frame.size.width,
                                         self.window.frame.size.height);
                    break;
                case 1:
                    newRect = CGRectMake([[UIScreen mainScreen] bounds].size.width - self.window.frame.size.width,
                                         self.window.frame.origin.y,
                                         self.window.frame.size.width,
                                         self.window.frame.size.height);
                    break;
                case 2:
                    newRect = CGRectMake(self.window.frame.origin.x,
                                         [[UIScreen mainScreen] bounds].size.height - self.window.frame.size.height,
                                         self.window.frame.size.width,
                                         self.window.frame.size.height);
                    break;
                case 3:
                    newRect = CGRectMake(0,
                                         self.window.frame.origin.y,
                                         self.window.frame.size.width,
                                         self.window.frame.size.height);
                    break;
                    
                default:
                    break;
            }
            
            [UIView animateWithDuration:0.3
                             animations:^{
                                 self.window.frame = newRect;
                             }
                             completion:^(BOOL finished) {
                                 
                             }];
            self.selfBoard.movedWithKeyboard = NO;
        }
    }
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_moving) {
        _moving = NO;
        UITapGestureRecognizer *ges = [self.gestureRecognizers lastObject];
        ges.enabled = YES;
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.window];
        self.window.center = CGPointMake(self.window.center.x + (point.x - _beginPoint.x),
                                         self.window.center.y + (point.y - _beginPoint.y));
        self.frame = CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height);
    }
}



#pragma mark- tool

- (int)directByPoint:(CGPoint)point{
    int dir = INT_MAX;
    int min = INT_MAX;
    if (abs(point.x - 0)<min) {
        min = abs(point.x - 0);
        dir = 3;
    }
    if (abs([[UIScreen mainScreen] bounds].size.width - point.x)<min) {
        min = abs([[UIScreen mainScreen] bounds].size.width - point.x);
        dir = 1;
    }
    if (abs(point.y - 0)<min) {
        min = abs(point.y - 0);
        dir = 0;
    }
    if (abs([[UIScreen mainScreen] bounds].size.height - point.y)<min) {
        min = abs([[UIScreen mainScreen] bounds].size.width - point.x);
        dir = 2;
    }
    
    return dir;
}


- (int)velocityByPoint:(CGPoint)point1 andPoint:(CGPoint)point2{
    int velocityX = point1.x - point2.x;
    int velocityY = point1.y - point2.y;
    
    if (abs(velocityX) > abs(velocityY)) {
        return velocityX;
    }else{
        return velocityY;
    }
}


@end












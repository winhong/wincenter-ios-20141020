//
//  SUNButtonBoard.h
//  ButtonBoardTest
//
//  Created by 孙 化育 on 13-8-28.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol SUNButtonBoardDelegate <NSObject>

@optional

- (void)buttonBoardWillOpen;
- (void)buttonBoardDidOpen;
- (void)buttonBoardWillClose;
- (void)buttonBoardDidClose;

    //某个按钮被点击时回调，参数为buttonIndex
- (void)buttonBoardClickButtonAtIndex:(int)index;


@end

@class BoardView;

@interface SUNButtonBoard : NSObject<UIGestureRecognizerDelegate>{
    UIWindow        *_boardWindow;
    BOOL            _running;
    BoardView       *_boardView;
    CGRect          _boardRect;
    NSMutableArray  *_buttonArray;
    BOOL            _animating;
    BOOL            _movedWithKeyboard;
}

    //使用单例类，方便在全局控制
+ (SUNButtonBoard *)defaultButtonBoard;


    //虽然提供了delegate，但是ButtonBoard不是针对某个界面的，全局性太大，所以还是建议用notification
@property (nonatomic,assign) id<SUNButtonBoardDelegate> delegate;


    //按钮的个数
@property (nonatomic,assign)int     buttonNumber;


    //按钮板的背景图
@property (nonatomic,assign)UIImage *boardImage;


    //按钮图片的数组，按顺序提供每个按钮的图片，请保证数组里都是UIImage
@property (nonatomic,retain)NSArray *buttonImageArray;


    //按钮标题的数组，提供每个按钮的标题，实际作用不大，因为按钮太小，加了文字就不好看了；
@property (nonatomic,retain)NSArray *buttonTitleArray;


    //按钮板的尺寸，建议设置在30到60之间，默认为50
@property (nonatomic,assign)float boardSize;


    //是否自动定位到屏幕边缘，默认为YES
@property (nonatomic,assign)BOOL    autoPosition;


    //是否正在显示
@property (nonatomic,readonly)BOOL    running;


    //是否处于打开状态
@property (nonatomic,readonly)BOOL      isOpen;


    //当前在屏幕的位置frame
@property (nonatomic,readonly)CGRect    currentFrame;


    //开始显示
- (void)startRunning;


    //停止显示
- (void)stopRunning;


    //设置按钮板位置,point指的是center
- (void)setBoardPosition:(CGPoint)point animate:(BOOL)animate;



@end



    //所有的通知

extern NSString *const SUNButtonBoardWillOpenNotification;

extern NSString *const SUNButtonBoardDidOpenNotification;

extern NSString *const SUNButtonBoardWillCloseNotification;

extern NSString *const SUNButtonBoarDidCloseNotification;


    //notification附带的object是NSNumber，就是所点击button的index
extern NSString *const SUNButtonBoarButtonClickNotification;


//-------------------------------------------------------------------------//

@interface BoardView : UIView{
    CGPoint     _beginPoint;
    CGPoint     _selfBeginCenter;
    int         _direction;
}

@property (nonatomic,assign)SUNButtonBoard *selfBoard;
@property (nonatomic,readonly)BOOL moving;
@property (nonatomic,retain)UIImageView *backgroundImageView;

- (int)directByPoint:(CGPoint)point;

@end









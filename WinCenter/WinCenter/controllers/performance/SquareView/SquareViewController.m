//
//  ViewController.m
//  DAPIPViewExample
//
//  Created by Daniel Amitay on 4/12/13.
//  xiaoshu.wb@taobao.com
//  Copyright (c) 2012 http://cia.taobao.org
//

#import "SquareViewController.h"
//#import <AVFoundation/AVFoundation.h>

@interface SquareViewController (){
    UIView *uiview1;
    UIView *uiview2;
    UIView *uiview3;
    UIView *uiview4;
    
    //    UIImageView *counterImageView;
    //    UIImageView *counterImageView2;
    //    UIImageView *counterImageView3;
    //    UIImageView *counterImageView4;
}

@end

NSString *const BNRChangedNotfication = @"BNRChangedNotfication";

@implementation SquareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.pipView = [[DAPIPView alloc] init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        self.pipView.borderInsets = UIEdgeInsetsMake(1.0f,       // top
                                                     1.0f,       // left
                                                     45.0f,      // bottom
                                                     1.0f);      // right
    }
    else
    {
        self.pipView.borderInsets = UIEdgeInsetsMake(1.0f,       // top
                                                     1.0f,       // left
                                                     1.0f,       // bottom
                                                     1.0f);      // right
    }
    self.pipView.delegate = self;
    self.pipView.frame = CGRectMake(
                               self.pipView.frame.origin.x,
                               self.pipView.frame.origin.y,
                               65,65 );
    
    UIView *mainContentView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainContentView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:0.5f];
    mainContentView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                        UIViewAutoresizingFlexibleRightMargin |
                                        UIViewAutoresizingFlexibleTopMargin |
                                        UIViewAutoresizingFlexibleBottomMargin);
    [self.view addSubview:mainContentView];
    
    UILabel *mainViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                       0.0f,
                                                                       100.0f,
                                                                       44.0f)];
    mainViewLabel.text = @"http://cia.taobao.org";
    mainViewLabel.textColor = [UIColor whiteColor];
    mainViewLabel.center = self.view.center;
    mainViewLabel.textAlignment = UITextAlignmentCenter;
    mainViewLabel.backgroundColor = [UIColor clearColor];
    mainViewLabel.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                      UIViewAutoresizingFlexibleRightMargin |
                                      UIViewAutoresizingFlexibleTopMargin |
                                      UIViewAutoresizingFlexibleBottomMargin);
    [self.view addSubview:mainViewLabel];
    
    UILabel *pipViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                      0.0f,
                                                                      100.0f,
                                                                      44.0f)];
    pipViewLabel.text = @"MOVE ME";
    pipViewLabel.font = [UIFont systemFontOfSize:14.0f];
    pipViewLabel.textColor = [UIColor whiteColor];
    pipViewLabel.center = CGPointMake(self.pipView.bounds.size.width/2.0f,
                                      self.pipView.bounds.size.height/2.0f);
    pipViewLabel.textAlignment = UITextAlignmentCenter;
    pipViewLabel.backgroundColor = [UIColor clearColor];
    [self.pipView addSubview:pipViewLabel];
    
    
    /*
     The below code will add an AVCaptureVideoPreviewLayer if run on a device with a camera
     */
    
//    AVCaptureDeviceInput *input = nil;
//    for (AVCaptureDevice *device in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo])
//    {
//        input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];;
//        if (device.position == AVCaptureDevicePositionFront)
//        {
//            break;
//        }
//    }
//    
//    if (!input)
//        return;
//    
//    AVCaptureSession *session = [[AVCaptureSession alloc] init];
//    [session addInput:input];
//    
//    UIView *presentationView = nil;
//    if (input.device.position == AVCaptureDevicePositionFront)
//        presentationView = pipView;
//    else
//        presentationView = mainContentView;
//    
//        AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
//        captureVideoPreviewLayer.frame = presentationView.bounds;
//        captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//        [presentationView.layer addSublayer:captureVideoPreviewLayer];
//        [captureVideoPreviewLayer.session startRunning];
    
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    uiview1 = [[UIView alloc]initWithFrame:self.view.frame];
    uiview1.backgroundColor = [UIColor whiteColor];
    
    uiview2 = [[UIView alloc]initWithFrame:self.view.frame];
    uiview2.backgroundColor = [UIColor redColor];
    
    uiview3 = [[UIView alloc]initWithFrame:self.view.frame];
    uiview3.backgroundColor = [UIColor grayColor];
    
    uiview4 = [[UIView alloc]initWithFrame:self.view.frame];
    uiview4.backgroundColor = [UIColor yellowColor];
    
    CGFloat width  = self.view.bounds.size.width/2;
    CGFloat height  = self.view.bounds.size.height/2;
    
    uiview1.center = CGPointMake(self.pipView.center.x + width,
                                 self.pipView.center.y +height);
    
    
    uiview2.center = CGPointMake(self.pipView.center.x + width,self.pipView.center.y-height);
    
    
    uiview3.center = CGPointMake(self.pipView.center.x - width,
                                 self.pipView.center.y +height);
    
    uiview4.center = CGPointMake(self.pipView.center.x - width,
                                 self.pipView.center.y - height);
    
    
    
    //     counterImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"anniu.png"]];
    //    //counterImageView.frame = self.view.frame;
    //
    //     counterImageView.frame = CGRectMake(0,0,self.view.frame.size.width/2,self.view.frame.size.height/2);
    //    [uiview1 addSubview:counterImageView];
    //
    //
    //     counterImageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"anniu.png"]];
    //
    //     counterImageView2.frame = CGRectMake(0,uiview2.frame.size.height/2,self.view.frame.size.width/2,self.view.frame.size.height/2);
    //     [uiview2 addSubview:counterImageView2];
    //
    //    counterImageView3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"anniu.png"]];
    //     counterImageView3.frame = CGRectMake(uiview3.frame.size.width/2,0,self.view.frame.size.width/2,self.view.frame.size.height/2);
    //    [uiview3 addSubview:counterImageView3];
    //
    //    counterImageView4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"anniu.png"]];
    //    counterImageView4.frame = CGRectMake(uiview4.frame.size.width/2,uiview4.frame.size.height/2,self.view.frame.size.width/2,self.view.frame.size.height/2);
    //    [uiview4 addSubview:counterImageView4];
    
    
    
    [self.view addSubview:uiview1];
    [self.view addSubview:uiview2];
    [self.view addSubview:uiview3];
    [self.view addSubview:uiview4];
    
    
    //添加监听
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(handlerMove:) name:BNRChangedNotfication object:nil];
    
}


-(void)ZoomDown{
    
}

-(void)ZoomUp{
    
    //    [UIView animateWithDuration:1.0f animations:^{
    //        //counterImageView.frame = counterImageView.superview.frame;
    //        counterImageView.center = counterImageView.superview.center;
    //    }];
    
    
}


-(void)handlerMove:(NSNotification *)note{
    NSValue *val = (NSValue*)[[note userInfo]objectForKey:BNRChangedNotfication];
    
    CGPoint centerPoint = [val CGPointValue];
    CGFloat width  = self.view.bounds.size.width/2;
    CGFloat height  = self.view.bounds.size.height/2;
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    
    uiview1.center = CGPointMake(centerPoint.x + width,
                                 centerPoint.y +height);
    
    uiview2.center = CGPointMake(centerPoint.x + width,
                                 centerPoint.y - height);
    
    uiview3.center = CGPointMake(centerPoint.x - width,
                                 centerPoint.y + height);
    
    uiview4.center = CGPointMake(centerPoint.x - width,
                                 centerPoint.y - height);
    
    
    
    
    [UIView commitAnimations];
    
}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    else
        return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //
    //    NSDictionary *d =[NSDictionary dictionaryWithObject:@"yesYES" forKey:@"yes"];
    //
    //    [nc postNotificationName:BNRChangedNotfication object:self userInfo:d];
    
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([touch view] == uiview1||[touch view] == uiview2 || [touch view] == uiview3 || [touch view] == uiview4) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2f];
        [touch view].center = self.view.center;
        [UIView commitAnimations];
        
    }
    
    
}

-(void)moveComplete{
    //[self ZoomUp];
}

@end

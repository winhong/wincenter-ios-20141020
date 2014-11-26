//
//  AppDelegate.m
//  WinCenter
//
//  Created by apple on 14/10/18.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "AppDelegate.h"
#import "SUNButtonBoard.h"
#import <COSTouchVisualizer/COSTouchVisualizerWindow.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)boardButtonClick:(NSNotification *)nofi{
    NSNumber *num = [nofi object];
    switch ([num intValue]) {
        case 0:{

            break;
        }case 1:{

            break;
        }case 2:{

            break;
        }default:{
            break;
        }
    }
}

- (COSTouchVisualizerWindow *)window
{
    static COSTouchVisualizerWindow *customWindow = nil;
    if (!customWindow) {
        customWindow = [[COSTouchVisualizerWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [customWindow setFillColor:[UIColor yellowColor]];
        [customWindow setStrokeColor:[UIColor purpleColor]];
        [customWindow setTouchAlpha:0.4];
        
        [customWindow setRippleFillColor:[UIColor yellowColor]];
        [customWindow setRippleStrokeColor:[UIColor purpleColor]];
        [customWindow setRippleAlpha:0.1];
    }
    return customWindow;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"SERVER_ROOT"] == nil){
        [[NSUserDefaults standardUserDefaults] setValue:@"https://192.168.207.85:8090" forKey:@"SERVER_ROOT"];
    }
    //[[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"USER_NAME"];
    //[[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"PASSWORD"];
    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        SUNButtonBoard *board = [SUNButtonBoard defaultButtonBoard];
//        board.boardImage = [UIImage imageNamed:@"SUNButtonBoard_button3.png"];
//        board.buttonNumber = 3;
//        NSArray *imgArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"SUNButtonBoard_button1.png"],
//                             [UIImage imageNamed:@"SUNButtonBoard_button2.png"],
//                             [UIImage imageNamed:@"SUNButtonBoard_button3.png"],nil];
//        board.buttonImageArray = imgArray;
//        if (!board.running) {
//            [board startRunning];
//        }
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(boardButtonClick:) name:SUNButtonBoarButtonClickNotification object:nil];
//    }
    
    self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewController:@"LoginVC"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

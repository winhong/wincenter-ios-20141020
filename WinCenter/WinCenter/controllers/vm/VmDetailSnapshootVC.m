//
//  VmDetailSnapshootVC.m
//  wincenterDemo01
//
//  Created by huadi on 14-8-21.
//  Copyright (c) 2014年 huadi. All rights reserved.
//

#import "VmDetailSnapshootVC.h"
#import "WebViewJavascriptBridge.h"

@interface VmDetailSnapshootVC ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property WebViewJavascriptBridge* bridge;
@property NSString *snashotData;
@end

@implementation VmDetailSnapshootVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
    
    [WebViewJavascriptBridge enableLogging];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webview webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC received message from JS: %@", data);
        responseCallback(@"Response for message from ObjC");

    }];
    
    //
    NSString* htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"RealtimeCurve.bundle/index4snashot.html"];
    
    NSURL* url = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)refreshAction:(id)sender {
    [self reloadData];
    self.parentViewController.parentViewController.navigationItem.rightBarButtonItem.enabled = true;
}
-(void)reloadData{

    [self.vmVO getRaphaelAsync:^(id object, NSError *error) {
        self.snashotData = object;
        [_bridge callHandler:@"testJavascriptHandler" data:self.snashotData];
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [self reloadData];
    
    
    
    
    //等webview加载完毕再更新数据
    //    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1
    //                                             target: self
    //                                           selector: @selector(updateData)
    //                                           userInfo: nil
    //                                            repeats: YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

/*
 The MIT License
 
 Copyright (c) 2013 Mashape (http://mashape.com)
 
 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#import "UNIRest.h"
#import "UNIHTTPRequest.h"
#import "UNIHTTPClientHelper.h"

int hudCounter = 0;

@implementation UNIHTTPRequest

-(instancetype) initWithSimpleRequest:(UNIHTTPMethod) httpMethod url:(NSString*) url headers:(NSDictionary*) headers username:(NSString*) username password:(NSString*) password {
    self = [super init];
    if (self) {
        [self setHttpMethod:httpMethod];
        [self setUrl:url];
        [self setUsername:username];
        [self setPassword:password];
        NSMutableDictionary* lowerCaseHeaders = [[NSMutableDictionary alloc] init];
        if (headers != nil) {
            for(id key in headers) {
                id value = [headers objectForKey:key];
                [lowerCaseHeaders setObject:value forKey:[key lowercaseString]];
            }
        }
        [self setHeaders:lowerCaseHeaders];
    }
    return self;
}

-(UNIHTTPStringResponse*) asString {
    return [self asString:nil];
}

-(UNIHTTPStringResponse*) asString:(NSError**) error {
    UNIHTTPResponse* response = [UNIHTTPClientHelper requestSync:self error:error];
    if (response == nil) return nil;
    return [[UNIHTTPStringResponse alloc] initWithSimpleResponse:response];
}

-(UNIUrlConnection*) asStringAsync:(UNIHTTPStringResponseBlock) response {
    return [UNIHTTPClientHelper requestAsync:self handler:^(UNIHTTPResponse * res, NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                response(nil, error);
            } else {
                response([[UNIHTTPStringResponse alloc] initWithSimpleResponse:res], error);
            }
        });
    }];
}

-(UNIHTTPBinaryResponse*) asBinary {
    return [self asBinary:nil];
}

-(UNIHTTPBinaryResponse*) asBinary:(NSError**) error {
    UNIHTTPResponse* response = [UNIHTTPClientHelper requestSync:self error:error];
    if (response == nil) return nil;
    return [[UNIHTTPBinaryResponse alloc] initWithSimpleResponse:response];
}

-(UNIUrlConnection*) asBinaryAsync:(UNIHTTPBinaryResponseBlock) response {
    return [UNIHTTPClientHelper requestAsync:self handler:^(UNIHTTPResponse * res, NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                response(nil, error);
            } else {
                response([[UNIHTTPBinaryResponse alloc] initWithSimpleResponse:res], error);
            }
        });
    }];
}

-(UNIHTTPJsonResponse*) asJson {
    return [self asJson:nil];
}

-(UNIHTTPJsonResponse*) asJson:(NSError**) error {
    UNIHTTPResponse* response = [UNIHTTPClientHelper requestSync:self error:error];
    if (response == nil) return nil;
    return [[UNIHTTPJsonResponse alloc] initWithSimpleResponse:response];
}

-(UNIUrlConnection*) asJsonAsync:(UNIHTTPJsonResponseBlock) response {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //if(!self.jgHud){
    //    self.jgHud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    //    self.jgHud.textLabel.text = @"Loading";
    //}
    //[self.jgHud showInView:[UIApplication sharedApplication].keyWindow animated:NO];
    //self.mbHud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hudCounter++;
    if(hudCounter==1){
        [SVProgressHUD show];
    }
    
    return [UNIHTTPClientHelper requestAsync:self handler:^(UNIHTTPResponse * res, NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            //[self.jgHud dismissAnimated:NO];
            //[self.mbHud hide:NO];
            if(hudCounter==1){
                [SVProgressHUD dismiss];
            }
            hudCounter--;
            
            if (error != nil) {
                if([error.domain isEqualToString:@"NSURLErrorDomain"]){
                    // There are several ways to init, just look at the class header
                    NZAlertView *alert = [[NZAlertView alloc] initWithStyle:NZAlertStyleError
                                                                      title:@"请求超时"
                                                                    message:@"网络连接失败或请求后台超时(60秒)，请检查网络状态或服务器地址是否正确！"
                                                                   delegate:nil];
                    //[alert setTextAlignment:NSTextAlignmentCenter];
                    [alert show];
                    [alert showWithCompletion:^{
                        NSLog(@"Alert with completion handler");
                    }];
                }
                //response(nil, error);
                return;
            } else {
                if(res==nil){
                    response(nil, error);
                }else{
                    UNIHTTPJsonResponse *jsonResponse = [[UNIHTTPJsonResponse alloc] initWithSimpleResponse:res];
                    if(jsonResponse){
                        NSString *cookieStr = [jsonResponse.headers valueForKey:@"Set-Cookie"];
                        if(cookieStr!=nil){
                            cookieStr = [cookieStr componentsSeparatedByString:@";"][0];
                            [UNIRest defaultHeader:@"Cookie" value:cookieStr];
                        }
                    }
                    response(jsonResponse, error);
                }
                
            }
        });
    }];
}

@end

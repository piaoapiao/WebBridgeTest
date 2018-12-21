//
//  ViewController.m
//  WebBridgeTest
//
//  Created by guodong on 2018/12/21.
//  Copyright © 2018年 Maizi. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ViewController ()
@property (nonatomic,strong)  UIWebView *webView;
@property (nonatomic,strong)  NSString *urlString;
@property WebViewJavascriptBridge *bridge;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.urlString = @"http://oneccc.bid/WebBridgeTest/bridge.html";
//    self.urlString = @"https://baidu.com";
    [self createBridge];
    [self registerMessage];
    // Do any additional setup after loading the view, typically from a nib.
}

-(UIWebView *)webView
{
    if(!_webView)
    {
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
//        _webView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_webView];
    }
    return _webView;
}


-(void)createBridge
{
    NSString *encodedString = [self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:encodedString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    //   jsBridge 处理与js的交互
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridge:_webView];
    
}

-(void)registerMessage
{
    [self.bridge registerHandler:@"showAppPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *dataDict = (NSDictionary *)data;
        NSLog(@"dataDict:%@",data);
    }];
    
}

@end

     

//
//  NewsWebView.m
//  toolsDemo
//
//  Created by Mr.Q on 16/6/5.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import "NewsWebController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface NewsWebController ()<UIWebViewDelegate>

@end

@implementation NewsWebController

- (void)viewDidLoad {
    [super viewDidLoad];


    UIWebView *webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:webView];
    // 发送请求
    NSURL *url = [NSURL URLWithString:self.url];
    NSLog(@"url %@",url);
    // 请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    // 发送异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        // response,服务器返回的响应头
        // data 服务器返回的响应体
        // connecionError 链接错误
        // 判断请求是否有错误
        if (!connectionError) {
            [webView loadRequest:request];
        }else{
            NSLog(@"连接错误%@",connectionError);
        }
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{

    [self.webView stringByEvaluatingJavaScriptFromString:
     @"document.getElementsByClassName(\"topbar\")[0].style.display = 'none'"];

    [self.webView stringByEvaluatingJavaScriptFromString:
     @"document.getElementsByClassName(\"a_adtemp a_topad js-topad\")[0].style.display = 'none'"];

    // starting the load, show the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.webView isLoading]) {
        [self.webView stopLoading];
    }
    self.webView.delegate = nil;    // disconnect the delegate as the webview is hidden
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)dealloc{
    NSLog(@"web dealloc ");
}

@end

//
//  NewsWebView.m
//  toolsDemo
//
//  Created by Mr.Q on 16/6/5.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import "NewsWebController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface NewsWebController ()

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
-(void)dealloc{
    NSLog(@"web dealloc ");
}

@end

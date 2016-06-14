//
//  QNetWorkTools.m
//  toolsDemo
//
//  Created by Mr.Q on 16/6/10.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import "QNetWorkTools.h"

@implementation QNetWorkTools

+ (instancetype)sharedNetworkTools{

    static QNetWorkTools *instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];

        config.timeoutIntervalForRequest = 15;
        
        instance = [[self alloc]initWithBaseURL:baseURL sessionConfiguration:config];

        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
    });
    return instance;
}


@end

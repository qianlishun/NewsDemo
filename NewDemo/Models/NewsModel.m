//
//  NewsModel.m
//  toolsDemo
//
//  Created by Mr.Q on 16/6/4.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import "NewsModel.h"
#import "MJExtension.h"
#import "QNetWorkTools.h"
#import "XYString.h"
#import <objc/runtime.h>
@implementation NewsModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"imgextra":@"Imgextra",
             @"editor":@"Editor",
             @"ads":@"Ads"
             };
}

#pragma mark - 请求数据
+ (void)newsWithURLString:(NSString *)urlString success:(void (^)(NSArray *))success errorBlock:(void (^)(NSError *))errorBlock{
    
    QNetWorkTools *tools = [QNetWorkTools sharedNetworkTools];

    [tools GET:urlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {

        NSString *key = responseObject.keyEnumerator.nextObject;
        
        NSArray *tempArray = responseObject[key];

        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:10];

        arrayM = [NSMutableArray arrayWithArray:[NewsModel mj_objectArrayWithKeyValuesArray:tempArray]];

        if (success) {
            success(arrayM.copy);
        }

    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (error) {
            errorBlock(error);
        }
    }];

}

@end

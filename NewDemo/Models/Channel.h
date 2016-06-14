//
//  Channel.h
//  toolsDemo
//
//  Created by Mr.Q on 16/6/10.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject

@property (nonatomic,copy) NSString  *tname;
@property (nonatomic,copy) NSString  *tid;

@property (nonatomic,copy,readonly) NSString  *urlString;


+ (instancetype)channelWithDic:(NSDictionary *)dic;
+ (NSArray *)channels;
@end

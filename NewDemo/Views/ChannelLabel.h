//
//  ChannelLabel.h
//  toolsDemo
//
//  Created by Mr.Q on 16/6/10.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelLabel : UILabel
+ (instancetype)channelLabelWithTName:(NSString *)tname;

@property (nonatomic, assign) CGFloat scale;

@end

//
//  UINavigationItem+Custom.m
//  QLSNavTab
//
//  Created by Mr.Q on 16/5/12.
//  Copyright © 2016年 QLS. All rights reserved.
//

#import "UINavigationItem+Custom.h"

@implementation UINavigationItem (Custom)

-(void)setMyTitle:(NSString*)title{

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];

    titleLabel.textColor = [UIColor whiteColor];

    titleLabel.textAlignment = NSTextAlignmentCenter;

    titleLabel.text = title;

    self.titleView=titleLabel;
}

@end

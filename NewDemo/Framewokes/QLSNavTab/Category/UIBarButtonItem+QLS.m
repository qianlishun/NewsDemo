//
//  UIBarButtonItem+QLS.m
//  QLSNavTab
//
//  Created by Mr.Q on 16/5/12.
//  Copyright © 2016年 QLS. All rights reserved.
//

#import "UIBarButtonItem+QLS.h"

@implementation UIBarButtonItem (QLS)

+(UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside
     ];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end

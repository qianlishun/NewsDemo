//
//  UIBarButtonItem+QLS.h
//  QLSNavTab
//
//  Created by Mr.Q on 16/5/12.
//  Copyright © 2016年 QLS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (QLS)

/**
 *  快速创建Item
 *
 *  @param image     默认图
 *  @param highImage 高亮图
 *  @param target
 *  @param action
 *
 *  @return
 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;
@end

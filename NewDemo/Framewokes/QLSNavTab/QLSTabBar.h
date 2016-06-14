//
//  QLSTabBar.h
//  QLSNavTab
//
//  Created by Mr.Q on 16/5/12.
//  Copyright © 2016年 QLS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLSTabItem.h"


@class QLSTabBar;

#define kTabBarHeight 49

@protocol QLSTabBarDelegate <NSObject>

@optional
- (void)tabbar:(QLSTabBar *)tabbar to:(NSInteger)to;

@end

@interface QLSTabBar : UIView

//- (void)addButtonWithClickBlock:(void (^)(QLSTabBar *tabbar, NSInteger clickIndex))code andImage:(UIImage *)image andSelectedImage:(UIImage *)imageSelected;


@property (nonatomic,weak) QLSTabItem *selectedItem;


@property (nonatomic,weak) id<QLSTabBarDelegate> delegate;



// 添加tab按钮的方法
-(void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)icon_selected title:(NSString *)title;


@end


//
//  QLSTabBarController.h
//  QLSNavTab
//
//  Created by Mr.Q on 16/5/12.
//  Copyright © 2016年 QLS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLSTabBar.h"

#define VC_VIEWCONTROLLER @"VC"

#define VC_STORYBOARD @"SB"

#define NORMAL_ICON @"ICONOR"

#define  SELECTED_ICON @"ICONSE"

#define TITLE @"TITLE"

@interface QLSTabBarController : UITabBarController{
    @public
    QLSTabBar *_tabBar;

}

// 子控制信息数组
@property (nonatomic,strong) NSArray *childControllerAndIconArr;

@property (nonatomic,strong) UIColor *navigationBackgroundColor;


@end

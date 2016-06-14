//
//  QLSTabBar.m
//  QLSNavTab
//
//  Created by Mr.Q on 16/5/12.
//  Copyright © 2016年 QLS. All rights reserved.
//

#import "QLSTabBar.h"

@interface QLSTabBar ()

@end

@implementation QLSTabBar

-(void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)icon_selected title:(NSString *)title{

    QLSTabItem *item = [[QLSTabItem alloc]init];

    // 文字
    [item setTitle:title forState:UIControlStateNormal];
    item.titleLabel.textColor = [UIColor lightGrayColor];

    // 图标
    if (icon) {
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    }
    if (icon_selected) {
    [item setImage:[UIImage imageNamed:icon_selected] forState:UIControlStateSelected];
    }
    // 监听点击
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];

    // 添加item
    [self addSubview:item];

    NSInteger count = self.subviews.count;

    // 默认选中第一个item
    if(count == 1){
        [self itemClick:item];
    }
    // 调整 所有item的frame
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width / count;

    for (int i=0; i<count; i++) {
        QLSTabItem *tabItem = self.subviews[i];
        tabItem.tag = i;
        tabItem.frame = CGRectMake(width * i, 0, width, height);
    }
}



-(void)itemClick:(QLSTabItem *)item{

    // 0:通知代理
    if([_delegate respondsToSelector:@selector(tabbar:to:)] ){
        [_delegate tabbar:self to:item.tag];
    }
    // 取消选中 之前选中的item
    _selectedItem.selected = NO;

    // 选中点击的item
    item.selected = YES;

    // 保存当前item状态
    _selectedItem = item;

}
// Block 方法
//-(void)addButtonWithClickBlock:(void (^)(QLSTabBar *, NSInteger))code andImage:(UIImage *)image andSelectedImage:(UIImage *)imageSelected{
//
//    self.code = code;
//
//    // 创建button
//
//    CZTabBarButton* tabbarBtn = [[CZTabBarButton alloc] init];
//
//    // 设置按钮普通的图片
//    [tabbarBtn setImage:image forState:UIControlStateNormal];
//    // 设置按钮选中的图片
//    [tabbarBtn setImage:imageSelected forState:UIControlStateSelected];
//
//    // 注册一个点击事件(touch down)
//    [tabbarBtn addTarget:self action:@selector(tabbarBtnClick:) forControlEvents:UIControlEventTouchDown];
//
//    // 把创建的btn添加到自定义的view当中
//    [self addSubview:tabbarBtn];
//}

@end

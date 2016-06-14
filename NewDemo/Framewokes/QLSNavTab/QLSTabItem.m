//
//  QLSTabBarItem.m
//  QLSNavTab
//
//  Created by Mr.Q on 16/5/12.
//  Copyright © 2016年 QLS. All rights reserved.
//

#import "QLSTabItem.h"

#define kDockItemSelectedBg @"tabbar_slider.png"

// 文字高度比例
#define kTitleRatio 0.3

@implementation QLSTabItem

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        self.imageView.contentMode = UIViewContentModeCenter;

    }
    return self;
}

#pragma mark 覆盖父类在highlighted时的所有操作
-(void)setHighlighted:(BOOL)highlighted{

    [super setHighlighted:highlighted];
}

#pragma mark 调整内部ImageView的frame
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height;
    if (self.titleLabel.text.length) {
        imageH = contentRect.size.height * (1-kTitleRatio);
    }
    return CGRectMake(imageX, imageY, imageW, imageH);

}

#pragma mark 调整内部UILabel的frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect{

    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight - 3;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

@end

//
//  NewsHomeCell.m
//  toolsDemo
//
//  Created by Mr.Q on 16/6/10.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import "NewsHomeCell.h"
#import "QLSNavigationController.h"
#import "QNewsController.h"

@interface NewsHomeCell()

@property (nonatomic, strong) QNewsController *newsController;

@end

@implementation NewsHomeCell


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {

        self.newsController = [[QNewsController alloc]init];

        [self.contentView addSubview:self.newsController.tableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.newsController.fatherVC = self.fatherVC;
    
    self.newsController.view.frame = self.bounds;
}

- (void)setUrlString:(NSString *)urlString {

    self.newsController.urlString = urlString;

}

@end

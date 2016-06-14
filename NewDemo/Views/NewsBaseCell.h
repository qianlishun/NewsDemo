//
//  NewsBaseCell.h
//  toolsDemo
//
//  Created by Mr.Q on 16/6/4.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SDAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"
#import "NewsModel.h"

@interface NewsBaseCell : UITableViewCell<SDCycleScrollViewDelegate>

@property (nonatomic,strong) UIViewController *fatherVC;

@property (nonatomic,strong) UIImageView *imgIcon;

@property (nonatomic,strong) UILabel  *lblTitle;

@property (nonatomic,strong) UILabel *lblSubtitle;

@property (nonatomic,strong) UIImageView *imgOther1;

@property (nonatomic,strong) UIImageView *imgOther2;

@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic,strong) NewsModel *newsModel;

@property (nonatomic,strong) UILabel *lblPtime;

@property (nonatomic,strong) UILabel *lblSource;


+ (NSString *)cellIDforRow:(NewsModel *)newsModel;

@end

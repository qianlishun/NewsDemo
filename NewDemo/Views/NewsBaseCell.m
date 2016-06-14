//
//  NewsBaseCell.m
//  toolsDemo
//
//  Created by Mr.Q on 16/6/4.
//  Copyright © 2016年 钱立顺. All rights reserved.
//
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#import "NewsBaseCell.h"

@implementation NewsBaseCell

+ (NSString *)cellIDforRow:(NewsModel *)newsModel{
    if (newsModel.hasHead && newsModel.ads.count) {
        return @"NewsFourCell";
    }else if (newsModel.imgType || newsModel.hasIcon){
        return @"NewsThreeCell";
    }else if (newsModel.imgextra){
        return @"NewsTwoCell";
    }else{
        return @"NewsOneCell";
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {

        self.imgIcon = [UIImageView new];
        [self.contentView addSubview:self.imgIcon];

        self.lblTitle = [UILabel new];
        self.lblTitle.font = [UIFont systemFontOfSize:15];
        self.lblTitle.numberOfLines = 2;

        [self.contentView addSubview:self.lblTitle];

        self.lblSubtitle = [UILabel new];
        self.lblSubtitle.textColor = [UIColor grayColor];
        self.lblSubtitle.font = [UIFont systemFontOfSize:13];
        self.lblSubtitle.numberOfLines = 0;
        [self.contentView addSubview:self.lblSubtitle];

        self.lblSource = [UILabel new];
        [self.contentView addSubview:self.lblSource];

        self.lblPtime = [UILabel new];
        [self.contentView addSubview:self.lblPtime];

        self.lineView = [UIView new];
        self.lineView.backgroundColor = rgba(238, 238, 238, 1.0);
        [self.contentView addSubview:self.lineView];

        self.imgOther1 = [UIImageView new];
        [self.contentView addSubview:self.imgOther1];

        self.imgOther2 = [UIImageView new];
        [self.contentView addSubview:self.imgOther2];

    }
    return self;
}

@end

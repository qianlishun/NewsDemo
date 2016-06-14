//
//  NewsTwoCell.m
//  toolsDemo
//
//  Created by Mr.Q on 16/6/4.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import "NewsTwoCell.h"

@implementation NewsTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        [self setView];
    }
    return self;
}


- (void)setView{
    CGFloat margin = 10;

    UIView *contenView = self.contentView;

    NSArray *equalSubViews = [NSArray arrayWithObjects:self.imgIcon,self.imgOther1,self.imgOther2,nil];
    self.contentView.sd_equalWidthSubviews = equalSubViews;

    self.lblTitle.sd_layout
    .topSpaceToView(contenView,margin)
    .leftSpaceToView(contenView,margin)
    .rightSpaceToView(contenView,margin)
    .heightIs(21);

    self.imgIcon.sd_layout
    .topSpaceToView(self.lblTitle,margin)
    .leftSpaceToView(contenView,margin)
    .autoHeightRatio(0.75);

    self.imgOther1.sd_layout
    .topSpaceToView(self.lblTitle,margin)
    .leftSpaceToView(self.imgIcon,margin)
    .autoHeightRatio(0.75);

    self.imgOther2.sd_layout
    .topSpaceToView(self.lblTitle,margin)
    .leftSpaceToView(self.imgOther1,margin)
    .rightSpaceToView(contenView,margin)
    .autoHeightRatio(0.75);

    self.lineView.sd_layout
    .topSpaceToView(self.imgOther2,margin)
    .leftSpaceToView(contenView,margin)
    .rightSpaceToView(contenView,margin)
    .heightIs(1);

    [self setupAutoHeightWithBottomView:self.lineView bottomMargin:0];
}


- (void)setNewsModel:(NewsModel *)newsModel{

    self.lblTitle.text = @"";

    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"303"]];

    self.lblTitle.text = newsModel.title;

    Imgextra *imgextra1 = newsModel.imgextra[0];
    Imgextra *imgextra2 = newsModel.imgextra[1];
    [self.imgOther1 sd_setImageWithURL:[NSURL URLWithString:imgextra1.imgsrc]placeholderImage:[UIImage imageNamed:@"0"]];
    [self.imgOther2 sd_setImageWithURL:[NSURL URLWithString:imgextra2.imgsrc]placeholderImage:[UIImage imageNamed:@"0"]];

    NSString *skipID = [newsModel.skipID componentsSeparatedByString:@"|"].lastObject;

    NSString *URL = [NSString stringWithFormat:@"http://3g.163.com/touch/photoview.html?channel=all&offset=1&setid=%@&channelid=0001",skipID];

    newsModel.url = URL;
}


@end

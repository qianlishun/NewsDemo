//
//  NewsThreeCell.m
//  toolsDemo
//
//  Created by Mr.Q on 16/6/4.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import "NewsThreeCell.h"

@implementation NewsThreeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        [self setView];
    }
    return self;
}


- (void)setView{

    CGFloat margin = 10;

    self.lblTitle.sd_layout
    .topSpaceToView(self.contentView,margin)
    .leftSpaceToView(self.contentView,margin/2)
    .rightSpaceToView(self.contentView,0)
    .heightIs(21);

    self.imgIcon.sd_layout
    .topSpaceToView(self.lblTitle,margin)
    .leftSpaceToView(self.contentView,margin)
    .rightSpaceToView(self.contentView,margin)
    .heightIs(130);

    self.lblSubtitle.sd_layout
    .topSpaceToView(self.imgIcon,margin)
    .rightSpaceToView(self.contentView,margin)
    .leftSpaceToView(self.contentView,margin)
//    .heightIs(40);
    .autoHeightRatio(0);

    self.lineView.sd_layout
    .topSpaceToView(self.lblSubtitle,margin)
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(1);

    [self setupAutoHeightWithBottomView:self.lineView bottomMargin:0];

}


- (void)setNewsModel:(NewsModel *)newsModel{

    self.lblSubtitle.text = @"";
    self.lblTitle.text = @"";

    self.lblTitle.text = newsModel.title;

    if (newsModel.digest.length) {
        self.lblSubtitle.text = [NSString stringWithFormat:@"%@...",newsModel.digest];
    }

    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"0"]];
    NSLog(@"%@",newsModel.imgsrc);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    // 强制计算 label 的自动布局约束
    [self.lblTitle layoutIfNeeded];

    CGFloat titleLength = [self.newsModel.title sizeWithAttributes:@{NSFontAttributeName:self.lblTitle.font}].width;
//    NSLog(@"titleLength : %f -- %@",titleLength,self.newsModel.title);
//    NSLog(@"label width : %f ",self.lblTitle.frame.size.width);

    if (titleLength > self.lblTitle.frame.size.width) {
        self.lblSubtitle.hidden = YES;
    }else{
        self.lblSubtitle.hidden = NO;
    }
}


@end

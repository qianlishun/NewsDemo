//
//  NewsOneCell.m
//  toolsDemo
//
//  Created by Mr.Q on 16/6/4.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import "NewsOneCell.h"

@implementation NewsOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setView];
    }
    return self;
}

- (void)setView{

    CGFloat margin = 10;

    self.imgIcon.sd_layout
    .topSpaceToView(self.contentView,margin)
    .leftSpaceToView(self.contentView,margin)
    .widthIs(90)
    .heightIs(60);

    self.lblTitle.sd_layout
    .topSpaceToView(self.contentView,margin)
    .leftSpaceToView(self.imgIcon,margin)
    .rightSpaceToView(self.contentView,margin);

    self.lblSubtitle.sd_layout
    .topSpaceToView(self.lblTitle,margin/10)
    .leftSpaceToView(self.imgIcon,margin)
    .rightSpaceToView(self.contentView,margin);
//    .autoHeightRatio(0);
//    .heightIs(40);

    self.lineView.sd_layout
    .topSpaceToView(self.imgIcon,margin)
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(1);

    self.lblPtime.sd_layout
    .bottomSpaceToView(self.lineView,0)
    .rightSpaceToView(self.contentView,margin)
    .widthIs(50);

    [self setupAutoHeightWithBottomView:self.lineView bottomMargin:0];
}

- (void)setNewsModel:(NewsModel *)newsModel{

    self.lblSubtitle.text = @"";
    self.lblTitle.text = @"";
    self.lblPtime.text = @"";
    self.lblSource.text = @"";

    self.lblTitle.text = newsModel.title;
    self.lblSubtitle.text = [NSString stringWithFormat:@"%@",newsModel.digest];
    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"0"]];

//    self.lblSource.text = newsModel.source;
    //    self.addtimeView.text = [NSString stringWithFormat:@"111%zd",news.addtime];
//    self.lblPtime.text = newsModel.ptime;

    CGFloat titleLength = [newsModel.title sizeWithAttributes:@{NSFontAttributeName:self.lblTitle.font}].width;

//    NSLog(@"titleLength : %f -- %@",titleLength,newsModel.title);
//    NSLog(@"label width : %f ",self.lblTitle.frame.size.width);

    if (titleLength > self.lblTitle.frame.size.width) {
        self.lblTitle.height = 40;
        self.lblSubtitle.height = 20;
    }else{
        self.lblTitle.height = 20;
        self.lblSubtitle.height = 40;
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.lblTitle layoutIfNeeded];

}

@end

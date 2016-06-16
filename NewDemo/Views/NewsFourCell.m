//
//  NewsFourCell.m
//  toolsDemo
//
//  Created by Mr.Q on 16/6/4.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import "NewsFourCell.h"
#import "NewsWebController.h"
#import "QNewsController.h"

@interface NewsFourCell ()

@property (nonatomic,strong) NSArray *listURL;

//@property (nonatomic,assign) NSInteger index;

@end

@implementation NewsFourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        [self setView];
    }
    return self;
}

- (void)setView{

    self.cycleScrollView = [[SDCycleScrollView alloc]init];
    [self.contentView addSubview:self.cycleScrollView];

    CGFloat margin = 0;

    self.cycleScrollView.sd_layout
    .topSpaceToView(self.contentView,margin)
    .leftSpaceToView(self.contentView,margin)
    .rightSpaceToView(self.contentView,margin)
    .heightIs(170);

    [self setupAutoHeightWithBottomView:self.cycleScrollView bottomMargin:0];

}

- (void)setNewsModel:(NewsModel *)newsModel{

    NSMutableArray *imageURLStrings = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array  ];
    NSMutableArray *listURL = [NSMutableArray array];
    [newsModel.ads enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Ads *ads = (Ads*)obj;
        [imageURLStrings addObject:ads.imgsrc];
        [titles addObject:ads.title];
        [listURL addObject:ads.url];
    }];

    if(imageURLStrings.count == 1){
        self.cycleScrollView.autoScroll = NO;
    }

    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;

    self.cycleScrollView.delegate = self;

    self.listURL = listURL;
//    NSLog(@"%@",self.listURL);
    self.cycleScrollView.titlesGroup = titles;
    self.cycleScrollView.imageURLStringsGroup = imageURLStrings;

    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    self.cycleScrollView.placeholderImage = [UIImage imageNamed:@"0"];

}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{


    // http://3g.163.com/touch/photoview.html?channel=all&offset=0&setid=2186433&channelid=0001

    //http://3g.163.com/touch/photoview.html?channel=all&offset=0&setid=2186452&channelid=0001

    //http://3g.163.com/touch/photoview.html?channel=all&offset=1&setid=2186450&channelid=0001


//    NSLog(@"list url %@",self.listURL[index]);

    NSString *setid =  [self.listURL[index] componentsSeparatedByString:@"|"].lastObject;

//    NSLog(@"list url %@",setid);

    NSString *cycleURL = [NSString stringWithFormat:@"http://3g.163.com/touch/photoview.html?channel=all&offset=1&setid=%@&channelid=0001",setid];

//    NSLog(@"cycle %@",cycleURL);

    NewsWebController *vc = [[NewsWebController alloc]init];

    vc.url= cycleURL;

    vc.title= self.cycleScrollView.titlesGroup[index];

    [self.fatherVC.navigationController pushViewController:vc animated:YES];
}


@end

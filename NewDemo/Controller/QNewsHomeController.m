//
//  QNewsHomeController.m
//  toolsDemo
//
//  Created by Mr.Q on 16/6/10.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import "QNewsHomeController.h"
#import "Channel.h"
#import "ChannelLabel.h"
#import "NewsHomeCell.h"
#import "UIView+QLSFrame.h"
//#import "QNetWorkTools.h"

@interface QNewsHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *channels;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UICollectionViewFlowLayout *collectionLayout;

@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation QNewsHomeController


- (NSArray *)channels{

    if (!_channels) {
        _channels = [Channel channels];
    }
    return _channels;
}


static NSString *const ID = @"home_cell";

- (void)viewDidLoad{

    [super viewDidLoad];

    self.title = @"新闻";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionLayout = layout;

      // 2.初始化collctionView
    UICollectionView *collectionView =  [[UICollectionView alloc]initWithFrame:CGRectMake(0, 44, kWIDTH, kSize.height - 44) collectionViewLayout:layout];

    collectionView.backgroundColor = [UIColor whiteColor];
    // 注册
    [collectionView registerClass:[NewsHomeCell class] forCellWithReuseIdentifier:ID];

    self.collectionView = collectionView;

    [self.view addSubview:self.collectionView];


    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 44)];
    self.scrollView.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.scrollView];

    [self loadChannels];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
  // 保证首次加载屏幕正确
    // iOS8 之后的方法
    [self viewWillTransitionToSize:[UIScreen mainScreen].bounds.size withTransitionCoordinator:self.transitionCoordinator];
    // iOS8 之后的方法
//    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:0]
}

- (void)loadChannels{

    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat marginX = 5;
    CGFloat x = marginX;
    CGFloat h = self.scrollView.bounds.size.height;
    int i = 0;
    for (Channel *channel in self.channels) {
        ChannelLabel *lbl = [ChannelLabel channelLabelWithTName:channel.tname];
        [self.scrollView addSubview:lbl];

        lbl.frame = CGRectMake(x, 0, lbl.frame.size.width, h);

        [lbl addTarget:self action:@selector(didChannelClick:) forControlEvents:UIControlEventTouchUpInside];

        x += lbl.frame.size.width + marginX;

        lbl.tag = i;
        i++;
    }
    
    self.scrollView.contentSize = CGSizeMake(x, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;

    ChannelLabel *firstLabel = self.scrollView.subviews[0];
    firstLabel.scale = 1;
}

- (void)didChannelClick:(UIButton *)sender{
    CGFloat cw = self.view.bounds.size.width;

    [self.collectionView setContentOffset:CGPointMake(cw * sender.tag , 0)animated:NO];

    self.currentIndex = sender.tag;

    for (id btn in self.scrollView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            UIButton *btn1 = (UIButton *)btn;
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn1.titleLabel.font = [UIFont systemFontOfSize:14];
            btn1.transform = CGAffineTransformMakeScale(1, 1);
        }
    }
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sender.transform = CGAffineTransformMakeScale(1.285, 1.285);
}

#pragma mark dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

    Channel *channel = self.channels[indexPath.item];
    cell.urlString = channel.urlString;

    cell.fatherVC = self;

    return cell;
}

#pragma mark    collectionView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    ChannelLabel *curentLabel = self.scrollView.subviews[self.currentIndex];
    ChannelLabel *nextLabel = nil;

    for (NSIndexPath *indexPath in self.collectionView.indexPathsForVisibleItems) {
        if (indexPath.item != self.currentIndex) {
            nextLabel = self.scrollView.subviews[indexPath.item];
        }
    }
    if (nextLabel == nil) {
        return;
    }
    // 获取滚动比例
    CGFloat nextScale = ABS(scrollView.contentOffset.x / scrollView.bounds.size.width - self.currentIndex);
    CGFloat  currentScale = 1 - nextScale;

    for (id obj in self.scrollView.subviews) {
        if ([[obj class] isSubclassOfClass:[UIButton class]]) {
            ChannelLabel *lbl = (ChannelLabel *)obj;
            lbl.scale = 0;
        }
    }
    
    nextLabel.scale = nextScale;
    curentLabel.scale = currentScale;

    self.currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    self.currentIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;

    ChannelLabel *label = self.scrollView.subviews[self.currentIndex];
    CGFloat offset = label.center.x - self.scrollView.bounds.size.width * 0.5;
    CGFloat maxOffset = self.scrollView.contentSize.width - label.bounds.size.width - self.scrollView.bounds.size.width;

    if (offset < 0) {
        offset = 0;
    }else if(offset > maxOffset){
        offset = maxOffset + label.bounds.size.width;
    }

    [self.scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];

}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

    self.collectionLayout.itemSize = self.collectionView.bounds.size;

}

// 旋转适配
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
        self.collectionView.width = size.width;
        self.scrollView.width = size.width;
}

@end

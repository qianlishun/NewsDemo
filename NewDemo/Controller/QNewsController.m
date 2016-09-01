//
//  QNewsController.m
//  toolsDemo
//
//  Created by Mr.Q on 16/6/4.
//  Copyright © 2016年 QLS. All rights reserved.
//
#import "QNewsController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "NewsModel.h"
#import "NewsBaseCell.h"
#import "NewsOneCell.h"
#import "NewsTwoCell.h"
#import "NewsThreeCell.h"
#import "NewsFourCell.h"
#import "NewsWebController.h"
#import "QNetWorkTools.h"
#import "UIView+QLSFrame.h"

@interface QNewsController () <SDCycleScrollViewDelegate>

@property (nonatomic,assign) NSInteger pageIndex;

@property (nonatomic,strong) MJRefreshComponent *refreshView;

@property (nonatomic,strong) SDCycleScrollView *cycleScorllView;

@property (nonatomic,copy) NSString  *url;

@property (nonatomic,strong) UIButton *btn;

@property (nonatomic,strong) NSMutableDictionary *cacheDict;

@property (nonatomic,strong) NSMutableArray *listArray;

@end

@implementation QNewsController


- (UIButton *)btn{

//这里判断网络连接还是有些问题,暂时这样.
    if (!_btn) {

        UIButton *btn = [[UIButton alloc]init];

        [btn setTitle:@"加载失败,请刷新或检查网络连接 ☞" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn addTarget:self action:@selector(checkNetwork) forControlEvents:UIControlEventTouchUpInside];

        _btn = btn;
    }
    return _btn;
}

- (void)viewDidLoad{

    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets = YES;

    self.tableView.separatorColor = [UIColor clearColor];

    __weak typeof (self)weakSelf = self;

    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.refreshView = weakSelf.tableView.header;
        weakSelf.pageIndex = 0;

        [weakSelf loadDataFromServer];
    }];

    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.refreshView = weakSelf.tableView.footer;

        [weakSelf loadMoreData];
    }];
    
    self.navigationController.hidesBarsOnSwipe = YES;

    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (NSMutableDictionary *)cacheDict{

    if (!_cacheDict) {
        _cacheDict = [NSMutableDictionary dictionaryWithCapacity:20];

    }
    return _cacheDict;
}

- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _listArray;
}

#pragma mark - 请求数据

- (void)setUrlString:(NSString *)urlString{

    QNetWorkTools *tools = [QNetWorkTools sharedNetworkTools];
    for (NSURLSessionDataTask *task in tools.dataTasks) {
        [task cancel];
    }

    self.url = urlString;

    self.listArray = self.cacheDict[self.url];

    [self.tableView reloadData];
    
    self.tableView.footer.hidden = self.listArray.count==0?YES:NO;

    if (self.listArray.count) {
        return;
    }

    self.pageIndex = 0;

    [self.tableView.header beginRefreshing];

    [self loadDataFromServer];
}

- (void)loadMoreData{

    self.pageIndex+=10;

    [self loadDataFromServer];
}

- (void)loadDataFromServer{

//    NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/%ld-20.html",@"headline/T1348647853363",self.pageIndex];
//    NSString *urlString = [NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/%ld-20.html",@"list/T1414389941036",self.pageIndex];

//    NSString *urlString = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/B6UKRIOE00963VRO/full.html"];

//    NSMutableArray *listArray = [NSMutableArray arrayWithArray:self.listArray];

    [NewsModel newsWithURLString:[NSString stringWithFormat:@"%@/%zd-10.html",self.url,self.pageIndex]  success:^(NSArray *array) {

        if (self.pageIndex == 0) {

            [self.listArray removeAllObjects];

            [self.listArray addObjectsFromArray:array];

            // 网易新闻更新后,抓包抓到的数据变了 此代码不需要再加了...
            // // 拿出头条中的非轮播数据
//             NewsModel *model =  array[0];
//             NewsModel *tempModel = [NewsModel new];
//             tempModel.title = model.title;
//             tempModel.imgsrc = model.imgsrc;
//             tempModel.digest = model.digest;
//             tempModel.imgsrc = model.imgsrc;
//             tempModel.imgextra = model.imgextra;
//             tempModel.skipID = model.skipID;
//            
//             [listArray insertObject:tempModel atIndex:1];

        }else{

            for (id obj in array) {
                [self.listArray addObject:obj];
            }
             // 去除头条重复数据
             NewsModel *model = array[0];
             model.ads = nil;
        }

        
        [self.cacheDict setObject:self.listArray forKey:self.url];

        self.tableView.footer.hidden = self.listArray.count==0?YES:NO;

        self.btn.hidden = YES;

         if (self.listArray.count - self.pageIndex == 10) {
            [self doneWithView:self.refreshView];

         }else{
             [self performSelector:@selector(checkData) withObject:nil afterDelay:10.0];
         }

    } errorBlock:^(NSError *error) {
        NSLog(@"请求失败,%@",error);
         [self.refreshView endRefreshing];
         [self performSelector:@selector(checkData) withObject:nil afterDelay:15.0];
    }];

}

//#pragma mark - 回调刷新
- (void)doneWithView:(MJRefreshComponent *)refreshView{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });

    [self.refreshView endRefreshing];

}

- (void)checkData{

    if (self.listArray.count - self.pageIndex != 10) {
        [self timeOut];
    }
}

- (void)timeOut{

    [self.refreshView endRefreshing];

    [self.tableView addSubview:_btn];
    _btn.frame = self.refreshView.bounds;

    _btn.hidden = NO;

}

- (void)checkNetwork{
//prefs:root=General&path=Network

    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];

}


#pragma mark - tableview delegate  &&  datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return  self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NewsModel *newsModel = self.listArray[indexPath.row];

    NSString *ID = [NewsBaseCell cellIDforRow:newsModel];

    Class class = NSClassFromString(ID);

    NewsBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[class alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    if ([ID isEqualToString:@"NewsFourCell"]) {
        cell.fatherVC = self.fatherVC;
    }

    cell.newsModel = newsModel;

    // 缓存 cell 的 frame
    cell.sd_tableView = tableView;
    cell.sd_indexPath = indexPath;

   // 静默加载新数据
//    if(indexPath.row == self.listArray.count-3 && !self.tableView.footer.isRefreshing){
//        [self loadMoreData];
//    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *newsModel = self.listArray[indexPath.row];

    NSString *ID = [NewsBaseCell cellIDforRow:newsModel];

    Class class = NSClassFromString(ID);

    return [self.tableView cellHeightForIndexPath:indexPath model:newsModel keyPath:@"newsModel" cellClass:class contentViewWidth:[self cellContentViewWidth]];
}

- (CGFloat)cellContentViewWidth{

    CGFloat width = kSize.width;

    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = kSize.height;
    }
    return width;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NewsModel *model = self.listArray[indexPath.row];
    // 创建一个用于跳转的控制器
    NewsWebController *vc = [[NewsWebController alloc]init];

    // 把数据传递给这个控制器
    vc.url= model.url;

    vc.title= model.title;

//    [nav presentViewController:vc animated:YES completion:nil];
    [self.fatherVC.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

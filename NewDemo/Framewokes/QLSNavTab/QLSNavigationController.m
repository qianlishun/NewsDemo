//
//  QLSNavigationController.m
//  QLSNavTab
//
//  Created by Mr.Q on 16/5/12.
//  Copyright © 2016年 QLS. All rights reserved.
//

#import "QLSNavigationController.h"

@interface QLSNavigationController ()<UINavigationControllerDelegate>

@end

@implementation QLSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationBar setTintColor:[UIColor whiteColor]];

    self.navigationBar.shadowImage = [[UIImage alloc]init];

    [self.navigationBar  setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    //self - 导航控制器
    if(self.viewControllers.count){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.topViewController.navigationItem.backBarButtonItem = backItem;

    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};

    // 调用系统默认做法
    [super pushViewController:viewController animated:animated];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  NewsHomeCell.h
//  toolsDemo
//
//  Created by Mr.Q on 16/6/10.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsHomeCell : UICollectionViewCell

@property (nonatomic,copy) NSString  *urlString;

@property (nonatomic,strong) UIViewController *fatherVC;

@end

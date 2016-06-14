//
//  NewsModel.h
//  toolsDemo
//
//  Created by Mr.Q on 16/6/4.
//  Copyright © 2016年 钱立顺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ads.h"
#import "Imgextra.h"
#import "Editor.h"
@interface NewsModel : NSObject
@property (nonatomic,copy) NSString  *tname;

@property (nonatomic,copy) NSString  *title;

@property (nonatomic,copy) NSString  *ptime;

@property (nonatomic,copy) NSString  *docid;

@property (nonatomic,copy) NSString  *imgsrc;

@property (nonatomic,copy) NSNumber *imgType;

@property (nonatomic,copy) NSString  *digest;

@property (nonatomic,copy) NSNumber  *replyCount;

/**
 *  多图数组
 *  里面放的是Imgextra模型
 */
@property (nonatomic,strong)NSArray *imgextra;

/**
 *  里面放的是Ads模型
 */
@property (nonatomic,strong)NSArray *ads;

@property (nonatomic,copy) NSString  *lmodify;
@property (nonatomic,copy) NSString  *photosetID;
@property (nonatomic,copy) NSString  *template;
@property (nonatomic,copy) NSNumber  *votecount;

@property (nonatomic,copy) NSNumber  *hasHead;
@property (nonatomic,copy) NSNumber  *hasImg;

@property (nonatomic,copy) NSString  *skipType;
@property (nonatomic,copy) NSString  *skipID;

@property (nonatomic,copy) NSString  *alias;


@property (nonatomic,assign) BOOL  hasCover;
@property (nonatomic,copy) NSNumber  *hasAD;
@property (nonatomic,copy) NSNumber  *priority;
@property (nonatomic,copy) NSString  *cid;


@property (nonatomic,assign) BOOL  hasIcon;

@property (nonatomic,copy) NSString  *ename;
@property (nonatomic,copy) NSString  *order;

@property (nonatomic,copy) NSString  *url_3w;
@property (nonatomic,copy) NSString  *specialID;
@property (nonatomic,copy) NSString  *source;
@property (nonatomic,copy) NSString  *subtitle;
@property (nonatomic,copy) NSString  *url;
@property (nonatomic,copy) NSString  *TAG;
@property (nonatomic,copy) NSString  *TAGS;
@property (nonatomic,copy) NSString  *boardid;
@property (nonatomic,copy) NSString *commentid;
@property (nonatomic,copy) NSString *wap_portal;

+ (void)newsWithURLString:(NSString *)urlString success:(void(^)(NSArray *array))success errorBlock:(void(^)(NSError *error))errorBlock;

@end

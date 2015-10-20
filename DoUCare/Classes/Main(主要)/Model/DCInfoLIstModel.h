//
//  DCInfoLIstModel.h
//  DoUCare
//
//  Created by soft on 15/10/20.
//  Copyright © 2015年 DemonChou. All rights reserved.
//

#import "BaseModel.h"

@interface DCInfoLIstModel : BaseModel
/*
 id	long	ID编码
 keywords	string	关键词
 title	string	标题
 description	string	简介
 img	string	图片
 infoclass	int	分类ID
 count	int	访问数
 rcount	int	评论数
 fcount	int	收藏数
 time	long	发布时间
 */
@property (assign, nonatomic) long identity;
@property (strong, nonatomic) NSString *keywords;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *img;
@property (assign, nonatomic) int infoclass;
@property (assign, nonatomic) int count;
@property (assign, nonatomic) int rcount;
@property (assign, nonatomic) int fcount;
@property (assign, nonatomic) long time;



@end

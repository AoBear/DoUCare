//
//  BaseModel.h
//  Day08_2_JsonToArr
//
//  Created by jiyingxin on 15/10/19.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseModelDelegate <NSObject>

+(id)parse:(id)responseObj;
@end

@interface BaseModel : NSObject<BaseModelDelegate>
/*
子类重写此方法，解决服务器传递键命名不规范问题
- (NSDictionary *)specialKeys{
    return @{@"id":@"identify"};
 }
表示服务器传键id， 本地取名identify
 */
- (NSDictionary *)specialKeys;
/*
 如果某个键所对应的值需要特殊解析类来负责
 子类重写
 - (NSDictionary *)specialMethods{
    return @{@"data":@"GameListDataModel"};
 }
 表示 键data 要使用 GameListDataModel 类解析
 */
- (NSDictionary *)specialMethods;


@end















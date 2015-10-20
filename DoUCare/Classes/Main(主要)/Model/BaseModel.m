//
//  BaseModel.m
//  Day08_2_JsonToArr
//
//  Created by jiyingxin on 15/10/19.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
+(id)parse:(id)responseObj{
    id obj=responseObj;
    if ([responseObj isKindOfClass:[NSDictionary class]]) {
        obj = [self parseDic:responseObj];
        return obj;
    }
    if ([responseObj isKindOfClass:[NSArray class]]) {
        obj = [self parseArr:responseObj];
        return obj;
    }
//如果使用的人不会Json序列化
    if ([responseObj isKindOfClass:[NSData class]]) {
        NSError *error = nil;
        id data=[NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:&error];
//正常情况下，解析出来的一定是字典或数组或字符串类型
        BOOL success=[data isKindOfClass:[NSArray class]]||[data isKindOfClass:[NSString class]]||[data isKindOfClass:[NSDictionary class]];
//如果序列化出问题了 或者 序列化的结果类型不正确
//__FUNCTION__会打印出当前是哪个类的哪个方法
        NSAssert1(!error||success, @"JSON数据有问题 %s", __FUNCTION__);
        return [self parse:data];
    }
    return obj;
}
- (NSDictionary *)specialKeys{
    return nil;
}
- (NSDictionary *)specialMethods{
    return nil;
}
+ (id)parseDic:(id)responseObj{
    id model = [self new];
    NSDictionary *dic = [model specialKeys];
    NSDictionary *methodDic=[model specialMethods];
//    [obj setValuesForKeysWithDictionary:responseObj];
    [responseObj enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//如果遍历出的key在特殊字典中有写，那么
        if ([dic objectForKey:key]) {
            key = dic[key];
        }
//如果某个key对应了某个特殊解析类
        if ([methodDic objectForKey:key]) {
            Class class=NSClassFromString(methodDic[key]);
            obj = [class parse:obj];
        }
        [model setValue:obj forKey:key];
    }];
    return model;
}
+ (NSArray *)parseArr:(NSArray *)responseObj{
    NSMutableArray *arr=[NSMutableArray new];
    [responseObj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id obj1 = [self parseDic:obj];
        [arr addObject:obj1];
    }];
    return [arr copy];
}















@end

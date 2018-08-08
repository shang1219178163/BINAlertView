//
//  NSDictionary+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/24.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NSDictionary+Helper.h"

@implementation NSDictionary (Helper)

//字典转json格式字符串：
//- (NSString *)JSONValue{
//    
//    NSString * jsonString = nil;
//    if ([NSJSONSerialization isValidJSONObject:self]) {
//        
//        NSError *parseError = nil;
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&parseError];
//        if (parseError != nil) {
//#ifdef DEBUG
//            NSLog(@"fail to get NSData from Dict: %@, error: %@", self, parseError);
//#endif
//        }
//        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//    } else {
//        NSLog(@"JSON数据生成失败，请检查数据格式!");
//        
//    }
//    return jsonString;
//}


/**
根据key对字典values排序,区分大小写(按照ASCII排序)
 */
- (NSArray *)sortedValuesByKey{
    
    //将所有的key放进数组
    NSArray *allKeyArray = self.allKeys;
    
//    NSArray *sortKeyList = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        //序列化器对数组进行排序的block 返回值为排序后的数组
//
//        /**
//         - (NSComparisonResult)compare:(NSString *)string;
//         compare方法的比较原理为,依次比较当前字符串的第一个字母,如果不同,按照输出排序结果;如果相同,依次比较当前字符串的下一个字母(这里是第二个),以此类推
//
//         排序结果
//         NSComparisonResult resuest = [obj1 compare:obj2];为从小到大,即升序;
//         NSComparisonResult resuest = [obj2 compare:obj1];为从大到小,即降序;
//
//         注意:compare方法是区分大小写的,即按照ASCII排序
//         */
//        //排序操作
//        NSComparisonResult resuest = [obj1 compare:obj2];
//        return resuest;
//    }];
    
    NSArray *sortKeyList = [allKeyArray sortedArrayUsingSelector:@selector(compare:)];
//    NSLog(@"sortKeyList:%@",sortKeyList);

    //通过排列的key值获取value
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *key in sortKeyList) {
        NSString *valueString = self[key];
        [valueArray addObject:valueString];
    }
//    NSLog(@"valueArray:%@",valueArray);
    return valueArray.copy;
}


- (NSMutableDictionary *)BN_filterDictByContainQuery:(NSString *)query isNumValue:(BOOL)isNumValue{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [self.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj containsString:query]) {
            id value = self[query];
            value = isNumValue == NO ? value : [value numberValue];
            [dic setObject:value forKey:obj];
            
        }
    }];
    return dic;
}


@end

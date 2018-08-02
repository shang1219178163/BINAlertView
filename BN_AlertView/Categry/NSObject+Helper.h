//
//  NSObject+Helper.h
//  WeiHouBao
//
//  Created by hsf on 2017/8/10.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BlockObject)(id obj, id item, NSInteger idx);

@interface NSObject (Helper)

void dispatchAsyncMain(void(^block)());
void dispatchAsyncGlobal(void(^block)());
//void dispatchAfterDelay(void(^block)());
void dispatchAfterDelay(double delay ,void(^block)());

/**
 代码块返回单个参数的时候,不适用于id不能代表的类型()
*/
@property (nonatomic, copy) BlockObject blockObject;//其他类使用该属性注意性能

@property (nonatomic, strong, readonly) UIWindow * globleWindow;
@property (nonatomic, strong, readonly) UIViewController * rootVC;
@property (nonatomic, strong, readonly) NSUserDefaults * userDefaults;

- (NSArray *)allPropertyNames:(NSString *)clsName;

- (NSDictionary *)allPropertyDict;

/**
 待测试
 */
-(BOOL)validObject;

/**
 富文本特殊部分设置
 */
- (NSDictionary *)attrDictWithFont:(id)font textColor:(UIColor *)textColor;

/**
 富文本整体设置
 */
- (NSDictionary *)attrParaDictWithFont:(id)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment;

/**
 (通用)富文本只有和一般文字同字体大小才能计算高度
 */
- (CGSize)sizeWithText:(id)text font:(id)font width:(CGFloat)width;

/**
 (详细)富文本产生
 
 @param text 源字符串
 @param textTaps 特殊部分数组(每一部分都必须包含在text中)
 @param font 一般字体大小(传NSNumber或者UIFont)
 @param tapFontSize 特殊部分子体大小(传NSNumber或者UIFont)
 @param tapColor 特殊部分颜色
 @return 富文本字符串
 */
- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont tapColor:(UIColor *)tapColor alignment:(NSTextAlignment)alignment;

- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont color:(UIColor *)color tapColor:(UIColor *)tapColor alignment:(NSTextAlignment)alignment;

- (NSArray *)getAttListByPrefix:(NSString *)prefix titleList:(NSArray *)titleList mustList:(NSArray *)mustList;

- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content isMust:(BOOL)isMust;

@end

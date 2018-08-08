//
//  NSObject+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/10.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

UIKIT_EXTERN NSString * NSStringFromIndexPath(NSIndexPath *indexPath);
UIKIT_EXTERN NSString * NSStringFromLet(id obj);

UIKIT_EXTERN UIColor * kC_RGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat a);
UIKIT_EXTERN UIColor * kC_RGB(CGFloat r,CGFloat g,CGFloat b);
UIKIT_EXTERN UIColor * kC_DIM(CGFloat White,CGFloat a);

UIKIT_EXTERN UIColor * kC_RGB_Init(CGFloat r,CGFloat g,CGFloat b,CGFloat a);
UIKIT_EXTERN UIColor * kC_HEX(NSInteger hexValue);

UIKIT_EXTERN BOOL iOS(CGFloat version);

UIKIT_EXTERN CGFloat roundFloat(CGFloat value,NSInteger num);


typedef void(^BlockObject)(id obj, id item, NSInteger idx);

@interface NSObject (Helper)

void BN_dispatchAsyncMain(void(^block)());
void BN_dispatchAsyncGlobal(void(^block)());
//void dispatchAfterDelay(void(^block)());
void BN_dispatchAfterDelay(double delay ,void(^block)());

void BN_dispatchApply(id obj ,void(^block)(dispatch_queue_t queue, size_t index));

/**
 代码块返回单个参数的时候,不适用于id不能代表的类型()
*/
@property (nonatomic, copy) BlockObject blockObject;//其他类使用该属性注意性能

@property (nonatomic, strong, readonly) UIWindow * keyWindow;
@property (nonatomic, strong, readonly) UIViewController * rootVC;
@property (nonatomic, strong, readonly) NSUserDefaults * userDefaults;


- (NSArray *)allPropertyNames:(NSString *)clsName;

/**
 模型转字典
 
 */
- (NSDictionary *)modelToDictionary;

/**
 模型转JSON
 
 */
- (NSString *)modelToJSONWithError:(NSError **)error;


-(BOOL)validObject;

-(NSString *)showNilText;

- (NSString *)JSONValue;

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
 (通用)密集view父视图尺寸
 */
- (CGSize)sizeItemsViewWidth:(CGFloat)width items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding;

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

- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(id)textTaps tapColor:(UIColor *)tapColor;

/**
 富文本产生
 */
- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray *)textTaps;


- (NSArray *)getAttListByPrefix:(NSString *)prefix titleList:(NSArray *)titleList mustList:(NSArray *)mustList;

- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content isMust:(BOOL)isMust;

- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content must:(id)must;

- (NSString *)stringFromBool:(NSNumber *)boolNum;

- (BOOL)stringToBool:(NSString *)string;
    
+ (NSString *)jsonToString:(id)data;

+ (NSString *)stringFromInteger:(NSInteger)integer;

+ (NSString *)getMaxLengthStrFromArr:(NSArray *)arr;

- (NSDate *)dateWithString:(NSString *)dateString;
- (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;

- (NSString *)stringWithDate:(NSDate *)date;
- (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;

- (NSString *)compareCurrentTime;
- (NSString *)compareCurrentTimeDays;
- (NSString *)compareTimeInfo;

/**
 弃用
 */
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;

-(BOOL)isKindClassArray:(NSArray *)classArray value:(id)value;

//时间戳相关
//当前时间戳
+ (NSString *)timestampFromNow;
+ (NSString *)currentTimeStamp;

//当前时间
+ (NSString *)timeFromNow;

//时间转化时间戳
+ (NSString *)timestampFromTime:(NSString *)formatTime;

- (NSString *)toTimestampMonth;
- (NSString *)toTimestampShort;
- (NSString *)toTimestampFull;

- (NSString *)toTimestamp;

//时间戳转化时间
+ (NSString *)timeFromTimestamp:(id)timestamp;

- (NSString *)toTimeDate;
- (NSString *)timeByAddingDays:(id)days;

/**  比较两个日期,年月日, 时分秒 各相差多久
 *   先判断年 若year>0   则相差这么多年,后面忽略
 *   再判断月 若month>0  则相差这么多月,后面忽略
 *   再判断日 若day>0    则相差这么多天,后面忽略(0是今天,1是昨天,2是前天)
 *          若day=0    则是今天 返回相差的总时长
 */
+ (NSDateComponents *)compareCalendar:(NSDate *)date;

/**  最近的日期*/
+ (NSString *)relativeDate:(NSDate *)date;

+ (NSString *)timeTipInfoFromTimestamp:(NSInteger)timestamp;

//获取随机数
- (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to;

- (NSString *)getRandomStr:(NSInteger)from to:(NSInteger)to;

- (void)handleCallPhone:(NSString *)phoneNumber;

/**
 timer创建及启动

 */
- (NSTimer *)createTimerAndStartWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target aSelector:(SEL)aSelector repeats:(BOOL)repeats;

/**
 定时器停止及销毁

 */
- (void)stopTimer:(NSTimer *)timer;

/**
 十六进制颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)colorString;

+ (UIColor *)randomColor;

- (void)copyToPasteboard;

- (BOOL)openThisURL;

- (NSInteger)rowCountWithItemList:(NSArray *)itemList rowOfNumber:(NSInteger)rowOfNumber;

//- (float)roundFloat;

@end

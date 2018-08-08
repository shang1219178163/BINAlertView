//
//  NSObject+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/10.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NSObject+Helper.h"
#import <objc/runtime.h>

#import "UIView+Toast.h"
#import "NSDateFormatter+Helper.h"
#import "NSDate+Helper.m"

NSString * NSStringFromIndexPath(NSIndexPath *indexPath) {
  return [NSString stringWithFormat:@"{%@,%@}",@(indexPath.section),@(indexPath.row)];
}

NSString * NSStringFromLet(id obj) {
    return [NSString stringWithFormat:@"%@",obj];
}

UIColor * kC_RGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat a){
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

UIColor * kC_RGB(CGFloat r,CGFloat g,CGFloat b){
    return kC_RGBA(r, g, b, 1);
}

UIColor * kC_DIM(CGFloat White,CGFloat a){
    return [UIColor colorWithWhite:White alpha:a];////white 0-1为黑到白,alpha透明度
    //    return [UIColor colorWithWhite:0.2f alpha: 0.5];////white 0-1为黑到白,alpha透明度
    
}

UIColor * kC_RGB_Init(CGFloat r,CGFloat g,CGFloat b,CGFloat a){
    return [[UIColor alloc]initWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

UIColor * kC_HEX(NSInteger hexValue){
    return [UIColor colorWithRed:(((hexValue & 0xFF0000) >> 16))/255.0 green:(((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0f];
}

BOOL iOS(CGFloat version){
    return ([[[UIDevice currentDevice] systemVersion] floatValue] >= version) ? YES : NO;
    
}

CGFloat roundFloat(CGFloat value,NSInteger num){
    NSInteger tem = pow(10, num);
    CGFloat x = value*tem + 0.5;
    CGFloat figure = (floorf(x))/tem;
    return figure;
}

@implementation NSObject (Helper)

//KVC

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    DDLog(@"不存在键_%@:%@",key,value);
//    if (DEBUG) {
//        UIApplication * app = [UIApplication sharedApplication];
//        [app.delegate.window.rootViewController showAlertWithTitle:@"warnning" msg:[NSString stringWithFormat:@"不存在键__%@:%@",key,value]];
//        
//    }
}

-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
    
}



#pragma mark - -runtime
///通过运行时获取当前对象的所有属性的名称，以数组的形式返回
- (NSArray *)allPropertyNames:(NSString *)clsName{
    ///存储所有的属性名称
    NSMutableArray *allNames = [NSMutableArray arrayWithCapacity:0];
    
    ///存储属性的个数
    unsigned int propertyCount = 0;
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([NSClassFromString(clsName) class], &propertyCount);
    
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    ///释放
    free(propertys);
    return allNames;
}

/**
 模型转字典
 
 */
- (NSDictionary *)modelToDictionary{
    id obj = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);//获得属性列表
    for(NSInteger i = 0;i < propsCount; i++){
        
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];//获得属性的名称
        
        id value = [obj valueForKey:propName];//kvc读值
        
        value = value == nil ? [NSNull null] : [self handleObj:obj];
        [dic setObject:value forKey:propName];
        
    }
    free(props);
    return dic;
}

/**
 模型转JSON
 
 */
- (NSString *)modelToJSONWithError:(NSError **)error{
    id obj = self;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self handleObj:obj] options:NSJSONWritingPrettyPrinted error:error];
    NSString *jsonText = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonText;
}

/**
 自定义处理数组，字典，其他类
 
 */
- (id)handleObj:(id)obj{
    //类型
    if([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSNull class]]){
        return obj;
        
    }
    
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objArr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objArr.count];
        for(NSInteger i = 0;i < objArr.count; i++){
            //            [arr setObject:[self handleObj:objArr[i]] atIndexedSubscript:i];
            [arr addObject:[self handleObj:objArr[i]]];
        }
        return arr;
        
    }
    
    if([obj isKindOfClass:[NSDictionary class]]){
        
        NSDictionary *objDic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objDic count]];
        for(NSString *key in objDic.allKeys){
            [dic setObject:[self handleObj:objDic[key]] forKey:key];
            
        }
        return dic;
        
    }
    return [self modelToDictionary];
}


#pragma mark - -dispatchAsyncMain

void BN_dispatchAsyncMain(void(^block)()){
//    dispatch_async(dispatch_get_main_queue(), block);
    if ([NSThread isMainThread]) {
        block();
    }else{
        dispatch_async(dispatch_get_main_queue(), block);
        
    }
}

void BN_dispatchAsyncGlobal(void(^block)()){
    //    dispatch_async(dispatch_get_global_queue(0, 0), block);
    if (![NSThread isMainThread]) {
        block();
    }else{
        dispatch_async(dispatch_get_global_queue(0, 0), block);
        
    }
}

void BN_dispatchAfterDelay(double delay ,void(^block)()){
    
    double delayInSeconds = delay;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        block();
    });
}

void BN_dispatchApply(id obj ,void(^block)(dispatch_queue_t queue, size_t index)){
    
    NSCAssert([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]] , @"必须是集合");
    
    //1.创建NSArray类对象
    //2.创建一个全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
     //3.通过dispatch_apply函数对NSArray中的全部元素进行处理,并等待处理完成,
    dispatch_apply([obj count], queue, ^(size_t index) {
//        DDLog(@"%zu: %@", index, obj[index]);
        block(queue,index);
    });
    NSLog(@"done");
}

#pragma mark - -validObject

-(BOOL)validObject{
    if (self == nil) return NO;
    if ([self isEqual:[NSNull null]])  return NO;
    if ([self isKindOfClass:[NSNull class]]) return NO;
    
    if ([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSAttributedString class]]){
        NSString *str = @"";
        if ([self isKindOfClass:[NSAttributedString class]]){
            str = [(NSAttributedString *)self string];
            
        }else{
            str = (NSString *)self;
            
        }
        
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSArray * array = @[@"",@"nil",@"null"];
        if ([array containsObject:str]) {
//            DDLog(@"无效字符->(%@)",string);
           return NO;
        }
        
    }
    else if ([self isKindOfClass:[NSArray class]]){
        if ([(NSArray *)self count] == 0){
//            DDLog(@"空数组->(%@)",self);
            return NO;
        }
    }
    else if ([self isKindOfClass:[NSDictionary class]]){
        if ([(NSDictionary *)self count] == 0){
//            DDLog(@"空字典->(%@)",self);
           return NO;
        }
    }
    return YES;
}

-(NSString *)showNilText{
    NSParameterAssert([self isKindOfClass:[NSString class]]);
    return [self validObject] == YES ? (NSString *)self : kNIl_TEXT;
}


//字典转json格式字符串：
- (NSString *)JSONValue{

    NSString * jsonString = nil;
    if ([NSJSONSerialization isValidJSONObject:self]) {
  
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&parseError];
        if (parseError != nil) {
#ifdef DEBUG
            NSLog(@"fail to get NSData from Dict: %@, error: %@", self, parseError);
#endif
        }
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    } else {
        NSLog(@"JSON数据生成失败，请检查数据格式!");
        
    }
    return jsonString;
}




-(BlockObject)blockObject{
    return objc_getAssociatedObject(self, _cmd);

}

-(void)setBlockObject:(BlockObject)blockObject{
    objc_setAssociatedObject(self, @selector(blockObject), blockObject, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

-(UIWindow *)keyWindow{
//    return [UIApplication sharedApplication].keyWindow;
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];;
    if (keyWindow == nil) {
        keyWindow = [[[UIApplication sharedApplication] delegate] window];

    }
    return keyWindow;
}

//-(void)setKeyWindow:(UIWindow *)keyWindow{
//    objc_setAssociatedObject(self, @selector(keyWindow), keyWindow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//}

-(UIViewController *)rootVC{
    //    return [UIApplication sharedApplication].keyWindow.rootViewController;
    return self.keyWindow.rootViewController;
}

//-(void)setRootVC:(UIViewController *)rootVC{
//    objc_setAssociatedObject(self, @selector(rootVC), rootVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//}

-(NSUserDefaults *)userDefaults{
    return [NSUserDefaults standardUserDefaults];
    
}


//-(void)setUserDefaults:(NSUserDefaults *)userDefaults{
//    objc_setAssociatedObject(self, @selector(userDefaults), userDefaults, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//}

#pragma mark- - 富文本
/**
 富文本特殊部分设置
 */
- (NSDictionary *)attrDictWithFont:(id)font textColor:(UIColor *)textColor{
    if ([font isKindOfClass:[NSNumber class]]) {
        font = [UIFont systemFontOfSize:[(NSNumber *)font floatValue]];
        
    }
    // 创建文字属性
    NSDictionary * dict = @{
                            NSFontAttributeName             :font,
                            NSForegroundColorAttributeName  :textColor
                            };
    
    return dict;
    
}

/**
 富文本整体设置
 */
- (NSDictionary *)attrParaDictWithFont:(id)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment{
    if ([font isKindOfClass:[NSNumber class]]) {
        font = [UIFont systemFontOfSize:[(NSNumber *)font floatValue]];
        
    }
    
    NSMutableParagraphStyle * paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = alignment;
//    paraStyle.lineSpacing = 5;//行间距
    
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:[self attrDictWithFont:font textColor:textColor]];
    [mdict setObject:paraStyle forKey:NSParagraphStyleAttributeName];
    
    return mdict;
    
}

/**
 富文本只有和一般文字同字体大小才能计算高度
 */
- (CGSize)sizeWithText:(id)text font:(id)font width:(CGFloat)width{
    if (![text validObject]) return CGSizeZero;

    NSAssert([text isKindOfClass:[NSString class]] || [text isKindOfClass:[NSAttributedString class]], @"请检查text格式!");
    NSAssert([font isKindOfClass:[UIFont class]] || [font isKindOfClass:[NSNumber class]], @"请检查font格式!");
    
    if ([font isKindOfClass:[NSNumber class]]) {
        font = [UIFont systemFontOfSize:[(NSNumber *)font floatValue]];
        
    }
    
    NSDictionary *attrDict = [self attrParaDictWithFont:font textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft];
    CGSize size = CGSizeZero;
    if ([text isKindOfClass:[NSString class]]) {
        size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrDict context:nil].size;
        
    }else{
        size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
        
    }
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}


- (CGSize)sizeItemsViewWidth:(CGFloat)width items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding{

//    CGFloat padding = 10;
//    CGFloat viewHeight = 30;
//    NSInteger numberOfRow = 4;
    NSInteger rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1;
    CGFloat itemWidth = (width - (numberOfRow-1)*padding)/numberOfRow;
    itemHeight = itemHeight == 0.0 ? itemWidth : itemHeight;;
    //
    CGSize size = CGSizeMake(width, rowCount * itemHeight + (rowCount - 1) * padding);
    return size;
}

/**
 (详细)富文本产生
 
 @param text 源字符串
 @param textTaps 特殊部分数组(每一部分都必须包含在text中)
 @param font 一般字体大小(传NSNumber或者UIFont)
 @param tapFontSize 特殊部分子体大小(传NSNumber或者UIFont)
 @param tapColor 特殊部分颜色
 @return 富文本字符串
 */
- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont tapColor:(UIColor *)tapColor alignment:(NSTextAlignment)alignment{
    return [self getAttString:text textTaps:textTaps font:font tapFont:tapFont color:[UIColor blackColor] tapColor:tapColor alignment:alignment];
    
}

- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont color:(UIColor *)color tapColor:(UIColor *)tapColor alignment:(NSTextAlignment)alignment{
    
    NSAssert(textTaps.count > 0, @"textTaps不能为空!");
    NSAssert([font isKindOfClass:[UIFont class]] || [font isKindOfClass:[NSNumber class]], @"请检查font格式!");
    
    // 设置段落
    NSDictionary *paraDict = [self attrParaDictWithFont:font textColor:color alignment:alignment];
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:text attributes:paraDict];
    
    for (NSString *textTap in textTaps) {
//        NSAssert([text containsString:textTap],@"textTaps中有不被字符串包含的元素");
        
        NSRange range = [text rangeOfString:textTap];
        // 创建文字属性
        NSDictionary * attrDict = [self attrDictWithFont:tapFont textColor:tapColor];
        [attString addAttributes:attrDict range:range];
        
    }
    return (NSAttributedString *)attString;
}


- (NSAttributedString *)getAttString:(NSString *)string textTaps:(id)textTaps tapColor:(UIColor *)tapColor{
    if ([textTaps isKindOfClass:[NSString class]]) textTaps = @[textTaps];
    if (!tapColor) tapColor = [UIColor redColor];
    NSAttributedString *attString = [self getAttString:string textTaps:textTaps font:@16 tapFont:@16 tapColor:tapColor alignment:NSTextAlignmentLeft];
    return attString;
}

/**
 富文本产生
 */
- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray *)textTaps{
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:string];
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KFZ_Fouth] range:NSMakeRange(0, string.length)];
    
    for (NSInteger i = 0; i < textTaps.count; i++) {
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[string rangeOfString:textTaps[i]]];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KFZ_Fouth] range:[string rangeOfString:textTaps[i]]];
        
    }
    return attString;
}


/**
 标题前加*
 
 */
-(NSArray *)getAttListByPrefix:(NSString *)prefix titleList:(NSArray *)titleList mustList:(NSArray *)mustList{
    
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSString * item in titleList) {
        NSString * title = item;
        if (![title hasPrefix:prefix]) title = [prefix stringByAppendingString:title];
        if (![marr containsObject:title]) [marr addObject:title];
        
        UIColor * colorMust = [mustList containsObject:title] ? [UIColor redColor] : [UIColor clearColor];
        
        NSArray * textTaps = @[prefix];
        NSAttributedString * attString = [self getAttString:title textTaps:textTaps font:@15 tapFont:@15 tapColor:colorMust alignment:NSTextAlignmentCenter];
        
        if (![marr containsObject:attString]) {
            NSUInteger index = [marr indexOfObject:title];
            [marr replaceObjectAtIndex:index withObject:attString];
            
        }
    }
    return marr.copy;
    
}
/**
 单个标题前加*
 
 */
- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content isMust:(BOOL)isMust{
    
    if (![content hasPrefix:prefix]) content = [prefix stringByAppendingString:content];
    
    UIColor * colorMust = isMust ? [UIColor redColor] : [UIColor clearColor];
    
    NSArray * textTaps = @[prefix];
    NSAttributedString * attString = [self getAttString:content textTaps:textTaps font:@15 tapFont:@15 tapColor:colorMust alignment:NSTextAlignmentCenter];
    return attString;
}

/**
 (推荐)单个标题前加*
 
 */
- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content must:(id)must{
    
    BOOL isMust = NO;
    if ([must isKindOfClass:[NSString class]]) {
        isMust = [self stringToBool:must];
        
    }
    else if ([must isKindOfClass:[NSNumber class]]){
        isMust = [must boolValue];
        
    }
    else{
        NSAssert([must isKindOfClass:[NSString class]] || [must isKindOfClass:[NSNumber class]], @"请检查数据类型!");
        
    }
    
    if (![content hasPrefix:prefix]) content = [prefix stringByAppendingString:content];
    
    UIColor * colorMust = isMust ? [UIColor redColor] : [UIColor clearColor];
    
    NSArray * textTaps = @[prefix];
    NSAttributedString * attString = [self getAttString:content textTaps:textTaps font:@15 tapFont:@15 tapColor:colorMust alignment:NSTextAlignmentCenter];
    return attString;
}

/**
 布尔值转字符串

 */
- (NSString *)stringFromBool:(NSNumber *)boolNum {

    NSString * string = @"";
    if ([@[@1,@0] containsObject:boolNum]) {
        string = [boolNum integerValue] == 1 ? @"1" : @"0";
        
    }else{
        NSAssert(([@[@1,@0] containsObject:boolNum]), @"boolNum值只能为1或者0");
        
    }
    return string;
}


/**
 字符串转布尔值

 */
- (BOOL)stringToBool:(NSString *)string{
    BOOL boolNum = NO;
    if ([@[@"1",@"0"] containsObject:string]) {
        boolNum = [string integerValue] == 1 ? YES : NO;
        
    }else{
        NSAssert(([@[@"1",@"0"] containsObject:string]), @"string值只能为1或者0");

    }
    return boolNum;
}

#pragma mark- - jsonToString

+ (NSString *)jsonToString:(id)data {
    if(data == nil)  return nil;
    
    if ([NSJSONSerialization isValidJSONObject:data]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;

    }
    return data;
}

+ (NSString *)stringFromInteger:(NSInteger)integer{
    NSString *interString = [NSString stringWithFormat:@"%@",@(integer)];
    return interString;
    
}

+ (NSString *)getMaxLengthStrFromArr:(NSArray *)arr{
    
    NSString *temp = [arr firstObject];
    for (NSString * obj in arr){
        if (obj.length > temp.length){
            temp = obj;
        }
    }
    return temp;
}

#pragma mark- -日期的文字显示类型选择适配(类似枚举)


- (NSDate *)dateWithTimeStamp:(NSString *)timeStamp{
    NSDate * date = [self dateWithString:[timeStamp toTimeDate]];
    return date;
}

- (NSString *)timeStampWithDate:(NSDate *)date{
    NSString *dateStr = [self stringWithDate:date];
    NSString * timeStamp = [dateStr toTimestamp];
    return timeStamp;
}

//- (NSString *)compareDate


#pragma mark- -字符串转日期

- (NSDate *)dateWithString:(NSString *)dateString{
    NSDate * date = [self dateWithString:dateString format:kFormat_date];
    return date;
}

- (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:format];
    NSDate * date = [formatter dateFromString:dateString];
    return date;
}

#pragma mark- -日期转字符串

- (NSString *)stringWithDate:(NSDate *)date{
    NSString * dateStr = [self stringWithDate:date format:kFormat_date];;
    return dateStr;
}

- (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:format];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
    
}
//
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:format];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;

}

- (BOOL)isKindClassArray:(NSArray *)classArray value:(id)value{
    
    for (NSString * className in classArray) {
        if ([value isKindOfClass:NSClassFromString(className)]) {
//            DDLog(@"valueClass__%@__%@",NSStringFromClass([value class]),className);
            return YES;
        }
    }
    return NO;
    
}

#pragma mark - -时间戳
//G:      公元时代，例如AD公元
//yy:     年的后2位
//yyyy:   完整年
//MM:     月，显示为1-12,带前置0
//MMM:    月，显示为英文月份简写,如 Jan
//MMMM:   月，显示为英文月份全称，如 Janualy
//dd:     日，2位数表示，如02
//d:      日，1-2位显示，如2，无前置0
//EEE:    简写星期几，如Sun
//EEEE:   全写星期几，如Sunday
//aa:     上下午，AM/PM
//H:      时，24小时制，0-23
//HH:     时，24小时制，带前置0
//h:      时，12小时制，无前置0
//hh:     时，12小时制，带前置0
//m:      分，1-2位
//mm:     分，2位，带前置0
//s:      秒，1-2位
//ss:     秒，2位，带前置0
//S:      毫秒
//Z：     GMT（时区）

/**
 *  根据格式将时间戳转换成时间
 *  @param timestamp    时间戳
 *  @param dateFormtter 日期格式
 *
 *  @return 带格式的日期
 */
+ (NSString *)dateFromTimestamp:(NSInteger)timestamp{
    
    NSDateFormatter * formatter = [NSDateFormatter dateFormat:kFormat_date];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString * timeStr = [formatter stringFromDate:date];
    return timeStr;
}
/**
 *  获取当前时间戳
 */
+ (NSString *)timestampFromNow{
    // 获取时间（非本地时区，需转换）
    NSDate * today = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:today];
    // 转换成当地时间
    NSDate *localeDate = [today dateByAddingTimeInterval:interval];
    // 时间转换成时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];
    
    return timeSp;
}

//获取当前时间戳
+ (NSString *)currentTimeStamp{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval timeInterval = [date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeStr = [NSString stringWithFormat:@"%.0f", timeInterval];
    return timeStr;
}

/**
 *  获取当前时间
 */
+ (NSString *)timeFromNow{
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:kFormat_date];
    NSString * dateStr = [formatter stringFromDate:[NSDate date]];

    return dateStr;
}

- (NSString *)toTimestampMonth{
    NSString * dateStr = (NSString *)self;
    
    NSString * tmp = @"01 00:00:00";//后台接口时间戳不要时分秒
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(dateStr.length - tmp.length, tmp.length) withString:tmp];
    
    return [dateStr toTimestamp];
}

- (NSString *)toTimestampShort{
    NSString * dateStr = (NSString *)self;

    NSString * tmp = @"00:00:00";//后台接口时间戳不要时分秒
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(dateStr.length - tmp.length, tmp.length) withString:tmp];
    
    return [dateStr toTimestamp];
}

- (NSString *)toTimestampFull{
    NSString * dateStr = (NSString *)self;
    
    NSString * tmp = @"23:59:59";//后台接口时间戳不要时分秒
    dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(dateStr.length - tmp.length, tmp.length) withString:tmp];
    
    return [dateStr toTimestamp];
}

#pragma mark - -转化
- (NSString *)toTimestamp{
    
    NSString * dateStr = (NSString *)self;
    
    NSString * formatStr = kFormat_date;
    if ([dateStr containsString:@"-"] && [dateStr containsString:@":"]){
        formatStr = kFormat_date;
 
    }
    else if ([dateStr containsString:@"-"] && ![dateStr containsString:@":"]){
        formatStr = kFormat_date_one;
        
    }
    else if (![dateStr containsString:@"-"] && ![dateStr containsString:@":"]){
        formatStr = kFormat_date_two;
        
    }
    else{
        DDLog(@"<%@>时间格式不对",dateStr);
      
    }
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:formatStr];
    NSDate *date = [formatter dateFromString:dateStr]; //将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSString * timestamp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] stringValue];
    return timestamp;
}

- (NSString *)toTimeDate{
    //优化,是时间戳直接转化;不是时间戳则返回,
    NSTimeInterval timeInterval;
    if ([self isKindOfClass:[NSString class]]) {
        NSString * string = (NSString *)self;
        if ([string containsString:@"-"] || string.length < 10) return string;
        
        timeInterval = [string integerValue];
        
    }else{
        timeInterval = (NSInteger)self;
        
    }
    
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:kFormat_date];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString * timeStr = [formatter stringFromDate:date];
    return timeStr;
}

- (NSDate *)toData{
//    NSAssert([self isKindOfClass:[NSNumber class]] && [self isKindOfClass:[NSString class]], @"NSString/NSNumber");
    
    NSTimeInterval timeInterval = 0.0;
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self containsString:@"-"]) {
            timeInterval = [[(NSString *)self toTimestamp]doubleValue];
            
        }else{
            timeInterval = [(NSString *)self integerValue];
            
        }
    
    }else{
        timeInterval = (NSInteger)self;
        
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return date;
    
}


- (NSString *)timeByAddingDays:(id)days{
    if (days == nil) days = @0;
    
    if ([days isKindOfClass:[NSString class]]) {
        days = [days numberValue];
    }
    
    NSString * dateStr = [self toTimeDate];
    NSDate * date = [self dateWithString:dateStr format:kFormat_date];
    NSString * newtime = [self stringWithDate:[date dateByAddingDays:[days integerValue]]];
    return newtime;
}

#pragma mark - 将某个时间转化成 时间戳
+ (NSString *)timestampFromTime:(NSString *)formatTime{

//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:kFormat_date];
    
    NSDate* date = [formatter dateFromString:formatTime]; //将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSString * timestamp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] stringValue];
    return timestamp;
}


#pragma mark - 将某个时间戳转化成 时间
+ (NSString *)timeFromTimestamp:(id)timestamp{
    //优化,是时间戳,直接;不是时间戳则转化,
    NSTimeInterval timeInterval;
    if ([timestamp isKindOfClass:[NSString class]]) {
        timeInterval = [timestamp integerValue];
        
    }else{
        timeInterval = (NSInteger)timestamp;

    }
    
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:kFormat_date];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSString * timeStr = [formatter stringFromDate:confromTimesp];
    return timeStr;
}


/**  比较两个日期,年月日, 时分秒 各相差多久
 *   先判断年 若year>0   则相差这么多年,后面忽略
 *   再判断月 若month>0  则相差这么多月,后面忽略
 *   再判断日 若day>0    则相差这么多天,后面忽略(0是今天,1是昨天,2是前天)
 *          若day=0    则是今天 返回相差的总时长
 */
+ (NSDateComponents *)compareCalendar:(NSDate *)date{
    
    NSDate * currtentDate = [NSDate date];
    
    // 比较日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 这个返回的是相差多久
    // 比如差12个小时, 无论在不在同一天 day都是0
    // NSDateComponents *components = [calendar components:unit fromDate:date toDate:currtentDate options:0];
    NSDateComponents *currentCalendar =[calendar components:unit fromDate:currtentDate];
    NSDateComponents *targetCalendar =[calendar components:unit fromDate:date];
    
    BOOL isYear = currentCalendar.year == targetCalendar.year;
    BOOL isMonth = currentCalendar.month == targetCalendar.month;
    BOOL isDay = currentCalendar.day == targetCalendar.day;
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    if (isYear) {
        if (isMonth) {
            if (isDay) {
                // 时分秒
                components = [calendar components:unit fromDate:date toDate:currtentDate options:0];
            }
            [components setValue:(currentCalendar.day - targetCalendar.day) forComponent:NSCalendarUnitDay];
        }
        [components setValue:(currentCalendar.month - targetCalendar.month) forComponent:NSCalendarUnitMonth];
    }
    [components setValue:(currentCalendar.year - targetCalendar.year) forComponent:NSCalendarUnitYear];
    return components;
}

/**  最近的日期*/
+ (NSString *)relativeDate:(NSDate *)date{
    
    // 日期格式化类
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    format.dateFormat = @"yyyy-MM-dd";
    
    NSDate * currtentDate = [NSDate date];
    
    //    // 比较日历
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //    // 这个返回的是相差多久
    //    // 比如差12个小时, 无论在不在同一天 day都是0
    //    // NSDateComponents *components = [calendar components:unit fromDate:date toDate:currtentDate options:0];
    //    NSDateComponents *currentCalendar =[calendar components:unit fromDate:currtentDate];
    //    NSDateComponents *targetCalendar =[calendar components:unit fromDate:date];
    //
    //    BOOL isYear = currentCalendar.year == targetCalendar.year;
    //    BOOL isMonth = currentCalendar.month == targetCalendar.month;
    //    BOOL isDay = currentCalendar.day == targetCalendar.day;
    
    NSDateComponents *components = [self compareCalendar:date];
    
    // 比较时间
    NSTimeInterval t = [currtentDate timeIntervalSinceDate:date];
    
    // 一分钟内
    if (t < 60) {
        return @"刚刚";
    }
    // 一小时内
    else if (t < 60 * 60) {
        return [NSString stringWithFormat:@"%ld分钟前", (long)(t/60)];
    }
    // 今天
    else if (components.year == 0 && components.month == 0 && components.day == 0) {
        if (t/3600 > 3) {
            format.dateFormat = @"HH:mm";
            return [format stringFromDate:date];
        }
        return [NSString stringWithFormat:@"%zd小时前", (int)t/3600];
    }
    // 昨天
    else if (components.year == 0 && components.month == 0 && components.day == 1) {
        format.dateFormat = @"昨天 HH:mm";
        return [format stringFromDate:date];
    }
    // 前天
    else if (components.year == 0 && components.month == 0 && components.day == 2) {
        return @"前天";
    }
    // 今年
    else if (components.year == 0) {
        format.dateFormat = @"MM-dd";
        return [format stringFromDate:date];
    }
    // 今年以前
    return [format stringFromDate:date];;
}

+ (NSString *)timeTipInfoFromTimestamp:(NSInteger)timestamp{
    
    NSDateFormatter * dateFormtter = [[NSDateFormatter alloc] init];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSTimeInterval late =[date timeIntervalSince1970]*1;    //转记录的时间戳
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;   //获取当前时间戳
    NSString *timeString = @"";
    NSTimeInterval cha = now - late;
    // 发表在一小时之内
    if (cha/3600<1) {
        if (cha/60<1) {
            timeString = @"1";
        }
        else{
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    // 在一小时以上24小以内
    else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    // 发表在24以上10天以内
    else if (cha/86400>1&&cha/86400*3<1){
        //86400 = 60(分)*60(秒)*24(小时)   3天内
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    // 发表时间大于10天
    else{
        [dateFormtter setDateFormat:@"yyyy-MM-dd"];
        timeString = [dateFormtter stringFromDate:date];
    }
    return timeString;
}

-(NSString *)compareCurrentTime{
    NSAssert([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSDate class]], @"NSString/NSDate");
    NSDate * compareDate = nil;
    if ([self isKindOfClass:[NSDate class]]) {
        compareDate = (NSDate *)self;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        compareDate = [self toData];
    }
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%@分前",@(temp)];
        
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%@小前",@(temp)];
        
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%@天前",@(temp)];
        
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%@月前",@(temp)];
        
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%@年前",@(temp)];
        
    }
    return  result;
    
}

-(NSString *)compareCurrentTimeDays{
    NSAssert([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSDate class]], @"NSString/NSDate");
    NSDate * compareDate = nil;
    if ([self isKindOfClass:[NSDate class]]) {
        compareDate = (NSDate *)self;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if (((NSString *)self).length >= 10) {
            compareDate = [self toData];
            
        }else{
            return kNIl_TEXT;
            
        }
    }
    
//     NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:oldDate];
//     NSLog(@"time:%f",time/60/60/24);
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%@分前",@(temp)];
        
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%@小前",@(temp)];
        
    }
    else{
        temp = temp/24;
        result = [NSString stringWithFormat:@"%@天前",@(temp)];
        
    }
    return  result;
    
}

-(NSString *)compareTimeInfo{
    NSAssert([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSDate class]], @"NSString/NSDate");
    NSDate * compareDate = nil;
    if ([self isKindOfClass:[NSDate class]]) {
        compareDate = (NSDate *)self;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if (((NSString *)self).length >= 10) {
            compareDate = [self toData];
            
        }else{
            return kNIl_TEXT;
            
        }
    }
    NSDateFormatter *formatter = [NSDateFormatter dateFormat:kFormat_date];
    NSString * dateStr = [formatter stringFromDate:compareDate];
    
    NSString * timeNow = [NSString timeFromNow];
    
    NSString * dateInfo = dateStr;
    if ([[dateStr substringWithRange:NSMakeRange(0, 4)] isEqualToString:[timeNow substringWithRange:NSMakeRange(0, 4)]]) {
        dateInfo = [dateStr substringWithRange:NSMakeRange(5, 11)];
        
    }else{
        dateInfo = [dateStr substringWithRange:NSMakeRange(0, 15)];
        
    }
    return  dateInfo;
    
}

#pragma mark - -获取随机数，范围在[from,to]，包括from，包括to
- (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

- (NSString *)getRandomStr:(NSInteger)from to:(NSInteger)to{
    NSInteger random = (NSInteger)(from + (arc4random() % (to - from + 1)));
    NSString * randomStr = [@(random) stringValue];
    return randomStr;
}

- (void)handleCallPhone:(NSString *)phoneNumber{
    NSString * phoneNum = phoneNumber;
    if (phoneNum) {
        phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
        phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
        phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"转" withString:@""];
    }
    
    NSString *device = [UIDevice currentDevice].model;

    
}

#pragma mark- -timer创建及启动
- (NSTimer *)createTimerAndStartWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target aSelector:(SEL)aSelector repeats:(BOOL)repeats{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:target selector:aSelector userInfo:nil repeats:repeats];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
    
    return timer;
}

- (void)stopTimer:(NSTimer *)timer{
    if ([timer isValid]) {
        [timer invalidate];
        timer = nil;
        
    }
}

#pragma mark- -十六进制颜色

+ (UIColor *)colorWithHexString:(NSString *)colorString{
    NSString *cString = [[colorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *)randomColor{
    
    CGFloat red = arc4random_uniform(256);
    CGFloat green = arc4random_uniform(256);
    CGFloat blue = arc4random_uniform(256);
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

- (void)copyToPasteboard{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if ([self isKindOfClass:[NSAttributedString class]]) {
        pasteboard.string = [(NSAttributedString *)self string];

    }
    if ([self isKindOfClass:[NSString class]]) {
        pasteboard.string = (NSString *)self;

    }
    
    NSAssert([self isKindOfClass:[NSString class]] | [self isKindOfClass:[NSAttributedString class]], @"目前仅支持NSString,NSAttributedString");
    
    UIWindow * keyWindow = [[[UIApplication sharedApplication] delegate] window];
    NSString * tips = [NSString stringWithFormat:@"'%@'已复制!",pasteboard.string];
    [keyWindow makeToast:tips duration:1 position:CSToastPositionCenter];
}

- (BOOL)openThisURL{
    NSAssert([self isKindOfClass:[NSAttributedString class]] || [self isKindOfClass:[NSString class]], @"只支持字符串,请检查格式!");

    NSString * urlString = nil;
    if ([self isKindOfClass:[NSAttributedString class]]) {
        urlString = [(NSAttributedString *)self string];
        
    }
    if ([self isKindOfClass:[NSString class]]) {
        urlString = (NSString *)self;
        
    }
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:urlString];
    
    
    __block BOOL isSuccess = NO;
    if (iOS(10)) {
        [application openURL:URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES} completionHandler:^(BOOL success) {
               NSLog(@"Open %@_%d",urlString,success);
            isSuccess = success;
           }];
    }
    else{
        BOOL success = [application openURL:URL];
        NSLog(@"Open %@_%d",urlString,success);
        isSuccess = success;

    }
    return isSuccess;
}

- (NSInteger)rowCountWithItemList:(NSArray *)itemList rowOfNumber:(NSInteger)rowOfNumber{
    
    NSInteger rowCount = itemList.count % rowOfNumber == 0 ? itemList.count/rowOfNumber : (itemList.count/rowOfNumber + 1);
    return rowCount;
    
}


//- (float)roundFloat{
//    NSParameterAssert([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSNumber class]]);
//
//    float num = 0.0;
//    if ([self isKindOfClass:[NSString class]]) {
//        num = [(NSString *)self floatValue];
//    }
//
//    if ([self isKindOfClass:[NSNumber class]]) {
//        num = [(NSNumber *)self floatValue];
//    }
//    return  (floorf(num*100 + 0.5))/100;
//
//}

@end

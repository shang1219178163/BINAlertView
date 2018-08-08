

//
//  UITextField+Helper.m
//  HuiZhuBang
//
//  Created by hsf on 2018/6/8.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UITextField+Helper.h"

@implementation UITextField (Helper)


//- (void)characterSetString:(NSString *)setString{
//    
//    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:setString] invertedSet];
//    NSString *fieldString = [[string componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
//    return  [string isEqualToString:fieldString];
//    
//}

- (BOOL)handlePhoneTF:(UITextField *)phoneTF replacementString:(NSString *)string{
    //只有手机号需要空格,密码不需要
    if (self == phoneTF) {
        if ([string isEqualToString:@""]) { // 删除字符
            return YES;
        }
        else {
            if (self.text.length == 3 || self.text.length == 8) {//输入
                NSString * temStr = self.text;
                temStr = [temStr stringByAppendingString:@" "];
                self.text = temStr;
                
            }
            else if (self.text.length >= 13){
                return NO;
            }
        }
    }
    return YES;
}

@end

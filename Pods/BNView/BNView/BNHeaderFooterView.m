//
//  BNHeaderFooterView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/2.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BNHeaderFooterView.h"

#import <objc/runtime.h>
#import "BNGloble.h"
#import "BNCategory.h"

@interface BNHeaderFooterView ()

@end

@implementation BNHeaderFooterView


-(UIImageView *)imgViewLeft{
    if (!_imgViewLeft) {
        _imgViewLeft = [UIView createImgViewRect:CGRectZero image:nil tag:kTAG_IMGVIEW type:@0];
    }
    return _imgViewLeft;
}

-(UILabel *)labelLeft{
    if (!_labelLeft) {
        _labelLeft = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL type:@2];
        _labelLeft.font = [UIFont systemFontOfSize:kFZ_Second];
        _labelLeft.backgroundColor = UIColor.whiteColor;
        _labelLeft.textAlignment = NSTextAlignmentLeft;
    }
    return _labelLeft;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIView createBtnRect:CGRectZero title:@"按钮" font:16 image:nil tag:kTAG_BTN type:@7];
    }
    return _btn;
}

@end


@implementation FoldSectionModel

- (NSString *)description{
    //当然，如果你有兴趣知道出类名字和对象的内存地址，也可以像下面这样调用super的description方法
    //    NSString * desc = [super description];
    NSString * desc = @"\n";
    
    unsigned int outCount;
    //获取obj的属性数目
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //获取property的C字符串
        const char * propName = property_getName(property);
        if (propName) {
            //获取NSString类型的property名字
            NSString * prop = [NSString stringWithCString:propName encoding:[NSString defaultCStringEncoding]];
            
            if (![NSClassFromString(prop) isKindOfClass:[NSObject class]]) {
                continue;
            }
            
            //获取property对应的值
            id obj = [self valueForKey:prop];
            //将属性名和属性值拼接起来
            desc = [desc stringByAppendingFormat:@"%@ : %@;\n",prop,obj];
        }
    }
    
    free(properties);
    return desc;
}

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _dataList;
}

@end

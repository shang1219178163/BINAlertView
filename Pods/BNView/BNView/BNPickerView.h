//
//  BNPickerView.h
//  BINView
//
//  Created by BIN on 2017/9/13.
//  Copyright © 2017年 BIN. All rights reserved.
//


/*
 ---------------------------必读------------------------------------
 type 为 @"2" 时(双选联动),数据结构必须是
 {
     数组[
         字典[
            kPickViewTitle:字符串(左侧列表展示的数据),
            kPickViewContent:数组(右侧列表展示的数据)
            ]
         ......
         n个字典
         ]
 }
 例如:
 for (NSInteger i = 0; i < 1; i++) {
 
    NSArray * arr = nil;
    NSMutableDictionary * mdict = nil;

    switch (i) {
        case 0:
        {
        arr = @[@"A",@"B",@"C",@"D",@"E"];
        mdict = [@{
                kPickViewTitle:@"英文字母",
                kPickViewContent:arr
                }mutableCopy];
        }
        break;
            default:
        break;
     }
     [self.marr addObject:mdict];
     //左侧多少行,添加多少字典,
 }

 NSArray *array = [NSArray arrayWithArray:(NSArray *)self.marr];

 将此array传入BNPickerView初始化方法即可
 - (void)btnClickNew{
     //    self.array = @[@"A",@"B",@"C",@"D",@"E"];
     BNPickerView * pickerView = [[BNPickerView alloc]initWithPickerData:self.array type:@2 cancelBtnTitle:@"取消" confirmBtnTitle:@"确定"];
     [pickerView actionSelectRow:2 inComponent:0];
     //    [pickerView actionSelectRow:3 inComponent:1];
     [self.view addSubview:pickerView];
     
     [pickerView show];
    pickerView .block = ^(UIPickerView *pickerView, NSInteger row1, NSInteger row2, NSInteger btnIndex) {
     DDLog(@"BNPickerView_%ld_%ld_%ld",row1,row2,btnIndex);
     
     };
 
 }
 ---------------------------必读------------------------------------
 */

#import <UIKit/UIKit.h>
//深层PickerView封装

#define kPickViewTitle  @"title"
#define kPickViewContent  @"content"

/**
 Description

 @param pickerView UIPickerView
 @param row1 为 component0 的 row(左侧)

 @param row2 为 component1 的 row(右侧)
 @param btnIndex 顶部栏 按钮索引 0:取消,1确定
 */

@interface BNPickerView : UIView

@property (nonatomic, copy) void(^block)(UIPickerView *pickerView,NSInteger row1,NSInteger row2,NSInteger btnIndex);;

@property (nonatomic, strong) NSString *title;

- (instancetype)initWithPickerData:(NSArray *)array type:(NSNumber *)type cancelBtnTitle:(NSString *)cancelBtnTitle confirmBtnTitle:(NSString *)confirmBtnTitle;

- (void )actionSelectRow:(NSInteger)row inComponent:(NSInteger)component;

- (void)show;
- (void)dismissPickerView;

@end

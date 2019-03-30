//
//  BINPickerView.h
//  BINView
//
//  Created by hsf on 2017/9/12.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>
//浅层PickerView封装
typedef void(^BlockPickView)(UIPickerView *pickerView,NSInteger index);

@interface BINPickerView : UIPickerView

@property (nonatomic, copy) BlockPickView blockPickView;

@property (nonatomic, strong) NSString *title;

-(id)initWithCancelBtnTitle:(NSString *)cancelBtnTitle confirmButtonTitle:(NSString *)confirmBtnTitle;

- (void)show;
- (void)dismissPickerView;

- (void)actionWithBlock:(BlockPickView)blockPickView;

@end

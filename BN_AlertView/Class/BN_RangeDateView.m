//
//  BN_RangeDateView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/18.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_RangeDateView.h"


#import "BN_DatePicker.h"

@interface BN_RangeDateView()

@property (nonatomic, strong, readwrite) NSMutableArray *itemList;

@end

@implementation BN_RangeDateView

-(NSMutableArray *)itemList{
    if(!_itemList){
        _itemList = [NSMutableArray arrayWithCapacity:0];
    }
    return _itemList;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = UIColor.whiteColor;
        
  
        _dateStart = NSDate.date.timeStamp;
        _dateEnd = NSDate.date.timeStamp;
        _titleList = @[@"查询日期",_dateStart,@"-",_dateEnd];
        
        [self createControls];
    }
    return self;
}

- (void)createControls{
    CGFloat width = (CGRectGetWidth(self.frame) - 10*2)/3.3;

    NSString * title = @"";
    CGRect rect = CGRectZero;
    for (NSInteger i = 0; i < self.titleList.count; i++) {
        title = self.titleList[i];
        
        switch (i) {
            case 0:
            {
                rect = CGRectMake(10, (CGRectGetHeight(self.frame) - 30)*0.5, width, 30);
                
            }
                break;
            case 2:
            {
                rect = CGRectMake(CGRectGetMaxX(rect), CGRectGetMinY(rect), width*0.3, CGRectGetHeight(rect));
                
            }
                break;
            case 1:
            case 3:
            {
                rect = CGRectMake(CGRectGetMaxX(rect), CGRectGetMinY(rect), width, CGRectGetHeight(rect));
                
            }
                break;
            default:
                break;
        }
        
        UILabel * label = [UIView createLabelWithRect:rect text:title textColor:nil tag:kTAG_LABEL+i patternType:@"2" font:15 backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentCenter];
        if (i%2 == 1) {
            label.text = [title toDateShort];
            label.layer.borderColor = UIColor.lightGrayColor.CGColor;
            label.layer.borderWidth = 0.5;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handlActionSender:)];
            label.userInteractionEnabled = YES;
            [label addGestureRecognizer:tap];

        }
        [self addSubview:label];
    
        [self.itemList addObject:label];
    }
}

- (void)handlActionSender:(UITapGestureRecognizer *)tap{
    UILabel * label = (UILabel *)tap.view;
    NSInteger idx = tap.view.tag - kTAG_LABEL;
    
    NSString * dateBegin = idx == 1 ? self.dateStart : self.dateEnd;
    if (dateBegin.length != 10) dateBegin = NSDate.date.timeStamp;
    [self createDatePick:label.text tag:(kTAG_DATE_PICKER+idx)];
    
}

#pragma mark - - BINDatePicker
- (void)createDatePick:(id)date tag:(NSInteger)tag{
    [[self superview]endEditing:YES];
    BN_DatePicker *datePicker = [[BN_DatePicker alloc]initWithCancelBtnTitle:@"取消" confirmBtnTitle:@"确认"];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.minimumDate = [NSDate distantPast];
    datePicker.maximumDate = [NSDate distantFuture];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //    datePicker.locale = [NSLocale currentLocale];
    datePicker.title = @"请选择时间";
    datePicker.tag = tag;
    
    if ([date isKindOfClass:[NSString class]]) date = [NSDate dateWithString:date];
    datePicker.date = date ? date: [NSDate date];
    [datePicker show];
    datePicker.block = ^(UIDatePicker *datePicker, NSInteger btnIndex) {
        NSString * dateStr = [self stringWithDate:datePicker.date];
        DDLog(@"dateStr_%@_%ld",dateStr,btnIndex);
        if (btnIndex == 1) {
            NSInteger idx = tag - kTAG_DATE_PICKER;
            UILabel * label = self.itemList[idx];
            label.text = [dateStr toDateShort];
            switch (idx) {
                case 1:
                {
                    self.dateStart = dateStr;

                }
                    break;
                case 3:
                {
                    self.dateEnd = dateStr;

                }
                    break;
                default:
                    break;
            }

            if (self.block) {
                self.block(self, self.dateStart, self.dateEnd);
            }
            DDLog(@"\n_%@_%@",self.dateStart,self.dateEnd);
        }
    };
}

#pragma mark- -layz

-(void)setDateStart:(NSString *)dateStart{
    _dateStart = dateStart;
    
    UILabel * label = self.itemList[1];
    if (dateStart.length > 10) {
        label.text = [dateStart substringToIndex:10];

    }else{
        label.text = dateStart;

    }
    
}

-(void)setDateEnd:(NSString *)dateEnd{
    _dateEnd = dateEnd;
    
    UILabel * label = self.itemList[3];
    if (dateEnd.length > 10) {
        label.text = [dateEnd substringToIndex:10];
        
    }else{
        label.text = dateEnd;

    }
}



@end

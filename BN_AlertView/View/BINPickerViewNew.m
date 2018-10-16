//
//  BINPickerViewNew.m
//  BINView
//
//  Created by hsf on 2017/9/13.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import "BINPickerViewNew.h"

#define kH_NaviagtionBarHeight 44
#define kH_PickerViewHeight 180

//static  NSString *const kPickViewTitle = @"title";
//static  NSString *const kPickViewContent = @"content";

@interface BINPickerViewNew ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;// 中间标题Label;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSString *patternType;//1:单选,2:2选联动

@property (nonatomic, strong) NSArray * array;
@property (nonatomic, strong) NSArray * arr;
@property (nonatomic, strong) NSDictionary * dict;

@property (nonatomic, assign) NSInteger pickerViewRow1;
@property (nonatomic, assign) NSInteger pickerViewRow2;

@end

@implementation BINPickerViewNew

- (instancetype)initWithPickerData:(NSArray *)array patternType:(NSString *)patternType cancelBtnTitle:(NSString *)cancelBtnTitle confirmButtonTitle:(NSString *)confirmBtnTitle
{
    
    self = [super init];
    if (self) {
        self.patternType = patternType;
        if ([self.patternType isEqualToString:@"1"]) {
            self.array = [NSArray arrayWithArray:(NSArray *)array];
            
        }else if ([self.patternType isEqualToString:@"2"]) {
            self.array = [NSArray arrayWithArray:(NSArray *)array];
            self.arr = self.array[0][kPickViewContent];
            self.dict = self.array[0];
            //初始化数据
        }else{
            NSAssert([self.patternType integerValue] == 1 || [self.patternType integerValue] == 2, @"目前只支持单选和双选联动");
            
        }

        //UI
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        
        self.maskView = [[UIView alloc] initWithFrame:window.bounds];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.5;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPickerView)];
        [self.maskView addGestureRecognizer:tap];
        
        // custom DatePicker height
        CGFloat lineHeight = 1;
        CGFloat height = kH_PickerViewHeight + kH_NaviagtionBarHeight + lineHeight;
        self.containView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(window.frame), CGRectGetWidth(window.frame), height)];
        self.containView.backgroundColor = [UIColor lightGrayColor];
        
        //UIToolbar
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.containView.frame), kH_NaviagtionBarHeight)];
        toolBar.tintColor = [UIColor blackColor];//字体颜色
        toolBar.barTintColor = UIColor.whiteColor;//背景
        
        //顶部按钮
        NSString *cancelTitle = [NSString stringWithFormat:@"   %@",cancelBtnTitle];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:cancelTitle style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
        [cancelItem setTintColor:[UIColor redColor]];
        
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        NSString *confirmTitle = [NSString stringWithFormat:@"%@    ",confirmBtnTitle];
        UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:confirmTitle style:UIBarButtonItemStylePlain target:self action:@selector(confirm)];
        [confirmItem setTintColor:[UIColor blackColor]];
        
        NSArray *items = @[cancelItem,flexItem,confirmItem];
        [toolBar setItems:items];
        [self.containView addSubview:toolBar];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kH_NaviagtionBarHeight, CGRectGetWidth(self.containView.frame), lineHeight)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.containView addSubview:lineView];
        
        // config titleLabel
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.containView.frame)/3.0, kH_NaviagtionBarHeight)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [toolBar addSubview:self.titleLabel];
        self.titleLabel.center = toolBar.center;
        
        [self.containView addSubview:self.pickerView];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    
}

-(UIPickerView *)pickerView{
    
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kH_NaviagtionBarHeight+1, CGRectGetWidth(self.containView.frame), kH_PickerViewHeight)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;

        _pickerView.backgroundColor = UIColor.whiteColor;
        
    }
    return _pickerView;
}

-(void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self.maskView];
    [window addSubview:self.containView];
    
    CGRect tempFrame = self.containView.frame;
    tempFrame.origin.y = CGRectGetMinY(tempFrame) - CGRectGetHeight(tempFrame);
    
    [UIView animateWithDuration:0.5f animations:^{
        self.maskView.alpha = 0.5;
        self.containView.frame = tempFrame;
    } completion:nil];
}


#pragma mark UITapGestureRecognizer Sel

-(void)dismissPickerView
{
    CGRect tempFrame = self.containView.frame;
    tempFrame.origin.y = CGRectGetMinY(tempFrame) + CGRectGetHeight(tempFrame);
    
    [UIView animateWithDuration:0.5f animations:^{
        self.maskView.alpha = 0;
        self.containView.frame = tempFrame;
    } completion:^(BOOL finished) {
        [self.containView removeFromSuperview];
        [self.maskView removeFromSuperview];
    }];
}

#pragma mark Cancel and Confirm
-(void)cancel
{
    if (self.blockPickView) {
        self.blockPickView(self.pickerView, self.pickerViewRow1,self.pickerViewRow2,[@"0" integerValue]);
    }
    [self dismissPickerView];
}


-(void)confirm
{
    if (self.blockPickView) {
        self.blockPickView(self.pickerView, self.pickerViewRow1,self.pickerViewRow2,[@"1" integerValue]);
    }
    [self dismissPickerView];
}

-(void)actionWithBlock:(BlockPickViewNew)blockPickView{
    self.blockPickView = blockPickView;
    
}

- (void )actionSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        self.pickerViewRow1 = row;

    }else{
        self.pickerViewRow2 = row;

    }
    
    if ([self.patternType isEqualToString:@"2"]) {
        if (component == 0) {
            self.dict = self.array[row];
            self.arr = self.array[row][kPickViewContent];
            [self.pickerView reloadComponent:1];

        }
    }
    NSAssert(component < [self.patternType integerValue], @"component 应当小于 patternType的值");
    [self.pickerView selectRow:row inComponent:component animated:YES];
}

#pragma mark - - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
   
    if ([self.patternType isEqualToString:@"1"]) return 1;
    if ([self.patternType isEqualToString:@"2"]) return 2;
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSInteger rowCount = 0;
    if ([self.patternType isEqualToString:@"1"]) {
        rowCount = self.array.count;
        
    }
    else if ([self.patternType isEqualToString:@"2"]){
        switch (component) {
            case 0:
            {
                rowCount = self.array.count;
            }
                break;
            case 1:
            {
                rowCount = self.arr.count;
            }
                break;
            default:
                break;
        }
        
    }
    return rowCount;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *title = nil;
    NSDictionary *dict = nil;
    if ([self.patternType isEqualToString:@"1"]) {
        title = self.array[row];
        
    }
    else if ([self.patternType isEqualToString:@"2"]){
        switch (component) {
            case 0:
            {
                dict = self.array[row];
                title = dict[kPickViewTitle];
            }
                break;
            case 1:
            {
                title = self.arr[row];
            }
                break;
            default:
                break;
        }

    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSString * title = @"";
    if ([self.patternType isEqualToString:@"1"]) {
        title = self.array[row];
        //
        self.pickerViewRow1 = row;
        self.pickerViewRow2 = row;

    }
    else if ([self.patternType isEqualToString:@"2"]){
        if (component == 0) {
            self.dict = self.array[row];
            self.arr = self.dict[kPickViewContent];
            
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView reloadComponent:1];
            //
            self.pickerViewRow1 = row;
        }
        else if (component == 1)
        {
            //
            self.pickerViewRow2 = row;
        }
        NSString * title = self.dict[kPickViewTitle];
        NSArray * arr = self.dict[kPickViewContent];
        NSString * content = arr[0];
        if (component == 1) {
            content = arr[row];
        }
        NSLog(@"title__%@_content__%@",title,content);

    }
    NSLog(@"Row__(%ld,%ld)",self.pickerViewRow1,self.pickerViewRow2);
    
};


@end

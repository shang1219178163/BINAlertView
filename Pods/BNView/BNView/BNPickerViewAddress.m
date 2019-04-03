//
//  BNPickerViewAddress.m
//  picker
//
//  Created by BIN on 2017/11/15.
//  Copyright © 2017年 Sylar. All rights reserved.
//

#import "BNPickerViewAddress.h"

#import "BNGloble.h"
#import "BNCategory.h"

@interface BNPickerViewAddress ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;// 中间标题Label;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSDictionary *areaDic;
@property (nonatomic, strong) NSArray *province;
@property (nonatomic, strong) NSArray *city;
@property (nonatomic, strong) NSArray *district;
@property (nonatomic, strong) NSString *selectedProvince;

@end

@implementation BNPickerViewAddress

+(BNPickerViewAddress *)pickerViewCancelBtnTitle:(NSString *)cancelBtnTitle confirmBtnTitle:(NSString *)confirmBtnTitle{
    BNPickerViewAddress * addressPickerView = [[BNPickerViewAddress alloc]initWithCancelBtnTitle:cancelBtnTitle confirmBtnTitle:confirmBtnTitle];
    return addressPickerView;
}

- (instancetype)initWithCancelBtnTitle:(NSString *)cancelBtnTitle confirmBtnTitle:(NSString *)confirmBtnTitle{
    self = [super init];
    if (self) {
        [self bindData];
        //UI
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        
        self.maskView = [[UIView alloc] initWithFrame:window.bounds];
        self.maskView.backgroundColor = UIColor.blackColor;
        self.maskView.alpha = 0.5;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self.maskView addGestureRecognizer:tap];
        
        // custom DatePicker height
        CGFloat lineHeight = 1;
        CGFloat height = kH_PickerView + kH_NaviagtionBar + lineHeight;
        self.containView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(window.frame), CGRectGetWidth(window.frame), height)];
        self.containView.backgroundColor = UIColor.lightGrayColor;
        
        //UIToolbar
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.containView.frame), kH_NaviagtionBar)];
        toolBar.tintColor = UIColor.blackColor;//字体颜色
        toolBar.barTintColor = UIColor.whiteColor;//背景
        
        //顶部按钮
        NSString *cancelTitle = [NSString stringWithFormat:@"   %@",cancelBtnTitle];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:cancelTitle style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
        [cancelItem setTintColor:UIColor.redColor];
        
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        NSString *confirmTitle = [NSString stringWithFormat:@"%@    ",confirmBtnTitle];
        UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:confirmTitle style:UIBarButtonItemStylePlain target:self action:@selector(confirm)];
        [confirmItem setTintColor:UIColor.blackColor];
        
        NSArray *items = @[cancelItem,flexItem,confirmItem];
        [toolBar setItems:items];
        [self.containView addSubview:toolBar];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kH_NaviagtionBar, CGRectGetWidth(self.containView.frame), lineHeight)];
        lineView.backgroundColor = UIColor.lightGrayColor;
        [self.containView addSubview:lineView];
        
        // config titleLabel
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.containView.frame)/3.0, kH_NaviagtionBar)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = UIColor.clearColor;
        [toolBar addSubview:self.titleLabel];
        self.titleLabel.center = toolBar.center;
        
        [self.containView addSubview:self.pickerView];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
    
}

-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kH_NaviagtionBar+1, CGRectGetWidth(self.containView.frame), kH_PickerView)];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;
        
        _pickerView.backgroundColor = UIColor.whiteColor;
        [_pickerView selectRow: 0 inComponent: 0 animated: YES];

    }
    return _pickerView;
}

-(void)show{
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    [window addSubview:self.maskView];
    [window addSubview:self.containView];
    
    CGRect tempFrame = self.containView.frame;
    tempFrame.origin.y = CGRectGetMinY(tempFrame) - CGRectGetHeight(tempFrame);
    
    [UIView animateWithDuration:0.5f animations:^{
        self.maskView.alpha = 0.5;
        self.containView.frame = tempFrame;
    } completion:nil];
}

- (void)actionSelectAddress:(NSString *)address{
    if (![address containsString:kString_Separate]) {
        if ([address containsString:@"省"]) {
            NSString * stringRe = [@"省" stringByAppendingString:kString_Separate];
            address = [address stringByReplacingOccurrencesOfString:@"省" withString:stringRe];

        }
        
        if ([address containsString:@"市"]) {
            NSString * stringReCity = [@"市" stringByAppendingString:kString_Separate];
            address = [address stringByReplacingOccurrencesOfString:@"市" withString:stringReCity];
            
        }
    }
    
    NSArray * addressArr = [address componentsSeparatedByString:kString_Separate];
    if (addressArr.count != 3) {
        NSAssert(addressArr.count == 3, @"地址必须是3个用空字符分隔的字符串!");
        return;
    }
    
    
    NSUInteger index0 = [self.province indexOfObject:addressArr[0]];
    self.selectedProvince = self.province[index0];
    NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: self.areaDic[[@(index0) stringValue]]];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:tmp[self.selectedProvince]];
    NSArray *cityArray = [dic allKeys];
    NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;//递减
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;//上升
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < sortedArray.count; i++) {
        NSString *index = sortedArray[i];
        NSArray *temp = [dic[index] allKeys];
        [array addObject:temp[0]];
    }
    
    self.city = [NSArray arrayWithArray:array];
    
    NSDictionary *cityDic = dic[sortedArray[0]];
    self.district = [[NSArray alloc] initWithArray:cityDic[self.city[0]]];
    
    
    NSUInteger index1 = [self.city indexOfObject:addressArr[1]];
    NSUInteger index2 = [self.district indexOfObject:addressArr[2]];
    
    [self.pickerView selectRow:index0 inComponent:0 animated:YES];
    [self.pickerView selectRow:index1 inComponent:1 animated:YES];
    [self.pickerView selectRow:index2 inComponent:2 animated:YES];
    
}

#pragma mark --UITapGestureRecognizer Sel

-(void)dismiss
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
-(void)cancel{
    if (self.block) {
        self.block(self.pickerView, @" ",[@"0" integerValue]);
    }
    [self dismiss];
}

-(void)confirm
{
    NSInteger provinceIndex = [self.pickerView selectedRowInComponent: kComponent_0];
    NSInteger cityIndex = [self.pickerView selectedRowInComponent: kComponent_1];
    NSInteger districtIndex = [self.pickerView selectedRowInComponent: kComponent_2];
    
    NSString *provinceStr = self.province[provinceIndex];
    NSString *cityStr = self.city[cityIndex];
    NSString *districtStr = self.district[districtIndex];
    
    if ([provinceStr isEqualToString: cityStr] && [cityStr isEqualToString: districtStr]) {
        cityStr = @"";
        districtStr = @"";
    }
    else if ([cityStr isEqualToString: districtStr]) {
        districtStr = @"";
    }
    
    NSString *showMsg = [NSString stringWithFormat: @"%@%@%@%@%@", provinceStr,kString_Separate,cityStr,kString_Separate, districtStr];

    if (self.block) {
        self.block(self.pickerView, showMsg,[@"1" integerValue]);
    }
    [self dismiss];
}


#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == kComponent_0) {
        return self.province.count;
    }
    else if (component == kComponent_1) {
        return self.city.count;
    }
    else {
        return self.district.count;
    }
}

#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == kComponent_0) {
        return self.province[row];
    }
    else if (component == kComponent_1) {
        return self.city[row];
    }
    else {
        return self.district[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == kComponent_0) {
        self.selectedProvince = self.province[row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: self.areaDic[[@(row) stringValue]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:tmp[self.selectedProvince]];
        NSArray *cityArray = [dic allKeys];
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i < sortedArray.count; i++) {
            NSString *index = sortedArray[i];
            NSArray *temp = [dic[index] allKeys];
            [array addObject:temp[0]];
        }
        
        self.city = [NSArray arrayWithArray:array];
        
        NSDictionary *cityDic = dic[sortedArray[0]];
        self.district = [[NSArray alloc] initWithArray:cityDic[self.city[0]]];
        [self.pickerView selectRow: 0 inComponent: kComponent_1 animated: YES];
        [self.pickerView selectRow: 0 inComponent: kComponent_2 animated: YES];
        [self.pickerView reloadComponent: kComponent_1];
        [self.pickerView reloadComponent: kComponent_2];
        
    }
    else if (component == kComponent_1) {
        NSString *provinceIndex = [NSString stringWithFormat: @"%lu", (unsigned long)[self.province indexOfObject:self.selectedProvince]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: self.areaDic[provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: tmp[self.selectedProvince]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: dic[sortedArray[row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        
        self.district = [NSArray arrayWithArray: cityDic[cityKeyArray[0]]];
        [self.pickerView selectRow:0 inComponent: kComponent_2 animated: YES];
        [self.pickerView reloadComponent: kComponent_2];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return kScreenWidth/3.0;
    if (component == kComponent_0) {
        return 80;
    }
    else if (component == kComponent_1) {
        return 100;
    }
    else {
        return 115;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *labTitle = nil;
    labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth/3.0-10, 30)];
    labTitle.adjustsFontSizeToFitWidth = YES;
    labTitle.textAlignment = NSTextAlignmentCenter;
    labTitle.backgroundColor = UIColor.clearColor;
    labTitle.font = [UIFont systemFontOfSize:14];
    if (component == kComponent_0) {
        labTitle.text = self.province[row];
        
    }
    else if (component == kComponent_1) {
        labTitle.text = self.city[row];
        
    }
    else {
        labTitle.text = self.district[row];
        
    }
    //    labTitle.layer.borderColor = UIColor.redColor.CGColor;
    //    labTitle.layer.borderWidth = 0.5;
    return labTitle;
}

#pragma mark - - others

-(void)bindData{
    NSString *plistPath = [NSBundle.mainBundle pathForResource:@"area" ofType:@"plist"];
    if (!plistPath) plistPath = [NSBundleFromParams(self.class, @"BNView") pathForResource:@"area" ofType:@"plist"];    
    self.areaDic = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    
    NSArray *components = [self.areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [NSMutableArray array];
    for (NSInteger i = 0; i < [sortedArray count]; i++) {
        NSString *index = sortedArray[i];
        NSArray *tmp = [self.areaDic[index] allKeys];
        [provinceTmp addObject:tmp[0]];
    }
    self.province = [NSArray arrayWithArray:provinceTmp];
    
    NSString *index = sortedArray[0];
    NSString *selected = self.province[0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:self.areaDic[index][selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: dic[cityArray[0]]];
    self.city = [NSArray arrayWithArray:[cityDic allKeys]];
    
    
    NSString *selectedCity = self.city[0];
    self.district = [NSArray arrayWithArray:cityDic[selectedCity]];

    self.selectedProvince = self.province[0];

}

@end

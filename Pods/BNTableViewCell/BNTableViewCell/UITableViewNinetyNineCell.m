
//
//  UITableViewNinetyNineCell.m
//  
//
//  Created by BIN on 2018/6/22.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewNinetyNineCell.h"

#import "BNGloble.h"
#import "UIView+Helper.h"

@interface UITableViewNinetyNineCell()


@end

@implementation UITableViewNinetyNineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self createControls];
        
    }
    return self;
}

/*
- (void)createControls{
    //文字+栋舍选择+扫描
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.imgViewRight];
    
    self.textField.placeholder = @"请选择";
    self.textField.textAlignment = NSTextAlignmentCenter;

//    [self.textField addTarget:self action:@selector(handleActionSender:) forControlEvents:UIControlEventEditingDidBegin];
    self.textField.delegate = self;

    //二维码扫描
    self.imgViewRight.hidden = YES;
    self.imgViewRight.image = [UIImage imageNamed:kIMG_scan];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionTap:)];
    self.imgViewRight.userInteractionEnabled = YES;
    [self.imgViewRight addGestureRecognizer:tap];
    
    //箭头
    self.textField.rightView = [self.textField asoryView:kIMG_arrowDown];
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    self.textField.rightView.hidden = !self.imgViewRight.hidden;
}

-(void)layoutSubviews{
    [super layoutSubviews];
 
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    if (self.labelLeft.attributedText) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:CGFLOAT_MAX];
    }
    
    CGFloat XGap = kX_GAP;
    //    CGFloat YGap = kY_GAP;
    
    CGFloat textFieldH = 30;
    CGFloat lableLeftH = textFieldH;
    
    CGSize imgViewRightSize = CGSizeMake(CGRectGetHeight(self.contentView.frame) - kPadding*2, CGRectGetHeight(self.contentView.frame) - kPadding*2);
    self.imgViewRight.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width - XGap, kPadding, imgViewRightSize.width, imgViewRightSize.height);
    
    //控件1
    self.labelLeft.frame = CGRectMake(XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, labLeftSize.width, lableLeftH);
    //控件2
    self.textField.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + kPadding, CGRectGetMidY(self.contentView.frame) - textFieldH/2.0, CGRectGetMinX(self.imgViewRight.frame) - CGRectGetMaxX(self.labelLeft.frame) - kPadding*2, textFieldH);
    
    if (self.imgViewRight.hidden) {
        CGRect rect = self.textField.frame;
        rect.size.width += CGRectGetWidth(self.imgViewRight.frame) + kPadding;
        self.textField.frame = rect;
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [[[self superview] superview] endEditing:YES];
    [self handleActionSender:textField];
    return NO;
    
}

- (void)handleActionSender:(UITextField *)textField{
    [[self superview]endEditing:YES];
    
    NSParameterAssert(self.parConroller);
    
    WHKChooseAniHouseController * controller = [[WHKChooseAniHouseController alloc]init];
    [controller chooseFromVC:self.parConroller level:@1 hanlder:^(WHKNetInfoRoomModel *modelRoom, WHKNetInfoStyModel *modelSty, id obj) {
        textField.text = obj;
        if (self.block) {
            self.block(self, modelRoom, modelSty, obj);
        }
     
    }];
    controller.sex = self.sex;
    controller.filterStr = self.filterStr;
    [self.parConroller.navigationController pushViewController:controller animated:YES];
    
}

- (void)handleActionTap:(UITapGestureRecognizer *)tap{
    NSParameterAssert(self.parConroller);

    [[self superview]endEditing:YES];

    BNQRCodeScanningVC *scanningVC = [[BNQRCodeScanningVC alloc]init];
    [self.parConroller.navigationController pushViewController:scanningVC animated:YES];
    scanningVC.block = ^(NSString *string) {
        self.textField.text = string;
        if (self.block) {
            self.block(self, nil, nil, string);
        }        
    };
}

*/

#pragma mark - -layz



@end

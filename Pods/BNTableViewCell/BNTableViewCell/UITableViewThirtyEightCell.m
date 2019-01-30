//
//  UITableViewThirtyEightCell.m
//  
//
//  Created by BIN on 2017/11/13.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewThirtyEightCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+Helper.h"
#import "UIView+AddView.h"

@interface UITableViewThirtyEightCell ()

 
@end

@implementation UITableViewThirtyEightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
     ----------------------------
            文字
     BTN    图片+文字          + 文字
            图片+文字
     ----------------------------
     */
    
    //控件1
    UIButton * btn = [UIView createBtnRect:CGRectMake(0, 0, 20, 20) title:nil font:16 image:nil tag:kTAG_BTN type:@3];
    [btn addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"img_btn_unSelect.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"img_btn_selected.png"] forState:UIControlStateSelected];

    [self.contentView addSubview:btn];
    
    //控件2
    UILabel * labTitle = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL type:@2];
    labTitle.font = [UIFont systemFontOfSize:kFZ_Second];
    [self.contentView addSubview:labTitle];

    //控件3
    UILabel * labRight = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL+1 type:@2 ];
    labTitle.font = [UIFont systemFontOfSize:kFZ_Third];
    labRight.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:labRight];

    //控件4,5
    self.imgLabViewOne = [BNImgLabelView labWithImage:nil imageSize:CGSizeMake(15, 15)];
    self.imgLabViewOne.labelTitle.font = [UIFont systemFontOfSize:kFZ_Third];
    self.imgLabViewOne.labelTitle.numberOfLines = 1;
    self.imgLabViewOne.labelTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    self.imgLabViewTwo = [BNImgLabelView labWithImage:nil imageSize:CGSizeMake(15, 15)];
    self.imgLabViewTwo.labelTitle.font = [UIFont systemFontOfSize:kFZ_Third];
    self.imgLabViewTwo.labelTitle.numberOfLines = 1;
    self.imgLabViewTwo.labelTitle.lineBreakMode = NSLineBreakByTruncatingTail;

    [self.contentView addSubview:self.imgLabViewOne];
    [self.contentView addSubview:self.imgLabViewTwo];


    self.btn = btn;
    self.labTitle = labTitle;
    self.labRight = labRight;
    
}

- (void)handleActionBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.block) {
        self.block(self, sender);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    /*
     ----------------------------
     文字
     BTN    图片+文字          + 文字
     图片+文字
     ----------------------------
     */
    //控件>
    
    CGSize btnSize = CGSizeMake(20, 20);
    CGRect btnRect = CGRectMake(kX_GAP, CGRectGetMidY(self.contentView.frame) - btnSize.height/2.0, btnSize.height, btnSize.height);
    
    CGRect labelTitleRect = CGRectMake(CGRectGetMaxX(btnRect)+kPadding, kY_GAP*2, kScreenWidth - CGRectGetMaxX(btnRect) - kPadding - kX_GAP, kH_LABEL);

    CGSize textSize = [self sizeWithText:self.labRight.attributedText font:self.labRight.font width:CGFLOAT_MAX];
    CGSize labRightSize = CGSizeMake(textSize.width + kPadding, kH_LABEL_SMALL);
    CGRect labRightRect = CGRectMake(kScreenWidth - labRightSize.width -  kX_GAP, CGRectGetMaxY(labelTitleRect), labRightSize.width, labRightSize.height);
    self.labRight.frame = labRightRect;
    
    
    CGRect imgLabViewRectOne = CGRectMake(CGRectGetMinX(labelTitleRect), CGRectGetMaxY(labelTitleRect), CGRectGetMinX(labRightRect) - CGRectGetMinX(labelTitleRect), kH_LABEL_SMALL);
    CGRect imgLabViewRectTwo = CGRectMake(CGRectGetMinX(labelTitleRect), CGRectGetMaxY(imgLabViewRectOne), CGRectGetWidth(imgLabViewRectOne), kH_LABEL_SMALL);

    self.btn.frame = btnRect;
    self.labTitle.frame = labelTitleRect;
    self.labRight.frame = labRightRect;
    self.imgLabViewOne.frame = imgLabViewRectOne;
    self.imgLabViewTwo.frame = imgLabViewRectTwo;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

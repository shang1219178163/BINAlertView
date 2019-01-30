//
//  UITableViewSenventyFourCell.m
//  
//
//  Created by BIN on 2018/4/25.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewSenventyFourCell.h"

#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@implementation UITableViewSenventyFourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字(icon)+文字(icon)
    
    [self.contentView addSubview:self.labViewOne];
    [self.contentView addSubview:self.labViewTwo];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - kH_LABEL)/2.0;
    
    CGFloat padding = kPadding;
    NSInteger itemCount = 4;
    CGFloat width = (kScreenWidth - (itemCount-1)*padding - kX_GAP*2)/itemCount;
    width = floorf(width);
    
    
    self.labViewOne.frame =  CGRectMake(kX_GAP, YGap, width, kH_LABEL);
    self.labViewTwo.frame = CGRectMake(CGRectGetMaxX(self.labViewOne.frame)+padding + (width + padding), YGap, width, kH_LABEL);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(BNLabView *)labViewOne{
    if (!_labViewOne) {
        _labViewOne = ({
            BNLabView * labView = [[BNLabView alloc]initWithFrame:CGRectZero];
            labView.padding = 0.0;
            labView.type = @3;
            
            labView;
        });
    }
    return _labViewOne;
}

-(BNLabView *)labViewTwo{
    if (!_labViewTwo) {
        _labViewTwo = ({
            BNLabView * labView = [[BNLabView alloc]initWithFrame:CGRectZero];
            labView.padding = 0.0;
            labView.type = @3;
            
            labView;
        });
        
    }
    return _labViewTwo;
}

@end

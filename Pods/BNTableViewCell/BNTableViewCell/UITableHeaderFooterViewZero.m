//
//  WHKHeaderFooterViewZero.m
//  
//
//  Created by BIN on 2018/4/2.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableHeaderFooterViewZero.h"

#import "BNGloble.h"

@interface UITableHeaderFooterViewZero ()
 
@end

@implementation UITableHeaderFooterViewZero
 
//+(instancetype)viewWithTableView:(UITableView *)tableView{
//
//    NSString * identifier = NSStringFromClass([self class]);
//    WHKHeaderFooterViewOne * view = (WHKHeaderFooterViewOne *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
//    if (!view) {
//        view = [[WHKHeaderFooterViewOne alloc] initWithReuseIdentifier:identifier];
//
//        [view.layer addSublayer:[view createLayerType:@0]];
//        [view.layer addSublayer:[view createLayerType:@2]];
//
//    }
//    return view;
//}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

-(void)createControls{
    //指示器 标题     子标题
    self.contentView.backgroundColor = UIColor.whiteColor;

    [self.contentView addSubview:self.viewIndicator];
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    
    self.viewIndicator.image = [UIImage imageNamed:kIMG_arrowRight];
    
    self.labelLeftSub.textAlignment = NSTextAlignmentCenter;
    
    //添加点击手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hanleActionTapView:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.contentView addGestureRecognizer:tap];
        
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGFloat XGap = kX_GAP;
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - kH_LABEL)/2.0;
    CGFloat padding = kPadding;
    CGSize imgViewArrow = CGSizeMake(20, 20);
    
    self.viewIndicator.frame = CGRectMake(XGap, YGap, imgViewArrow.width, imgViewArrow.height);
    self.imgViewLeft.frame = CGRectMake(CGRectGetMaxX(self.viewIndicator.frame) + padding, YGap, kH_LABEL*2, kH_LABEL);
    if (!self.imgViewLeft.image) self.imgViewLeft.frame = CGRectZero;
    
    CGFloat titleGapX = CGRectGetMaxX(self.viewIndicator.frame) + CGRectGetWidth(self.imgViewLeft.frame) + padding*2;
    self.labelLeft.frame = CGRectMake(titleGapX, YGap, CGRectGetWidth(self.contentView.frame) - titleGapX - padding*2*2 - 30, kH_LABEL);
    self.labelLeftSub.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + padding*2, YGap, 30, kH_LABEL);

}

- (void)hanleActionTapView:(UITapGestureRecognizer *)tap{
    if (self.isCanOPen) {
        [UIView animateWithDuration:kDurationDrop animations:^{
            self.viewIndicator.transform = CGAffineTransformIsIdentity(self.viewIndicator.transform) ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformIdentity;
            
        }];
        
        if (self.blockView) {
            self.blockView(self, 0);
        }
    }
}

- (void)setIsOpen:(BOOL)isOpen{
    self.viewIndicator.transform = isOpen  ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformIdentity;
    
}

#pragma mark - -layz
//
//-(UIImageView *)viewIndicator{
//    if (!_viewIndicator) {
//        UIImage * imageArrow = [UIImage imageNamed:@"img_arrowRight_gray.png"];
//        _viewIndicator = [UIView createImgViewRect:CGRectZero image:imageArrow tag:kTAG_IMGVIEW type:@0];
//        _viewIndicator.contentMode = UIViewContentModeCenter;
//
//    }
//    return _viewIndicator;
//}

@end

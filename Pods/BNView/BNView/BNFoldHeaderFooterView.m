//
//  BINFoldHeaderFooterView.m
//  ChildViewControllers
//
//  Created by BIN on 2017/11/6.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import "BNFoldHeaderFooterView.h"

#import <objc/runtime.h>

#import "BNGloble.h"
#import "BNCategory.h"

@interface BNFoldHeaderFooterView ()

@property (nonatomic, strong) id image;
@property (nonatomic, strong) NSString * title;

@end

@implementation BNFoldHeaderFooterView

+(instancetype)viewWithTableView:(UITableView *)tableView section:(NSInteger)section{
    
    NSString * identifier = [NSString stringWithFormat:@"section_%@",@(section)];
    BNFoldHeaderFooterView * foldHeaderView = (BNFoldHeaderFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!foldHeaderView) {
        foldHeaderView = [[BNFoldHeaderFooterView alloc] initWithReuseIdentifier:identifier];
        
        CALayer * topLayer = [foldHeaderView createLayerType:@0];
        CALayer * bottomLayer = [foldHeaderView createLayerType:@2];
        
        [foldHeaderView.layer addSublayer:topLayer];
        [foldHeaderView.layer addSublayer:bottomLayer];
    }
    return foldHeaderView;
}

+(instancetype)viewWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    
    BNFoldHeaderFooterView * foldHeaderView = (BNFoldHeaderFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!foldHeaderView) {
        foldHeaderView = [[BNFoldHeaderFooterView alloc] initWithReuseIdentifier:identifier];
                
        CALayer * topLayer = [foldHeaderView createLayerType:@0];
        CALayer * bottomLayer = [foldHeaderView createLayerType:@2];
        
        [foldHeaderView.layer addSublayer:topLayer];
        [foldHeaderView.layer addSublayer:bottomLayer];
    }
    return foldHeaderView;
}

//+(instancetype)viewWithTableView:(UITableView *)tableView{
//
//    static NSString * identifier = @"BINFoldHeaderFooterView";
//    BINFoldHeaderFooterView * foldHeaderView = (BINFoldHeaderFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
//    if (!foldHeaderView) {
//        foldHeaderView = [[BINFoldHeaderFooterView alloc] initWithReuseIdentifier:identifier];
//
//        CALayer * topLayer = [UIView createLayerWithInView:foldHeaderView type:@0];
//        CALayer * bottomLayer = [UIView createLayerWithInView:foldHeaderView type:@2];
//
//        [foldHeaderView.layer addSublayer:topLayer];
//        [foldHeaderView.layer addSublayer:bottomLayer];
//    }
//    return foldHeaderView;
//}

//-(instancetype)initWithModel:(FoldSectionModel *)model{

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

-(void)createControls{

    [self.contentView addSubview:self.imgViewArrow];
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.labelTitleSub];
    
    //添加点击手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hanleActionTapView:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.contentView addGestureRecognizer:tap];
    
     [self.contentView getViewLayer];
}

- (void)foldViewWithTitle:(NSString *)title image:(id)image section:(NSInteger)section isOpen:(BOOL)isOpen isHeader:(BOOL)isHeader type:(NSNumber *)type{
    
    self.iscanOPen = YES;
    
    self.section = section;
    self.isOpen = isOpen;
    
    self.image = image;
    self.title = title;
    [self.contentView addSubview:self.imgViewArrow];
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.labelTitleSub];

    //添加点击手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hanleActionTapView:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.contentView addGestureRecognizer:tap];
    
     [self.contentView getViewLayer];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat XGap = kX_GAP*1.5;
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - kH_LABEL)/2.0;
    CGFloat padding = kPadding;
    CGSize imgViewArrow = CGSizeMake(20, 20);
    
    self.imgViewArrow.frame = CGRectMake(XGap, YGap, imgViewArrow.width, imgViewArrow.height);
    self.imgViewLeft.frame = CGRectMake(CGRectGetMaxX(self.imgViewArrow.frame)+padding, YGap, kH_LABEL*2, kH_LABEL);
    if (!self.image) self.imgViewLeft.frame = CGRectZero;

    CGFloat titleGapX = CGRectGetMaxX(self.imgViewArrow.frame) + CGRectGetWidth(self.imgViewLeft.frame) + padding*2;
    self.labelTitle.frame = CGRectMake(titleGapX, YGap, CGRectGetWidth(self.contentView.frame) - titleGapX*2, kH_LABEL);
    self.labelTitleSub.frame = CGRectMake(CGRectGetMaxX(self.labelTitle.frame)+padding*2, YGap, 30, kH_LABEL);

    self.imgViewArrow.contentMode = UIViewContentModeCenter;
    self.imgViewLeft.contentMode = UIViewContentModeScaleAspectFit;
    
}

- (void)hanleActionTapView:(UITapGestureRecognizer *)tap{
    if (self.iscanOPen) {
        [UIView animateWithDuration:kDurationDrop animations:^{
            self.imgViewArrow.transform = CGAffineTransformIsIdentity(self.imgViewArrow.transform) ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformIdentity;
            
        }];
        
        if ([self.delegate respondsToSelector:@selector(foldHeaderFooterView:section:)]) {
            [self.delegate foldHeaderFooterView:self section:self.section];
        }
        
        if (self.block) {
            self.block(self,self.section);
        }
    }
}

- (void)setIsOpen:(BOOL)isOpen{
    if (isOpen) {
        self.imgViewArrow.transform = CGAffineTransformMakeRotation(M_PI_2);
        
    } else {
        self.imgViewArrow.transform = CGAffineTransformIdentity;
        
    }
    
}


#pragma mark - -layz

-(UIImageView *)imgViewArrow{
    if (!_imgViewArrow) {
         UIImage * imageArrow = [UIImage imageNamed:@"img_arrowRight_gray.png"];
         _imgViewArrow = [UIView createImgViewRect:CGRectZero image:imageArrow tag:kTAG_IMGVIEW type:@0];
        
    }
    return _imgViewArrow;
}

-(UIImageView *)imgViewLeft{
    if (!_imgViewLeft) {
        _imgViewLeft = [UIView createImgViewRect:CGRectZero image:self.image tag:kTAG_IMGVIEW+1 type:@0];

    }
    return _imgViewLeft;
    
}

-(UILabel *)labelTitle{
    if (!_labelTitle) {
        _labelTitle = [UIView createLabelRect:CGRectZero text:self.title font:14 tag:kTAG_LABEL type:@0];
    }
    return _labelTitle;
}

-(UILabel *)labelTitleSub{
    if (!_labelTitleSub) {
        _labelTitleSub = [UIView createLabelRect:CGRectZero text:self.title font:14 tag:kTAG_LABEL+1 type:@0];

    }
    return _labelTitleSub;
}

@end




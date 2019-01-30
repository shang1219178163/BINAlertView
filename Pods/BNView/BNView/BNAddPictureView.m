//
//  BNAddPictureView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/28.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BNAddPictureView.h"

#import "BNAddPictureVC.h"
#import "BNGloble.h"
#import "BNCategory.h"

@interface BNAddPictureView ()

@property (nonatomic, strong) UIImage *imageDefault;
@property (nonatomic, strong) NSMutableDictionary *attDict;


@end

@implementation BNAddPictureView

-(NSMutableDictionary *)attDict{
    if (!_attDict) {
        _attDict =  @{
                      kPicture_maxCount : @4,
                      kPicture_allowCrop : @(YES),
                      kPicture_currentVC : _parController,
                      
                      }.mutableCopy;
    }
    return _attDict;
}

-(NSMutableArray *)itemList{
    if (!_itemList) {
        _itemList = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _itemList;
}

-(UIImage *)imageDefault{
    if (!_imageDefault) {
        _imageDefault = [UIImage imageNamed:kIMG_pictureDelete];
    }
    return _imageDefault;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.itemList addObject:self.imageDefault];
        [self createControls];

    }
    return self;
}

- (void)createControls{
    
    for (UIImageView * imgView in self.subviews) {
        [imgView removeFromSuperview];
    }
    CGFloat paddingX = kPadding;
    CGFloat paddingY = kPadding;
    
//    NSInteger rowCount = self.itemList.count % kRowOfNumber == 0 ? self.itemList.count/kRowOfNumber : (self.itemList.count/kRowOfNumber + 1);
    CGFloat itemWidth = (CGRectGetWidth(self.frame) - (kRowOfNumber - 1)*paddingX)/kRowOfNumber;
//    CGFloat itemHeight = (CGRectGetHeight(self.frame) - (rowCount - 1)*paddingY)/rowCount;

    CGSize itemSize = CGSizeMake(itemWidth, itemWidth);
    
    CGRect rect = CGRectZero;
    for (NSInteger i = 0; i < self.itemList.count; i++) {

        CGFloat x = (itemSize.width + paddingX) * (i % kRowOfNumber) + 0.0;
        CGFloat y = (itemSize.height + paddingY) * (i / kRowOfNumber) + 0.0;

        rect = CGRectMake(x, y, itemSize.width, itemSize.height);
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:rect];
        imgView.tag = kTAG_IMGVIEW+i;
//        imgView.image = self.itemList[i];
//        [UIView renderImgView:imgView image:self.itemList[i] imageDefault:kIMG_defaultFailed_S];
        [imgView loadImage:self.itemList[i] defaultImg:kIMG_defaultFailed_S];
//        imgView.backgroundColor = UIColor.randomColor;
        [self addSubview:imgView];
        
        UIImage * imageDelete = [UIImage imageNamed:kIMG_pictureDelete];
        
        CGSize btnSize = CGSizeMake(25, 25);
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(CGRectGetWidth(rect) - btnSize.width, 0, btnSize.width, btnSize.height);
        [btn setImage:imageDelete forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = [imgView.image isEqual:self.imageDefault] ? YES : NO;
        //    deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -10);
        [imgView addSubview:btn];
        
        //
        if (i == self.itemList.count - 1) {
            CGRect frame = self.frame;
            frame.size.height = CGRectGetMaxY(rect);
            self.frame = frame;
            //去除默认图
            NSMutableArray * marr = [NSMutableArray arrayWithArray:self.itemList];
            if ([marr containsObject:self.imageDefault]) {
                [marr removeObject:self.imageDefault];
            }
            if (self.blockView) {
                self.blockView(self, marr.copy, itemSize);

            }
        }
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionTap:)];
        imgView.userInteractionEnabled = YES;
        [imgView addGestureRecognizer:tap];

    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

-(void)handleActionTap:(UITapGestureRecognizer *)tap{
    
    UIImageView * imageView = (UIImageView *)tap.view;
    if ([imageView.image isEquelImage:kIMG_pictureDelete]) {
        
        if (self.maxCount != 0) {
            [self.attDict setObject:@(self.maxCount) forKey:kPicture_maxCount];
            
        }
        
        [[BNAddPictureVC sharedInstance]addPhotosAttDict:self.attDict handler:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSInteger maxCount) {
            [self.itemList removeAllObjects];
            [self.itemList addObjectsFromArray:photos];
            
//            NSInteger maxCount = [self.attDict[kPicture_maxCount] integerValue];
            if (self.itemList.count < maxCount && ![self.itemList containsObject:self.imageDefault]) {
                [self.itemList addObject:self.imageDefault];

            }
            [self createControls];
        }];
    }
}

- (void)handleActionBtn:(UIButton *)sender{
    UIImageView * imgView = (UIImageView *)sender.superview;
//    [self.itemList removeObject:imgView.image];
    
    [self.itemList removeObjectAtIndex:(imgView.tag - kTAG_IMGVIEW)];
//    [imgView removeFromSuperview];
    
    
    NSInteger maxCount = [self.attDict[kPicture_maxCount] integerValue];
    if (self.itemList.count < maxCount && ![self.itemList containsObject:self.imageDefault]) {
        [self.itemList addObject:self.imageDefault];
    }
    [self createControls];
}


@end

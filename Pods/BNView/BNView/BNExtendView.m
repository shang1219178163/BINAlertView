//
//  BNExtendView.m
//  BNCollectionView
//
//  Created by hsf on 2018/5/21.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNExtendView.h"

NSString * const kExtendItem_img = @"kExtendItem_img";
NSString * const kExtendItem_VC = @"kExtendItem_VC";
NSString * const kExtendKey_btn = @"kExtendKey_BTN";
NSString * const kExtendKey_rect = @"kExtendKey_rect";
NSString * const kExtendKey_rectOrigin = @"kExtendKey_rectOrigin";

@interface BNExtendView ()

@property (nonatomic, strong) UIButton * btnFront;
@property (nonatomic, strong) UIButton * btnBack;

@property (nonatomic, strong) NSMutableArray * btnList;
@property (nonatomic, assign) BOOL isOpen;

@end

@implementation BNExtendView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _padding = 15;
        
        self.btnFront.frame = self.bounds;
        self.btnBack.frame = self.bounds;

        [self addSubview:self.btnBack];
        [self addSubview:self.btnFront];

        self.direction = @3;

        self.imgList = @[@"Pinterest_round",@"Facebook_round",@"Googleplus_round",];

    }
    return self;
}

-(void)setImgList:(NSArray *)imgList{
    _imgList = imgList;
    if (!_imgList || _isLock) {
        return;
    }
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    
    CGRect rect = CGRectZero;
    for (NSInteger i = 0; i < _imgList.count; i++) {
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        btn.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), width, height);
        [btn setBackgroundImage:[UIImage imageNamed:_imgList[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(handleActionBtnSub:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        CGFloat start = 0.0;
        switch ([_direction integerValue]) {
            case 0://上
            {
                start = i == 0 ? CGRectGetMinY(self.frame) - _padding - height : CGRectGetMinY(rect) - _padding - height;
                rect = CGRectMake(CGRectGetMinX(self.frame), start, width, height);

            }
                break;
            case 1://左
            {
                start = i == 0 ? CGRectGetMinX(self.frame) - _padding - width : CGRectGetMinX(rect) - _padding - width;
                rect = CGRectMake(start, CGRectGetMinY(self.frame), width, height);
                
            }
                break;
            case 2://下
            {
                start = i == 0 ? CGRectGetMaxY(self.frame) + _padding : CGRectGetMaxY(rect) + _padding;
                rect = CGRectMake(CGRectGetMinX(self.frame), start, width, height);

            }
                break;
            case 3://右
            {
                start = i == 0 ? CGRectGetMaxX(self.frame) + _padding : CGRectGetMaxX(rect) + _padding;
                rect = CGRectMake(start, CGRectGetMinY(self.frame), width, height);

            }
                break;
            default:
            {
                start = i == 0 ? CGRectGetMaxX(self.frame) + _padding : CGRectGetMaxX(rect) + _padding;
                rect = CGRectMake(start, CGRectGetMinY(self.frame), width, height);
                
            }
                break;
        }
        
        NSMutableDictionary * dict = @{
                                kExtendKey_btn  :   btn,
                                kExtendKey_rect :   @(rect),
                                kExtendKey_rectOrigin :   @(btn.frame),
                                
                                }.mutableCopy;
        [marr addObject:dict];
    }
    self.btnList = marr;
    
}

-(void)setItemDictList:(NSArray *)itemDictList{
    
    _itemDictList = itemDictList;
    
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * dict in _itemDictList) {
        [marr addObject:dict[kExtendItem_img]];
        
    }
    self.imgList = marr;
    
}


-(void)setFrontImage:(NSString *)frontImage{
    _frontImage = frontImage;
    
    [self.btnFront setBackgroundImage:[UIImage imageNamed:_frontImage] forState:UIControlStateNormal];
}

-(void)setBackImage:(NSString *)backImage{
    _backImage = backImage;
    [self.btnBack setBackgroundImage:[UIImage imageNamed:_backImage] forState:UIControlStateNormal];
    
}

-(void)setDirection:(NSNumber *)direction{
    _direction = direction;
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    CGRect rect = CGRectZero;

    for (NSInteger i = 0; i < self.btnList.count; i++) {
        NSMutableDictionary * dict = self.btnList[i];
        
        CGFloat start = 0.0;
        switch ([_direction integerValue]) {
            case 0://上
            {
                start = i == 0 ? CGRectGetMinY(self.frame) - _padding - height : CGRectGetMinY(rect) - _padding - height;
                rect = CGRectMake(CGRectGetMinX(self.frame), start, width, height);
                
            }
                break;
            case 1://左
            {
                start = i == 0 ? CGRectGetMinX(self.frame) - _padding - width : CGRectGetMinX(rect) - _padding - width;
                rect = CGRectMake(start, CGRectGetMinY(self.frame), width, height);
                
            }
                break;
            case 2://下
            {
                start = i == 0 ? CGRectGetMaxY(self.frame) + _padding : CGRectGetMaxY(rect) + _padding;
                rect = CGRectMake(CGRectGetMinX(self.frame), start, width, height);
                
            }
                break;
            case 3://右
            {
                start = i == 0 ? CGRectGetMaxX(self.frame) + _padding : CGRectGetMaxX(rect) + _padding;
                rect = CGRectMake(start, CGRectGetMinY(self.frame), width, height);
                
            }
                break;
            default:
            {
                start = i == 0 ? CGRectGetMaxX(self.frame) + _padding : CGRectGetMaxX(rect) + _padding;
                rect = CGRectMake(start, CGRectGetMinY(self.frame), width, height);
                
            }
                break;
        }
        //重置目标数据
        [dict setObject:@(rect) forKey:kExtendKey_rect];
    }
    
}


- (void)handleActionBtn:(UIButton *)sender{
    if (!_imgList || _isLock) {
        if (self.block) {
            id obj = _itemDictList ? _itemDictList : _imgList;
            self.block(self, obj,sender);
        }
        return;
    }
    
    _isOpen = !_isOpen;
    
    UIView * fromView = _isOpen  ? self.btnFront : self.btnBack;
    UIView * toView = _isOpen  ? self.btnBack : self.btnFront;
    [self updateBtnFrameIsOpen:_isOpen];
    
    UIViewAnimationOptions options;
    switch ([_direction integerValue]) {
        case 0://上
        {
            options = _isOpen  ? UIViewAnimationOptionTransitionFlipFromTop : UIViewAnimationOptionTransitionFlipFromBottom;
            
        }
            break;
        case 1://左
        {
            options = _isOpen  ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
            
        }
            break;
        case 2://下
        {
            options = _isOpen  ? UIViewAnimationOptionTransitionFlipFromBottom : UIViewAnimationOptionTransitionFlipFromTop;
            
        }
            break;
        case 3://右
        {
            options = _isOpen  ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft;
            
        }
            break;
        default:
        {
            options = _isOpen  ? UIViewAnimationOptionTransitionFlipFromTop : UIViewAnimationOptionTransitionFlipFromBottom;
            
        }
            break;
    }
    [UIView transitionFromView:fromView toView:toView duration:0.15 options:options completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
    
}

- (void)handleActionBtnSub:(UIButton *)sender{
    [self handleActionBtn:nil];
    if (self.block) {
        id obj = _itemDictList ? _itemDictList : _imgList;
        self.block(self, obj, sender);
    }
}

- (void)updateBtnFrameIsOpen:(BOOL)isOPen{

    for (NSDictionary * dict in self.btnList) {
        UIButton * btn = dict[kExtendKey_btn];
        [UIView animateWithDuration:0.15 animations:^{
            btn.frame = isOPen  ? [dict[kExtendKey_rect] CGRectValue] : [dict[kExtendKey_rectOrigin] CGRectValue];
            [self.superview insertSubview:btn belowSubview:self];
            
        } completion:^(BOOL finished) {

        }];
    }
}

#pragma mark - -layz

-(UIButton *)btnFront{
    if (!_btnFront) {
        _btnFront = ({
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            [btn setBackgroundImage:[UIImage imageNamed:@"frontImage"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 100;
            btn;
            
        });
    }
    return _btnFront;
    
}

-(UIButton *)btnBack{
    if (!_btnBack) {
        _btnBack = ({
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            [btn setBackgroundImage:[UIImage imageNamed:@"backImage"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 101;

            btn;
            
        });
    }
    return _btnBack;
    
}


@end

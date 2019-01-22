
//
//  BN_AlertViewTwo.m
//  BN_AlertViewZero
//
//  Created by hsf on 2018/5/25.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "BN_AlertViewTwo.h"

static CGFloat kH_title = 45;
static CGFloat kRatio_ViewWidth = 0.7;

@interface BN_AlertViewTwo ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView * containView;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSMutableArray * itemList;

@end

@implementation BN_AlertViewTwo

#pragma mark - - LifeCycle

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionTap:)];
        [self addGestureRecognizer:tap];
        
       
        [self.containView addSubview:self.label];
        [self.containView addSubview:self.imgView];
        [self.containView addSubview:self.labelSub];

        self.label.text = @"请选择";
        _items = @[@"取消",@"确定",@"其他"];


    }
    return self;
}

- (void)setItems:(NSArray *)items{
    _items = items;
    
    self.itemList = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < _items.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_items[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.tag = i;
//        [btn.layer addSublayer:[btn createLayerType:@0]];
//        [btn.layer addSublayer:[btn createLayerType:@3]];
        
        UIColor * textColor = [_items[i] isEqualToString:@"取消"] ? [UIColor redColor] : UIColor.themeColor;
        [btn setTitleColor:textColor forState:UIControlStateNormal];
        
        [self.containView addSubview:btn];
        [self.itemList addObject:btn];
        [btn addActionHandler:^(id obj, id item, NSInteger idx) {
            [self dismiss];
            if (self.block) {
                self.block(self, i);
            }
            
        }];
    }
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.frame)*kRatio_ViewWidth, CGRectGetHeight(self.frame) - 60*2);
    CGFloat maxWidth = maxSize.width - kX_GAP*2;
    CGSize msgSize = [self sizeWithText:self.labelSub.text font:self.labelSub.font width:maxWidth];
    
    CGFloat height = self.label.text == nil ? 0.0 : kH_title;
    self.label.frame = CGRectMake(0, 0, maxSize.width, height);
    self.imgView.frame = CGRectMake(0, CGRectGetMaxY(self.label.frame) + kY_GAP, maxSize.width, 50);
    self.labelSub.frame = CGRectMake(kX_GAP, CGRectGetMaxY(self.imgView.frame) + kY_GAP, maxWidth, msgSize.height);
    
    
    CGRect rectItem = CGRectZero;
    for (UIButton * btn in self.itemList) {
        rectItem = CGRectMake(CGRectGetMaxX(rectItem), CGRectGetMaxY(self.labelSub.frame) + kY_GAP, maxSize.width/_items.count, kH_title);
        btn.frame = rectItem;
   
        [btn.layer addSublayer:[btn createLayerType:@0]];
        [btn.layer addSublayer:[btn createLayerType:@3]];
    }
    
    CGRect rect = self.containView.frame;
    rect.size.width = maxSize.width;
    rect.size.height = CGRectGetMaxY(rectItem);
    self.containView.frame = rect;
    
    self.containView.clipsToBounds = YES;
    self.containView.center = self.center;
}

- (void)handleActionTap:(UITapGestureRecognizer *)tap{
    return;
    [self dismiss];
    if (self.block) {
        self.block(self, 0);
    }
}

- (void)show{
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    [window addSubview:self];
    [window addSubview:self.containView];
    
    [UIView animateWithDuration:0.15f animations:^{
        self.alpha = 1;
        
    } completion:nil];
}

- (void)dismiss{
    [UIView animateWithDuration:0.15f animations:^{
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.containView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}

#pragma mark - -layz

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFit;
//            imageView.backgroundColor = [UIColor randomColor];
            
            imageView;
        });
    }
    return _imgView;
}


-(UILabel *)label{
    if (!_label) {
        _label = ({
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 30)];
            lab.font = [UIFont systemFontOfSize:16];
            lab.textColor = UIColor.whiteColor;
            lab.textAlignment = NSTextAlignmentCenter;
            
            lab.numberOfLines = 0;
            lab.userInteractionEnabled = YES;
            lab.backgroundColor = UIColor.themeColor;
            
            lab;
        });
    }
    return _label;
}

-(UILabel *)labelSub{
    if (!_labelSub) {
        _labelSub = ({
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 30)];
            lab.font = [UIFont systemFontOfSize:16];
//            lab.textColor = UIColor.whiteColor;
            lab.textAlignment = NSTextAlignmentCenter;
            
            lab.numberOfLines = 0;
            lab.userInteractionEnabled = YES;
//            lab.backgroundColor = UIColor.themeColor;
            
            lab;
        });
    }
    return _labelSub;
}

-(UIView *)containView{
    if (!_containView) {
        _containView = ({
            UIView * view = [[UIView alloc]initWithFrame:self.bounds];
            view.backgroundColor = UIColor.whiteColor;
            
            view;
        });
    }
    return _containView;
}



@end

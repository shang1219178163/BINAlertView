//
//  BINRadioView.m
//  WeiHouBao
//
//  Created by hsf on 2017/8/25.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BINRadioView.h"

static  NSString *const kObserveKeyPath = @"isSelected";

@interface BINRadioView ()

@property (nonatomic, strong) UIImageView * imageView;
//@property (nonatomic, strong) UIView * lineViewHori;
@property (nonatomic, strong) NSString * imageNomorl;
@property (nonatomic, strong) NSString * imageSelected;

//@property (nonatomic, strong) NSArray * titleArr;
//
//@property (nonatomic, strong) UIView * lineViewHori;
//
//
//@property (nonatomic, strong) NSMutableArray * labelMarr;
//@property (nonatomic, strong) NSMutableArray * lineVertMarr;

@end

@implementation BINRadioView

- (id)initWithFrame:(CGRect)frame imageNomorl:(NSString *)imageNomorl imageSelected:(NSString *)imageSelected isSelected:(BOOL)isSelected{

    self = [super initWithFrame:frame];
    if (self) {
        self.isSelected = isSelected;
        self.imageNomorl = imageNomorl;
        self.imageSelected = imageSelected;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        if (CGRectEqualToRect(frame, CGRectZero)) {
            imageView.frame = CGRectMake(0, 0, 30, 30);
        }
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;

        imageView.image = [UIImage imageNamed:imageNomorl];
        if (isSelected == YES) {
            imageView.image = [UIImage imageNamed:imageSelected];
            
        }
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        //加上这2行,本视图在cell上的时候,cell选择方法也会响应(一般用于地图界面加上东西)
        if (self.onTheMap == YES) {
            tapGesture.cancelsTouchesInView = NO;
            tapGesture.delaysTouchesEnded = NO;
        }
        [self addGestureRecognizer:tapGesture];
        
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1;
        
        
        //监听外部通过改变isSelected属性改变
        [self addObserver:self forKeyPath:kObserveKeyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    }
    return self;
    
}


- (void)tapView:(UITapGestureRecognizer *)tap{
    
    self.isSelected = !self.isSelected;
//    DDLog(@"isSelected_%@",@(self.isSelected));
    if (self.isSelected == NO) {
        self.imageView.image = [UIImage imageNamed:self.imageNomorl];
        
    }else{
        self.imageView.image = [UIImage imageNamed:self.imageSelected];
        
    }
    if (self.blockRadioView) {
        self.blockRadioView(self);
    }
    
}

- (void)actionWithBlock:(BlockRadioView)blockRadioView{
    
    self.blockRadioView = blockRadioView;
    
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context{
    
    if([keyPath isEqualToString:kObserveKeyPath])
    {
//        DDLog(@"键值%@: %@ -> %@",keyPath,change[NSKeyValueChangeOldKey],change[NSKeyValueChangeNewKey]);
        if (self.isSelected == NO) {
            self.imageView.image = [UIImage imageNamed:self.imageNomorl];
            
        }else{
            self.imageView.image = [UIImage imageNamed:self.imageSelected];
            
        }
    }
}


@end

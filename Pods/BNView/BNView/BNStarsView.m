//
//  BINStarsView.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/16.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BNStarsView.h"

#import "BNGloble.h"

@interface BNStarsView ()

@property (nonatomic, strong) NSString * starNormal;
@property (nonatomic, strong) NSString * starHighlight;

@end

@implementation BNStarsView

- (id)initWithFrame:(CGRect)frame StarCount:(NSInteger)starCount starlightedCount:(NSInteger)starlightedCount starNormal:(NSString *)starNormal starHighlight:(NSString *)starHighlight hasGesture:(BOOL)hasGesture{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.starCount = starCount;
        self.starNormal = starNormal;
        self.starHighlight = starHighlight;
        self.starMarr = [NSMutableArray arrayWithCapacity:0];
        
        UIView * backgroudView = [[UIView alloc]initWithFrame:frame];
        [self addSubview:backgroudView];
        
//        backgroudView.backgroundColor = UIColor.redColor;
        self.layer.borderColor = UIColor.blueColor.CGColor;
        self.layer.borderWidth = 1;

        self.userInteractionEnabled = YES;
        backgroudView.userInteractionEnabled = YES;
        
        CGFloat padding = 1.0;
        CGFloat imgWH = CGRectGetHeight(backgroudView.frame);

        for (NSInteger i = 0; i < starCount; i++) {
            
            UIImageView * imgViewStar = [[UIImageView alloc]initWithFrame:CGRectMake((imgWH + padding) * i, 0, imgWH, imgWH)];
//            imgViewStar.backgroundColor = UIColor.yellowColor;
            if (i < starlightedCount) {
                imgViewStar.image = [UIImage imageNamed:starHighlight];

            } else {
                imgViewStar.image = [UIImage imageNamed:starNormal];

            }
            imgViewStar.tag = kTAG_IMGVIEW + i;
            
            if(hasGesture ){
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
                tap.numberOfTapsRequired = 1;
                tap.numberOfTouchesRequired = 1;
                
                imgViewStar.userInteractionEnabled = YES;
                [imgViewStar addGestureRecognizer:tap];
                
            }
            [backgroudView addSubview:imgViewStar];
            [self.starMarr addObject:imgViewStar];
        }

    }
    return self;
}
- (void)tapView:(UITapGestureRecognizer *)recognizer{

    UIImageView * imgViewTapStar = (UIImageView *)recognizer.view;

    for (UIImageView * imgView in self.starMarr) {
        
        if (imgView.tag <= imgViewTapStar.tag) {
            imgView.image = [UIImage imageNamed:self.starHighlight];
            
        } else {
            imgView.image = [UIImage imageNamed:self.starNormal];

        }
    }

    NSInteger selectedIndex = imgViewTapStar.tag - kTAG_IMGVIEW;

    if (self.block) {
        self.block(selectedIndex);
    }
    
}

-(void)setPadding:(CGFloat)padding{
    
    CGFloat imgWH = CGRectGetHeight(self.frame);
    for (NSInteger i = 0; i< self.starMarr.count; i++) {
        UIImageView * imgViewStar = self.starMarr[i];
        imgViewStar.frame = CGRectMake((imgWH + padding) * i, 0, imgWH, imgWH);
        
    }
}

-(void)setStarlightedCount:(NSInteger)starlightedCount{
    
    for (NSInteger i = 0; i< self.starMarr.count; i++) {
        UIImageView * imgViewStar = self.starMarr[i];
        if (i < starlightedCount) {
            imgViewStar.image = [UIImage imageNamed:self.starHighlight];
            
        } else {
            imgViewStar.image = [UIImage imageNamed:self.starNormal];
            
        }
    }
}

@end

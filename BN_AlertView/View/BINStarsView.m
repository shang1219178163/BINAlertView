


//
//  BINStarsView.m
//  WeiHouBao
//
//  Created by hsf on 2017/8/16.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BINStarsView.h"

#define kTAG_IMGVIEW 300

@interface BINStarsView ()

//@property (nonatomic, strong) NSArray * titleArr;
//
//@property (nonatomic, strong) UIView * lineViewHori;
//
//@property (nonatomic, assign) CGFloat titleWidth;


@property (nonatomic, assign) NSInteger  starCount;
@property (nonatomic, strong) NSMutableArray * starMarr;

@end

@implementation BINStarsView

- (id)initWithFrame:(CGRect)frame StarCount:(NSInteger)starCount starNormal:(NSString *)starNormal starHighlight:(NSString *)starHighlight hasGesture:(BOOL)hasGesture{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.starCount = starCount;

        UIView * backgroudView = [[UIView alloc]initWithFrame:frame];
        backgroudView.backgroundColor = [UIColor greenColor];
        [self addSubview:backgroudView];

        CGFloat paddding = 5.0;
        CGFloat imgWH = (CGRectGetWidth(backgroudView.frame) - (starCount - 1) * paddding)/starCount;
        
        for (int i = 0; i < starCount; i++) {
            
            UIImageView * imgViewStar = [[UIImageView alloc]initWithFrame:CGRectMake((imgWH + paddding) * i, 0, imgWH, imgWH)];
            imgViewStar.backgroundColor = [UIColor yellowColor];
            imgViewStar.image = [UIImage imageNamed:starHighlight];
            imgViewStar.tag = kTAG_IMGVIEW + i;
            
            if(hasGesture == YES){
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
            imgView.image = [UIImage imageNamed:@"star_h.jpg"];
            
        }else{
            imgView.image = [UIImage imageNamed:@"star"];

        }
    }

    NSInteger selectedIndex = imgViewTapStar.tag - kTAG_IMGVIEW;

    if (self.blockIndex) {
        self.blockIndex(selectedIndex);
    }
    
}

-(void)actionWithBlock:(BlockSelectedIndex)selectedIndex{
    
    self.blockIndex = selectedIndex;
}


@end

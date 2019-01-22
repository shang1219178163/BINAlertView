//
//  BN_RadioView.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/25.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BN_RadioViewZero.h"

static  NSString *const kObserveKeyPath = @"isSelected";

@interface BN_RadioViewZero ()

//@property (nonatomic, strong) UIImageView * imgView;
//@property (nonatomic, strong) UILabel * label;

@property (nonatomic, strong) NSString * imgName_N;
@property (nonatomic, strong) NSString * imgName_H;

@end

@implementation BN_RadioViewZero

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"isSelected" context:nil];
    
}

- (instancetype)initWithFrame:(CGRect)frame imgName_N:(NSString *)imgName_N imgName_H:(NSString *)imgName_H{
    self = [super initWithFrame:frame];
    if (self) {
        self.imgName_N = imgName_N;
        self.imgName_H = imgName_H;
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        //加上这2行,本视图在cell上的时候,cell选择方法也会响应(一般用于地图界面加上东西)
        if (self.onTheMap) {
            tapGesture.cancelsTouchesInView = NO;
            tapGesture.delaysTouchesEnded = NO;
        }
        [self addGestureRecognizer:tapGesture];
        
        
        //监听外部通过改变isSelected属性改变
        [self addObserver:self forKeyPath:@"isSelected" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    }
    return self;
    
}

-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    
    self.image = isSelected  ? [UIImage imageNamed:self.imgName_H] : [UIImage imageNamed:self.imgName_N];

}


- (void)tapView:(UITapGestureRecognizer *)tap{
    self.isSelected = !self.isSelected;
//    DDLog(@"isSelected_%@",@(self.isSelected));
    
    if (self.block) {
        self.block(self);
    }
    
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context{
    if([keyPath isEqualToString:@"isSelected"]){
//        DDLog(@"键值%@: %@ -> %@",keyPath,change[NSKeyValueChangeOldKey],change[NSKeyValueChangeNewKey]);
        self.image = self.isSelected  ? [UIImage imageNamed:self.imgName_H] : [UIImage imageNamed:self.imgName_N];

    }
}

#pragma mark - layz

//-(UIImageView *)imgView{
//    if (!_imgView) {
//        _imgView = ({
//            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
//            imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//            imgView.contentMode = UIViewContentModeScaleAspectFit;
//            imgView.userInteractionEnabled = YES;
//
//            imgView;
//        });
//    }
//    return _imgView;
//}

//-(UILabel *)label{
//    if (!_label) {
//        _label = ({
//            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
//            label.tag = kTAG_LABEL + 4;
//            label.font = [UIFont systemFontOfSize:17];
//            label.textAlignment = NSTextAlignmentRight;
//            
//            label.numberOfLines = 0;
//            label.userInteractionEnabled = YES;
//            //        label.backgroundColor = UIColor.greenColor;
//            label;
//        });
//    }
//    return _label;
//}


@end

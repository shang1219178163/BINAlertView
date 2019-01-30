//
//  BNRefreshHeader.m
//  RefreshAnimation
//
//  Created by hsf on 2018/5/15.
//  Copyright © 2018年 CodingFire. All rights reserved.
//

#import "BNRefreshHeader.h"
#import "BNGloble.h"

#define kH_imgView  40
#define kH_refresh  60

NSString *FM_Refresh_foot_normal_title  = @"下拉刷新";
NSString *FM_Refresh_foot_pulling_title  = @"释放刷新";
NSString *FM_Refresh_foot_Refreshing_title  = @"正在刷新...";

typedef NS_ENUM(NSInteger, FMRefreshState) {
    FMRefreshStateNormal = 0,     /** 普通状态 */
    FMRefreshStatePulling,        /** 释放刷新状态 */
    FMRefreshStateRefreshing,     /** 正在刷新 */
};

@interface BNRefreshHeader ()<CAAnimationDelegate>

@property (nonatomic, strong) UIScrollView *superScrollView;
@property (nonatomic,strong) CABasicAnimation *rotationAnimation;;
@property (nonatomic,assign) FMRefreshState currentState;

@end

@implementation BNRefreshHeader

//+ (instancetype)headerBlock:(RefreshBlock)block{
//    BNRefreshHeader * view = [[self alloc]init];
//    view.block = block;
//    return view;
//    
//}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, -kH_refresh , kScreenWidth, kH_refresh);
        
        [self addSubview:self.refImgView];
        [self addSubview:self.refLabel];

    }
    return self;
}

- (void)setCurrentState:(FMRefreshState)currentState{
    _currentState = currentState;
    
    switch (_currentState) {
        case FMRefreshStateNormal:
            self.refLabel.text = FM_Refresh_foot_normal_title;
            
            break;
        case FMRefreshStatePulling:
            self.refLabel.text = FM_Refresh_foot_pulling_title;
            
            break;
        case FMRefreshStateRefreshing:
        {
            self.refLabel.text = FM_Refresh_foot_Refreshing_title;
            [UIView animateWithDuration:0.15 animations:^{
                self.superScrollView.contentInset = UIEdgeInsetsMake(kH_refresh, 0, 0, 0);
                
            }];
            
            [self.refImgView startAnimating];
            
            if (self.block) {
                self.block(self, _currentState);
            }
            
            //test by bin
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self endRefreshing];
//            });
        }
            break;
    }
}

- (void)endRefreshing{
    [self.refImgView stopAnimating];
    [UIView animateWithDuration:0.5 animations:^{
        self.superScrollView.contentInset = UIEdgeInsetsZero;
        
    }completion:^(BOOL finished) {
        
        
    }];
    
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];

    if (!self.refImgView.image) {
        self.refImgView.image = [self.refImgView.animationImages firstObject];
    }
    
    if ([newSuperview isKindOfClass:[UIScrollView class]]) {
        self.superScrollView = (UIScrollView *)newSuperview;
//        [self.superScrollView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
        [self.superScrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:NULL];
    }
}
#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (self.superScrollView.isDragging) {
            if (self.superScrollView.contentOffset.y > -kH_refresh) {
                self.currentState = FMRefreshStateNormal;
            }
            else{
                if (self.currentState == FMRefreshStateNormal) self.currentState = FMRefreshStatePulling;
                
            }
            
        } else {
            if (self.currentState == FMRefreshStatePulling) self.currentState = FMRefreshStateRefreshing;
            
        }
    }
}

#pragma mark - -layz
//
//-(UITableView *)tableView{
//    if (!_tableView) {
//        _tableView = ({
//            UITableView * table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
//            table.delegate = self;
//            table.dataSource = self;
//            table.backgroundColor = UIColor.orangeColor;
//            table.backgroundView.backgroundColor = UIColor.orangeColor;
//
//            //背景视图
//            UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
//            view.backgroundColor = UIColor.greenColor;
//            table.backgroundView = view;
//
//            table;
//        });
//    }
//    return _tableView;
//}

-(UIImageView *)refImgView{
    if (!_refImgView) {
        _refImgView = ({
            CGFloat minX = (CGRectGetWidth(self.frame) - kH_imgView - 15 - 120)/2.0;
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(minX, (kH_refresh - kH_imgView)/2.0, kH_imgView, kH_imgView)];
            
            imgView.animationDuration = 5;
            imgView.animationRepeatCount = 0;
            imgView;
        });
    }
    return _refImgView;
}

-(UILabel *)refLabel{
    if (!_refLabel) {
        _refLabel = ({
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.refImgView.frame)+15, CGRectGetMinY(self.refImgView.frame), 120, CGRectGetHeight(self.refImgView.frame))];
            label.text = FM_Refresh_foot_normal_title;
            label.font = [UIFont systemFontOfSize:16];
            label.textAlignment = NSTextAlignmentCenter;
            
            label;
        });
    }
    return _refLabel;
}



@end

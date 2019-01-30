//
//  BINGuidePageView.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/22.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BNGuideView.h"

#import "BNGloble.h"
#import "BNCategory.h"

static NSString *const kAppVersion = @"appVersion";
static NSString *const kC_NomolColor = @"PageControlNomolColor";
static NSString *const kC_CurrentColor = @"PageControlCurrentColor";

@interface BNGuideView ()<UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView  *scrollView;
@property(nonatomic, strong) UIPageControl *pageControl;

@property(nonatomic, strong) NSArray *images;
@property(nonatomic, assign) BOOL isScrollOut;//在最后一页再次滑动是否隐藏引导页

@end

@implementation BNGuideView

-(instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images isScrollOut:(BOOL)isScrollOut{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isScrollOut = isScrollOut;
        self.images = images;
        
        if ([self isFirstLauch]) {
            UIWindow *window = UIApplication.sharedApplication.windows.lastObject;
            [window addSubview:self];
            
            [self addImages];
        } else {
            [self removeFromSuperview];
            self.hidden = YES;
        }
        UIWindow *window = UIApplication.sharedApplication.windows.lastObject;
        [window addSubview:self];
        
        [self addImages];

    }
    return self;
}

#pragma mark - 判断是不是首次登录或者版本更新
-(BOOL )isFirstLauch{
    //获取当前版本号
    NSDictionary *infoDic = NSBundle.mainBundle.infoDictionary;
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    //获取上次启动应用保存的appVersion
    NSString *version = [NSUserDefaults.standardUserDefaults objectForKey:kAppVersion];
    //版本升级或首次登录
    if (!version || ![version isEqualToString:currentAppVersion]) {
        [NSUserDefaults.standardUserDefaults setObject:currentAppVersion forKey:kAppVersion];
        [NSUserDefaults.standardUserDefaults synchronize];
        return YES;
    } else {
        return NO;
    }
}
#pragma mark - 添加引导页图片
-(void)addImages{
    [self createScrollView];
}
#pragma mark - 创建滚动视图
-(void)createScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];

    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * self.images.count, CGRectGetHeight(self.scrollView.frame));
    [self addSubview:self.scrollView];
    
    for (int i = 0; i < self.images.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
        imageView.image = [UIImage imageNamed:self.images[i]];
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = YES;
        [self.scrollView addSubview:imageView];
        
        if (i == self.images.count - 1) {
            //判断要不要添加button
            if (!self.isScrollOut) {
                
                NSArray * btnTitleArr = @[@"注  册",@"登  录"];
                CGFloat btnWith = CGRectGetWidth(self.scrollView.frame)/3.0;
                CGFloat btnHeight = 30;

                CGFloat btnPadding = (CGRectGetWidth(self.scrollView.frame) - btnWith*2)/3.0;
                for (NSInteger i = 0; i < 2; i++) {
                   
                    CGRect btnRect = CGRectMake(btnPadding + (btnWith + btnPadding)*i,  CGRectGetHeight(self.scrollView.frame) * 0.8, btnWith, btnHeight);
                    
                    UIButton * btn = [UIView createBtnRect:btnRect title:btnTitleArr[i] font:16 image:nil tag:kTAG_BTN+i type:@4];
                    btn.titleLabel.font = [UIFont systemFontOfSize:kFZ_Second];
                    [imageView addSubview:btn];
                }
            }
        }
    }
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.scrollView.frame) * 0.85, CGRectGetWidth(self.scrollView.frame), 30)];
    self.pageControl.numberOfPages = self.images.count;
    self.pageControl.currentPage = 0;
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.defersCurrentPageDisplay = YES;

//    self.pageControl.currentPageIndicatorTintColor = UIColor.orangeColor;
//    self.pageControl.pageIndicatorTintColor = UIColor.greenColor;
//    self.pageControl.bounds = CGRectMake(0,0,16*(self.pageControl.numberOfPages-1)+16,16);
//    [self.pageControl setValue:[UIImage imageNamed:@"qq.png"] forKeyPath:@"_pageImage"];
//    [self.pageControl setValue:[UIImage imageNamed:@"wx.png"] forKeyPath:@"_currentPageImage"];
//
//    self.pageControl.layer.borderWidth = 3;
//    self.pageControl.layer.borderColor = UIColor.orangeColor.CGColor;
//    self.pageControl.backgroundColor = UIColor.lightGrayColor;

//    [self addSubview:self.pageControl];
}

#pragma mark - 隐藏引导页
-(void)hideGuidView{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
        
    }];
}
#pragma mark - scrollView Delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSInteger cuttentIndex = (NSInteger)(scrollView.contentOffset.x + kScreenWidth/2)/kScreenWidth;
    if (cuttentIndex == self.images.count - 1) {
        if ([self isScrolltoLeft:scrollView]) {
            if (!self.isScrollOut) {
                return ;
            }
            [self hideGuidView];
        }
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        NSInteger cuttentIndex = (NSInteger)(scrollView.contentOffset.x + kScreenWidth/2)/kScreenWidth;
        self.pageControl.currentPage = cuttentIndex;
    }
}
#pragma mark - 判断滚动方向
-(BOOL )isScrolltoLeft:(UIScrollView *)scrollView{
    //返回YES为向左反动，NO为右滚动
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
        return YES;
    } else {
        return NO;
    }
}

-(void)setNomalColor:(UIColor *)nomalColor{
    self.pageControl.pageIndicatorTintColor = nomalColor;
    
}
-(void)setCurrentColor:(UIColor *)currentColor{
    self.pageControl.currentPageIndicatorTintColor = currentColor;
    
}
#pragma mark - 进入按钮
-(void)handleAction:(UIButton *)sender{
    [self hideGuidView];
    
    if (self.block) {
        self.block(sender.tag - kTAG_BTN);
    }
}


@end

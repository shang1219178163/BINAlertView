//
//  BINPhotoBrowser.m
//  PhotoDisplay
//
//  Created by hsf on 2017/9/16.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import "BINPhotoBrowser.h"
#import "BINPhotoBrowserView.h"
#import "BINPhotoBrowserConfig.h"
#import "Utilities_DigitalMedia.h"


#define kAnimationDuration 0.35f

@implementation BINPhotoBrowser
{
    UIScrollView *_scrollView;
    BOOL _hasShowedFistView;
    UILabel *_indexLabel;
    UIButton *_saveButton;
    UIActivityIndicatorView *_indicatorView;
    UIView *_contentView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kPhotoBrowserBackgrounColor;
    }
    return self;
}

//当视图移动完成后调用
- (void)didMoveToSuperview
{
    
    [self setupScrollView];
    
    [self setupToolbars];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupToolbars
{
    // 1. 序标
    UILabel *indexLabel = [[UILabel alloc] init];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    indexLabel.textColor = [UIColor whiteColor];
    indexLabel.font = [UIFont boldSystemFontOfSize:20];
    indexLabel.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
    indexLabel.bounds = CGRectMake(0, 0, 80, 30);
    indexLabel.center = CGPointMake(kScreen_width * 0.5, 30);
    indexLabel.layer.cornerRadius = 15;
    indexLabel.clipsToBounds = YES;
    if (self.imageCount > 1) {
        indexLabel.text = [NSString stringWithFormat:@"1/%ld", (long)self.imageCount];
        _indexLabel = indexLabel;
        [self addSubview:indexLabel];
    }
    
    // 2.保存按钮
    UIButton *saveButton = [[UIButton alloc] init];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.layer.borderWidth = 0.1;
    saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
    saveButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
    saveButton.layer.cornerRadius = 2;
    saveButton.clipsToBounds = YES;
    [saveButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    _saveButton = saveButton;
    [self addSubview:saveButton];
}

#pragma mark 保存图像
- (void)saveImage
{
    int index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    
    BINPhotoBrowserView *currentView = _scrollView.subviews[index];
    
    UIImageWriteToSavedPhotosAlbum(currentView.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    indicator.center = self.center;
    _indicatorView = indicator;
    [[UIApplication sharedApplication].keyWindow addSubview:indicator];
    [indicator startAnimating];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    [_indicatorView removeFromSuperview];
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.90f];
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.bounds = CGRectMake(0, 0, 150, 40);
    label.center = self.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:20];
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:label];
    if (error) {
        label.text = kPhotoBrowserSaveImageFailText;
    }   else {
        label.text = kPhotoBrowserSaveImageSuccessText;
    }
    [label performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
}

- (void)setupScrollView
{
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    for (int i = 0; i < self.imageCount; i++) {
        BINPhotoBrowserView *view = [[BINPhotoBrowserView alloc] init];
        view.imageView.tag = i;
        view.imageView.contentMode = UIViewContentModeScaleAspectFit;

        //处理单击
        __weak __typeof(self)weakSelf = self;
        view.singleTapBlock = ^(UITapGestureRecognizer *recognizer){
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf photoClick:recognizer];
        };
        
        [_scrollView addSubview:view];
    }
    [self setupImageOfImageViewForIndex:self.currentImageIndex];
    
}

// 加载图片
- (void)setupImageOfImageViewForIndex:(NSInteger)index
{
    BINPhotoBrowserView *view = _scrollView.subviews[index];
    
    if ([self originImageForIndex:index]) {
        view.imageView.image = [self originImageForIndex:index];
        
    } else {
        view.imageView.image = [self placeholderImageForIndex:index];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    //    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.width += kPhotoBrowserImageViewMargin * 2;
    _scrollView.bounds = rect;
    //    _scrollView.center = self.center;
    _scrollView.center = CGPointMake(self.bounds.size.width *0.5, self.bounds.size.height *0.5);
    
    CGFloat y = 0;
    __block CGFloat w = _scrollView.frame.size.width - kPhotoBrowserImageViewMargin * 2;
    CGFloat h = _scrollView.frame.size.height;
    
    [_scrollView.subviews enumerateObjectsUsingBlock:^(BINPhotoBrowserView *obj, NSUInteger idx, BOOL *stop) {
        CGFloat x = kPhotoBrowserImageViewMargin + idx * (kPhotoBrowserImageViewMargin * 2 + w);
        obj.frame = CGRectMake(x, y, w, h);
    }];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.subviews.count * _scrollView.frame.size.width, _scrollView.frame.size.height);
    _scrollView.contentOffset = CGPointMake(self.currentImageIndex * _scrollView.frame.size.width, 0);
    
    
    if (!_hasShowedFistView) {
        [self showFirstImage];
    }
    
    _indexLabel.bounds = CGRectMake(0, 0, 80, 30);
    _indexLabel.center = CGPointMake(self.bounds.size.width * 0.5, 30);
    _saveButton.frame = CGRectMake(30, self.bounds.size.height - 70, 55, 30);
}

- (void)show
{
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = kPhotoBrowserBackgrounColor;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _contentView.center = window.center;
    _contentView.bounds = window.bounds;
    
    self.center = CGPointMake(_contentView.bounds.size.width * 0.5, _contentView.bounds.size.height * 0.5);
    self.bounds = CGRectMake(0, 0, _contentView.bounds.size.width, _contentView.bounds.size.height);
    
    [_contentView addSubview:self];
    
    window.windowLevel = UIWindowLevelStatusBar+10.0f;//隐藏状态栏
    
    [self performSelector:@selector(onDeviceOrientationChangeWithObserver) withObject:nil afterDelay:kPhotoBrowserShowImageAnimationDuration + 0.2];
    
    [window addSubview:_contentView];
    
    
}
- (void)onDeviceOrientationChangeWithObserver
{
    [self onDeviceOrientationChange];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void)onDeviceOrientationChange
{
    if (!shouldLandscape) {
        return;
    }
    BINPhotoBrowserView *currentView = _scrollView.subviews[self.currentImageIndex];
    [currentView.scrollView setZoomScale:1.0 animated:YES];//还原
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    if (UIDeviceOrientationIsLandscape(orientation)) {
        //        NSLog(@"onDeviceOrientationChange");
        [UIView animateWithDuration:kAnimationDuration delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [[UIApplication sharedApplication] setStatusBarOrientation:(UIInterfaceOrientation)orientation];
            self.transform = (orientation==UIDeviceOrientationLandscapeRight)?CGAffineTransformMakeRotation(M_PI*1.5):CGAffineTransformMakeRotation(M_PI/2);
            self.bounds = CGRectMake(0, 0, screenBounds.size.height, screenBounds.size.width);
            [self setNeedsLayout];
            [self layoutIfNeeded];
        } completion:nil];
    }else if (orientation==UIDeviceOrientationPortrait){
        [UIView animateWithDuration:kAnimationDuration delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [[UIApplication sharedApplication] setStatusBarOrientation:(UIInterfaceOrientation)orientation];
            self.transform = (orientation==UIDeviceOrientationPortrait)?CGAffineTransformIdentity:CGAffineTransformMakeRotation(M_PI);
            self.bounds = screenBounds;
            [self setNeedsLayout];
            [self layoutIfNeeded];
        } completion:nil];
    }
}

- (void)showFirstImage
{
    UIView *sourceView = self.sourceImagesContainerView.subviews[self.currentImageIndex];
    
    CGRect rect = [self.sourceImagesContainerView convertRect:sourceView.frame toView:self];
    NSLog(@"rect_%@",NSStringFromCGRect(rect));//小图位置
    
    UIImageView *tempView = [[UIImageView alloc] init];
    tempView.frame = rect;
//    tempView.image = [self placeholderImageForIndex:self.currentImageIndex];
    tempView.image = [self originImageForIndex:self.currentImageIndex];//本地高清图片,不用进行网络请求,

    [self addSubview:tempView];
    tempView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    CGFloat placeImageSizeW = tempView.image.size.width;
    CGFloat placeImageSizeH = tempView.image.size.height;
    CGRect targetTemp;
    
    CGFloat placeHolderH = (placeImageSizeH * kScreen_width)/placeImageSizeW;
    if (placeHolderH <= kScreen_height) {
        targetTemp = CGRectMake(0, (kScreen_height - placeHolderH) * 0.5 , kScreen_width, placeHolderH);
    } else {//图片高度>屏幕高度
        targetTemp = CGRectMake(0, 0, kScreen_width, placeHolderH);
    }
    
    //先隐藏scrollview
    _scrollView.hidden = YES;
    _indexLabel.hidden = YES;
    _saveButton.hidden = YES;
    
    [UIView animateWithDuration:kPhotoBrowserShowImageAnimationDuration animations:^{
        //将点击的临时imageview动画放大到和目标imageview一样大
        tempView.frame = targetTemp;
    } completion:^(BOOL finished) {
        //动画完成后，删除临时imageview，让目标imageview显示
        _hasShowedFistView = YES;
        [tempView removeFromSuperview];
        _scrollView.hidden = NO;
        _indexLabel.hidden = NO;
        _saveButton.hidden = NO;
    }];
}

- (UIImage *)placeholderImageForIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(photoBrowser:placeholderImageForIndex:)]) {
        return [self.delegate photoBrowser:self placeholderImageForIndex:index];
    }
    return nil;
}

- (UIImage *)originImageForIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(photoBrowser:originImageForIndex:)]) {
        return [self.delegate photoBrowser:self originImageForIndex:index];
    }
    return nil;
}

#pragma mark - scrollview代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int index = (scrollView.contentOffset.x + _scrollView.bounds.size.width * 0.5) / _scrollView.bounds.size.width;
    //    int imageIndex = (scrollView.contentOffset.x + _scrollView.bounds.size.width * 0.9) / _scrollView.bounds.size.width;
    //    if (imageIndex >= self.imageCount - 1) {
    //        imageIndex = (int)self.imageCount - 1;
    //    }
    //    if (imageIndex <= 0) {
    //        imageIndex= 0;
    //    }
    _indexLabel.text = [NSString stringWithFormat:@"%d/%ld", index + 1, (long)self.imageCount];
    //    NSLog(@"%i",imageIndex);
    long left = index - 1;
    long right = index + 1;
    left = left>0?left : 0;
    right = right>self.imageCount?self.imageCount:right;
    
    for (long i = left; i < right; i++) {
        [self setupImageOfImageViewForIndex:i];
    }
    
    //    [self setupImageOfImageViewForIndex:imageIndex];
}

//scrollview结束滚动调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int autualIndex = scrollView.contentOffset.x  / _scrollView.bounds.size.width;
    //设置当前下标
    self.currentImageIndex = autualIndex;
    //将不是当前imageview的缩放全部还原 (这个方法有些冗余，后期可以改进)
    for (BINPhotoBrowserView *view in _scrollView.subviews) {
        if (view.imageView.tag != autualIndex) {
            view.scrollView.zoomScale = 1.0;
        }
    }
}

#pragma mark - tap
#pragma mark 双击
- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer
{
    BINPhotoBrowserView *view = (BINPhotoBrowserView *)recognizer.view;
    CGPoint touchPoint = [recognizer locationInView:self];
    if (view.scrollView.zoomScale <= 1.0) {
        
        CGFloat scaleX = touchPoint.x + view.scrollView.contentOffset.x;//需要放大的图片的X点
        CGFloat sacleY = touchPoint.y + view.scrollView.contentOffset.y;//需要放大的图片的Y点
        [view.scrollView zoomToRect:CGRectMake(scaleX, sacleY, 10, 10) animated:YES];
        
    } else {
        [view.scrollView setZoomScale:1.0 animated:YES]; //还原
    }
    
}

#pragma mark 单击
- (void)photoClick:(UITapGestureRecognizer *)recognizer
{
    BINPhotoBrowserView *currentView = _scrollView.subviews[self.currentImageIndex];
    [currentView.scrollView setZoomScale:1.0 animated:YES];//还原
    _indexLabel.hidden = YES;
    _saveButton.hidden = YES;
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    if (UIDeviceOrientationIsLandscape(orientation)) {
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [[UIApplication sharedApplication] setStatusBarOrientation:(UIInterfaceOrientation)UIDeviceOrientationPortrait];
            self.transform = CGAffineTransformIdentity;
            self.bounds = CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height);
            [self setNeedsLayout];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self hidePhotoBrowser:recognizer];
        }];
    } else {
        [self hidePhotoBrowser:recognizer];
    }
    //恢复缩略图
    BINPhotoBrowserView *view = (BINPhotoBrowserView *)recognizer.view;
    view.imageView.image = [self placeholderImageForIndex:self.currentImageIndex];
    
}

- (void)hidePhotoBrowser:(UITapGestureRecognizer *)recognizer
{
    BINPhotoBrowserView *view = (BINPhotoBrowserView *)recognizer.view;
    UIImageView *currentImageView = view.imageView;
    NSUInteger currentIndex = currentImageView.tag;
    UIView *sourceView = self.sourceImagesContainerView.subviews[currentIndex];
    CGRect targetTemp = [self.sourceImagesContainerView convertRect:sourceView.frame toView:self];
    
    //    NSLog(@"%@",NSStringFromCGRect(targetTemp));
    
    UIImageView *tempImageView = [[UIImageView alloc] init];
    tempImageView.image = currentImageView.image;
    CGFloat tempImageSizeH = tempImageView.image.size.height;
    CGFloat tempImageSizeW = tempImageView.image.size.width;
    CGFloat tempImageViewH = (tempImageSizeH * kScreen_width)/tempImageSizeW;
    
    if (tempImageViewH < kScreen_height) {//图片高度<屏幕高度
        tempImageView.frame = CGRectMake(0, (kScreen_height - tempImageViewH)*0.5, kScreen_width, tempImageViewH);
    } else {
        tempImageView.frame = CGRectMake(0, 0, kScreen_width, tempImageViewH);
    }
    [self addSubview:tempImageView];
    
    _saveButton.hidden = YES;
    _indexLabel.hidden = YES;
    _scrollView.hidden = YES;
    self.backgroundColor = [UIColor clearColor];
    _contentView.backgroundColor = [UIColor clearColor];
    self.window.windowLevel = UIWindowLevelNormal;//显示状态栏
    [UIView animateWithDuration:kPhotoBrowserHideImageAnimationDuration animations:^{
        tempImageView.frame = targetTemp;
    } completion:^(BOOL finished) {
        [_contentView removeFromSuperview];
        [tempImageView removeFromSuperview];
    }];
}


@end

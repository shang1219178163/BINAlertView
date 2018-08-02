//
//  BINPhotoGroup.m
//  PhotoDisplay
//
//  Created by hsf on 2017/9/16.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import "BINPhotoGroup.h"

@interface BINPhotoGroup ()<BINPhotoBrowserDelegate>

@property (nonatomic, copy) NSString * patternType;//0:url,1:image

@end

@implementation BINPhotoGroup

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}


- (void)setPhotoItemArray:(NSArray *)photoItemArray
{
    _photoItemArray = photoItemArray;
    [photoItemArray enumerateObjectsUsingBlock:^(BINPhotoItem *obj, NSUInteger idx, BOOL *stop) {
        
        UIImageView * imgView = [self createImgViewWithRect:CGRectZero image:[UIImage imageNamed:@"whiteplaceholder"] tag:idx hasTapGesture:YES];
        if (obj.originImage) {
            UIImage * thumbnailImage = [Utilities_DigitalMedia thumbnailWithImageWithoutScale:obj.originImage size:kThumbnailImageSize];
            imgView.image = thumbnailImage;
//            NSLog(@"setPhotoItemArray_%@",imgView.image);
        }
        [self addSubview:imgView];
        
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger imageCount = self.photoItemArray.count;
    NSInteger perRowImageCount = ((imageCount == 4) ? 2 : 3);
    perRowImageCount = 4;
    CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
    NSInteger totalRowCount = ceil(imageCount / perRowImageCountF); // ((imageCount + perRowImageCount - 1) / perRowImageCount)
    CGFloat w = 80;
    CGFloat h = 80;
    
    if (!CGSizeEqualToSize(self.photoItemSize, CGSizeZero)) {
        w = self.photoItemSize.width;
        h = self.photoItemSize.height;
        
    }
    
    CGFloat padding = (CGRectGetWidth(self.frame) - w * perRowImageCount) / (perRowImageCount - 1);
    
    [self.subviews enumerateObjectsUsingBlock:^(UIImageView *imgView, NSUInteger idx, BOOL *stop) {
        
        long rowIndex = idx / perRowImageCount;
        NSInteger columnIndex = idx % perRowImageCount;
        CGFloat x = columnIndex * (w + padding);
        CGFloat y = rowIndex * (h + padding);
        imgView.frame = CGRectMake(x, y, w, h);
        
//        UIImage * imagee = [self.photoItemArray[idx] originImage];
//        imgView.image = [Utilities_DigitalMedia thumbnailWithImageWithoutScale:imagee size:CGSizeMake(150, 150)];;
        
    }];
    
    CGRect rect = self.frame;
    rect.size.width = w * perRowImageCount + padding * (perRowImageCount - 1);
//    rect.size.height = totalRowCount * (padding + h);
    rect.size.height = h * totalRowCount + padding * (totalRowCount - 1) ;

    self.frame = rect;
}

#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(BINPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    //    return [self.subviews[index] currentImage];
    UIImage *originImage = [self.photoItemArray[index] originImage];
    return [Utilities_DigitalMedia thumbnailWithImageWithoutScale:originImage size:kThumbnailImageSize];
}


// 返回高质量图片
- (UIImage *)photoBrowser:(BINPhotoBrowser *)browser originImageForIndex:(NSInteger)index
{
    UIImage *originImage = [self.photoItemArray[index] originImage];
    return originImage;
}


//添加图片
- (UIImageView *)createImgViewWithRect:(CGRect)rect image:(UIImage *)image tag:(NSInteger)tag hasTapGesture:(BOOL)hasTapGesture
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setImage:image];
    imageView.tag = tag;
    if (hasTapGesture == YES) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goTapView:)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
    }
    imageView.backgroundColor = [UIColor redColor];
    return imageView;
}

- (void)goTapView:(UITapGestureRecognizer *)recognizer
{
    UIImageView * imgView = (UIImageView *)recognizer.view;
    imgView.image = [self.photoItemArray[imgView.tag] originImage];
    
    //启动图片浏览器
    BINPhotoBrowser *browser = [[BINPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.imageCount = self.photoItemArray.count; // 图片总数
    browser.currentImageIndex = recognizer.view.tag;
    browser.delegate = self;
    [browser show];
    
}

@end

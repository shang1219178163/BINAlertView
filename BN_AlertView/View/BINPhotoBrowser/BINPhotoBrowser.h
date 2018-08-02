//
//  BINPhotoBrowser.h
//  PhotoDisplay
//
//  Created by hsf on 2017/9/16.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  BINPhotoBrowser;

@protocol BINPhotoBrowserDelegate <NSObject>

- (UIImage *)photoBrowser:(BINPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;

- (UIImage *)photoBrowser:(BINPhotoBrowser *)browser originImageForIndex:(NSInteger)index;

@end

@interface BINPhotoBrowser : UIView<UIScrollViewDelegate>

@property (nonatomic, weak) UIView *sourceImagesContainerView;
@property (nonatomic, assign) NSInteger currentImageIndex;
@property (nonatomic, assign) NSInteger imageCount;

@property (nonatomic, weak) id<BINPhotoBrowserDelegate> delegate;

- (void)show;

@end

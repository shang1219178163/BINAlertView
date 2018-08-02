//
//  BINPhotoBrowserView.h
//  PhotoDisplay
//
//  Created by hsf on 2017/9/16.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BINPhotoBrowserView : UIView

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *imageView;

//单击回调
@property (nonatomic, strong) void (^singleTapBlock)(UITapGestureRecognizer *recognizer);

@end

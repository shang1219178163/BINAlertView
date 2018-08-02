//
//  BINPhotoBrowserConfig.h
//  PhotoDisplay
//
//  Created by hsf on 2017/9/16.
//  Copyright © 2017年 BIN. All rights reserved.
//

#ifndef BINPhotoBrowserConfig_h
#define BINPhotoBrowserConfig_h


typedef enum {
    BINWaitingViewModeLoopDiagram, // 环形
    BINWaitingViewModePieDiagram // 饼型
} BINWaitingViewMode;

#define kMinZoomScale 0.6f
#define kMaxZoomScale 2.0f

#define kThumbnailImageSize  CGSizeMake(150, 150)

#define kIsFullWidthForLandScape YES //是否在横屏的时候直接满宽度，而不是满高度，一般是在有长图需求的时候设置为YES

//是否支持横屏
#define shouldLandscape YES

// 图片保存成功提示文字
#define kPhotoBrowserSaveImageSuccessText @" 保存成功 ";

// 图片保存失败提示文字
#define kPhotoBrowserSaveImageFailText @" 保存失败 ";

// browser背景颜色
#define kPhotoBrowserBackgrounColor [UIColor colorWithRed:0 green:0 blue:0 alpha:1]

// browser中图片间的margin
#define kPhotoBrowserImageViewMargin 10

// browser中显示图片动画时长
#define kPhotoBrowserShowImageAnimationDuration 0.35f
// browser中隐藏图片动画时长
#define kPhotoBrowserHideImageAnimationDuration 0.35f


#endif /* BINPhotoBrowserConfig_h */

//
//  HMSegmentedControl.h
//  HMSegmentedControl
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BN_IndicatorSizeMode) {
    BN_IndicatorSizeToString = 0,
    BN_IndicatorSizeToFill = 1
    
};

typedef NS_ENUM(NSInteger,BN_IndicatorMode) {
    BN_IndicatorDefault = 0,
    BN_IndicatorBox = 1
    
};

typedef NS_ENUM(NSInteger, BN_ControlType) {
    BN_ControlTypeText,
    BN_ControlTypeImage,
    BN_ControlTypeTextImage
};

typedef NS_ENUM(NSInteger, BN_ImgType) {
    BN_ImgTypeLeft,
    BN_ImgTypeRight,
};

@interface BN_SegmentControl : UIControl

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *selectedImages;

@property (nonatomic, strong) UIFont *font; // default is [UIFont fontWithName:@"Avenir-Light" size:19.0f]
@property (nonatomic, strong) UIColor *textColor; // default is [UIColor blackColor]
@property (nonatomic, strong) UIColor *textColor_H;
@property (nonatomic, strong) UIColor *backgroundColor; // default is [UIColor whiteColor]
@property (nonatomic, strong) UIColor *indicatorColor; // default is 52, 181, 229

@property (nonatomic, assign) BN_ControlType type;
@property (nonatomic, assign) BN_ImgType iconMode;//only  BN_ControlTypeTextImages


@property (nonatomic, assign) BN_IndicatorSizeMode indicatorSizeMode;
@property (nonatomic, assign) BN_IndicatorMode indicatorMode;

@property (nonatomic, assign) BOOL isIndicatorTop;
@property (nonatomic, assign) BOOL isScroll;

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat height; // default is 32.0
@property (nonatomic, assign) CGFloat h_indicator; // default is 5.0
@property (nonatomic, assign) UIEdgeInsets segmentEdgeInset; // default is UIEdgeInsetsMake(0, 5, 0, 5)
@property (nonatomic, assign) CGSize imgSize; // default is 32.0

@property (nonatomic, copy) void (^block)(BN_SegmentControl * view,NSUInteger index); // you can also use addTarget:action:forControlEvents:

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
//

@end

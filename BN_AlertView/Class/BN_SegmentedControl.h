//
//  HMSegmentedControl.h
//  HMSegmentedControl
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import <UIKit/UIKit.h>

enum BN_IndicatorMode {
    BN_IndicatorSizeToString = 0, // Indicator width will only be as big as the text width
    BN_IndicatorFillsSegment = 1, // Indicator width will fill the whole segment
    
};

@interface BN_SegmentedControl : UIControl

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, strong) UIFont *font; // default is [UIFont fontWithName:@"Avenir-Light" size:19.0f]
@property (nonatomic, strong) UIColor *textColor; // default is [UIColor blackColor]
@property (nonatomic, strong) UIColor *backgroundColor; // default is [UIColor whiteColor]
@property (nonatomic, strong) UIColor *indicatorColor; // default is 52, 181, 229
@property (nonatomic, assign) enum BN_IndicatorMode indicatorMode; // Default is HMSelectionIndicatorResizesToStringWidth

@property (nonatomic, assign) BOOL isIndicatorTop;

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat height; // default is 32.0
@property (nonatomic, assign) CGFloat h_indicator; // default is 5.0
@property (nonatomic, assign) UIEdgeInsets segmentEdgeInset; // default is UIEdgeInsetsMake(0, 5, 0, 5)

@property (nonatomic, copy) void (^block)(BN_SegmentedControl * view,NSUInteger index); // you can also use addTarget:action:forControlEvents:

- (id)initWithSectionTitles:(NSArray *)sectiontitles;
- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
//

@end

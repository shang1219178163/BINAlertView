//
//  BN_SegmentedControl.m
//  BN_SegmentedControl
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import "BN_SegmentedControl.h"
#import <QuartzCore/QuartzCore.h>

#import "CATextLayer+Helper.h"

@interface BN_SegmentedControl ()

@property (nonatomic, strong) CALayer *segmentLayer;

@property (nonatomic, readwrite) CGFloat w_item;

@property (nonatomic, readwrite) NSMutableParagraphStyle *paragraphStyle;

@property (nonatomic, readwrite) NSMutableDictionary *attDic;
@property (nonatomic, readwrite) NSMutableArray *itemList;

@end

@implementation BN_SegmentedControl

-(NSMutableArray *)itemList{
    if (!_itemList) {
        _itemList = [NSMutableArray array];
    }
    return _itemList;
}

-(NSMutableDictionary *)attDic{
    if (!_attDic) {
        _attDic = [NSMutableDictionary dictionary];
    }
    [_attDic setObject:self.textColor forKey:NSForegroundColorAttributeName];
    [_attDic setObject:self.font forKey:NSFontAttributeName];
    [_attDic setObject:self.paragraphStyle forKey:NSParagraphStyleAttributeName];

    return _attDic;
}

-(NSMutableParagraphStyle *)paragraphStyle{
    if (!_paragraphStyle) {
        _paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        _paragraphStyle.lineBreakMode = NSLineBreakByClipping;
        _paragraphStyle.alignment = NSTextAlignmentCenter;
 
    }
    return _paragraphStyle;
}


-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
    __block NSMutableArray * marr = @[].mutableCopy;
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:kItemTitle])
            [marr addObject:obj];
        
    }];
    self.list = marr.copy;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
        
    }
    return self;
}


- (void)setDefaults {
    
    self.indicatorMode = BN_IndicatorDefault;
    
    self.height = 32.0f;
    self.h_indicator = 5.0f;
    
    self.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18.0f];

    self.textColor = UIColor.blackColor;
    self.backgroundColor = UIColor.whiteColor;
    self.indicatorColor = [UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:1.0f];
    
    self.selectedIndex = 0;
    self.segmentEdgeInset = UIEdgeInsetsMake(0, 5, 0, 5);

    self.indicatorSizeMode = BN_IndicatorSizeToString;
    
    self.segmentLayer = CALayer.layer;

}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect{
    [self.backgroundColor set];
    UIRectFill(self.bounds);
    
    [self.textColor set];
    
    [self.list enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
        CGSize textSize = [obj sizeWithAttributes:self.attDic];
        CGFloat h_text = ceilf(textSize.height);
        
        CGFloat y = (self.height - h_text)/2.0;
        CGRect rect = CGRectMake(self.w_item * idx, y, self.w_item, h_text);
        //        NSLog(@"!!!rect:%@",NSStringFromCGRect(rect));
//        [obj drawInRect:rect withAttributes:_attDic];

        CATextLayer *titleLayer = [CATextLayer createRect:rect string:obj font:self.font textColor:self.textColor alignmentMode:kCAAlignmentCenter];
        [self.layer addSublayer:titleLayer];
        
        [self.itemList addObject:titleLayer];
        
        self.segmentLayer.frame = [self updateFrameForIndicator];
        self.segmentLayer.backgroundColor = self.indicatorColor.CGColor;
        [self.layer addSublayer:self.segmentLayer];
        
    }];
}

- (CGRect)updateFrameForIndicator {
    
    if (self.indicatorMode == BN_IndicatorBox) {
        self.segmentLayer.opacity = 0.3;
        if (self.indicatorSizeMode == BN_IndicatorSizeToFill) {
            return CGRectMake(self.w_item * self.selectedIndex, 0, self.w_item, self.height);
            
        }
        
        CGFloat w_text = [self.list[self.selectedIndex] sizeWithAttributes:self.attDic].width;
        
        CGFloat widthEndOfIndex = self.w_item * (self.selectedIndex + 1);
        CGFloat widthBeforeIndex = self.w_item * self.selectedIndex;
        
        CGFloat x = (widthEndOfIndex - widthBeforeIndex)/2 + (widthBeforeIndex - w_text/2);
        return CGRectMake(x, 0, w_text, self.height);
        
    }
    
    CGFloat y = self.isIndicatorTop == YES ? 0.0 : self.height - self.h_indicator;
    if (self.indicatorSizeMode == BN_IndicatorSizeToFill) {
        return CGRectMake(self.w_item * self.selectedIndex, 0, self.w_item, self.height);

    }
    
    CGFloat w_text = [self.list[self.selectedIndex] sizeWithAttributes:self.attDic].width;

    CGFloat widthEndOfIndex = self.w_item * (self.selectedIndex + 1);
    CGFloat widthBeforeIndex = self.w_item * self.selectedIndex;
    
    CGFloat x = (widthEndOfIndex - widthBeforeIndex)/2 + (widthBeforeIndex - w_text/2);

    return CGRectMake(x, y, w_text, self.h_indicator);
    
}

- (void)updateFrameForSegmentView {
    // If there's no frame set, calculate the width of the control based on the number of segments and their size
    if (!CGRectIsEmpty(self.frame)) {
        self.w_item = self.frame.size.width / self.list.count;
        self.height = self.frame.size.height;
        return;
    }
    
    self.w_item = 0.0;
    
    for (NSString *obj in self.list) {
        CGFloat width = [obj sizeWithAttributes:self.attDic].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
        self.w_item = MAX(width, self.w_item);
    }
    
    self.bounds = CGRectMake(0, 0, self.w_item * self.list.count, self.height);
  
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    // Control is being removed
    if (newSuperview == nil)
        return;
    
    [self updateFrameForSegmentView];
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.bounds, touchLocation)) {
        NSInteger segment = touchLocation.x / self.w_item;
        
        [self.itemList enumerateObjectsUsingBlock:^(CATextLayer *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIColor * color = segment == idx ? self.textColor_H : self.textColor;
            [self.itemList[idx] setForegroundColor:color.CGColor];
            
        }];

        if (segment != self.selectedIndex) {
            [self setSelectedIndex:segment animated:YES];
        }
    }
}

#pragma mark - set

- (void)setSelectedIndex:(NSInteger)index {
    [self setSelectedIndex:index animated:NO];
    
}

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated {
    _selectedIndex = index;

    if (animated) {
        // Restore CALayer animations
        self.segmentLayer.actions = nil;
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.5f];
        [CATransaction setCompletionBlock:^{

            if (self.superview)
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            
            if (self.block)
                self.block(self,index);
        }];
        self.segmentLayer.frame = [self updateFrameForIndicator];
        [CATransaction commit];
    } else {
        // Disable CALayer animations
        NSDictionary * actionDic = @{
                                     @"position" : NSNull.null,
                                     @"bounds"  :   NSNull.null,
                                     
                                     };
        self.segmentLayer.actions = actionDic;
        self.segmentLayer.frame = [self updateFrameForIndicator];
        
        if (self.superview)
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        
        if (self.block)
            self.block(self,index);

    }    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (self.list) [self updateFrameForSegmentView];
    [self setNeedsDisplay];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    if (self.list) [self updateFrameForSegmentView];
    [self setNeedsDisplay];
}

@end

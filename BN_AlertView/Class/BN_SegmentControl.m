//
//  BN_SegmentControl.m
//  BN_SegmentControl
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import "BN_SegmentControl.h"
#import <QuartzCore/QuartzCore.h>

#import "CALayer+Helper.h"
#import "CATextLayer+Helper.h"
#import "CATransaction+Helper.h"

@interface HMScrollView : UIScrollView
@end

@interface BN_SegmentControl ()<UIScrollViewDelegate>

@property (nonatomic, strong) CALayer *indicatorLayer;

@property (nonatomic, assign) CGFloat w_item;
@property (nonatomic, assign) CGFloat h_itemImage;

@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;

@property (nonatomic, strong) NSMutableDictionary *attDic;
@property (nonatomic, strong) NSMutableArray *itemList;
@property (nonatomic, strong) NSMutableArray *itemListOne;

@property (nonatomic, strong) HMScrollView *scrollView;

@end



@implementation HMScrollView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.dragging) {
        [self.nextResponder touchesBegan:touches withEvent:event];
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.dragging) {
        [self.nextResponder touchesMoved:touches withEvent:event];
    } else{
        [super touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.dragging) {
        [self.nextResponder touchesEnded:touches withEvent:event];
    } else {
        [super touchesEnded:touches withEvent:event];
    }
}

@end


@implementation BN_SegmentControl


-(HMScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = ({
            HMScrollView * view = [[HMScrollView alloc] initWithFrame:self.bounds];
//            view.contentSize = CGSizeMake(_mViewFrame.size.width * _tabCount, _mViewFrame.size.height - 60);
            view.backgroundColor = UIColor.whiteColor;
//            view.pagingEnabled = YES;
            
            view.scrollsToTop = NO;
            view.showsVerticalScrollIndicator = NO;
            view.showsHorizontalScrollIndicator = NO;
            
            view;
        });
    }
    return _scrollView;
}

-(NSMutableArray *)itemListOne{
    if (!_itemListOne) {
        _itemListOne = [NSMutableArray array];
    }
    return _itemListOne;
}

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


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
        
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setDefaults];
        
    }
    return self;
    
}

- (void)setDefaults {
    [self addSubview:self.scrollView];

    self.type = BN_ControlTypeText;
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
    
    self.indicatorLayer = CALayer.layer;

    self.imgSize = CGSizeMake(CGRectGetHeight(self.frame) - self.h_indicator*2, CGRectGetHeight(self.frame) - self.h_indicator*2);

}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect{
    self.scrollView.frame = self.bounds;
    
    [self.backgroundColor set];
    UIRectFill(self.bounds);
    
    [self.textColor set];
    
    [self.itemList removeAllObjects];
    switch (self.type) {
        case BN_ControlTypeText:
        {
            [self.titles enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
                CGSize textSize = [obj sizeWithAttributes:self.attDic];
                CGFloat h_text = ceilf(textSize.height);
                
                CGFloat y = (self.height - h_text)/2.0;
                CGRect rect = CGRectMake(self.w_item * idx, y, self.w_item, h_text);
                //        NSLog(@"!!!rect:%@",NSStringFromCGRect(rect));
                //        [obj drawInRect:rect withAttributes:_attDic];
                
                CATextLayer *titleLayer = [CATextLayer createRect:rect string:obj font:self.font textColor:self.textColor alignmentMode:kCAAlignmentCenter];
                [self.scrollView.layer addSublayer:titleLayer];
                
                [self.itemList addObject:titleLayer];
                
                self.indicatorLayer.frame = [self updateFrameForIndicator];
                self.indicatorLayer.backgroundColor = self.indicatorColor.CGColor;
                [self.scrollView.layer addSublayer:self.indicatorLayer];
                
            }];
        }
            break;
        case BN_ControlTypeImage:
        {
            [self.images enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
               
                CGRect rect = CGRectMake(self.w_item*idx, self.h_indicator, self.w_item, CGRectGetHeight(self.bounds) - self.h_indicator*2);
                
                if (idx == 0 && [self.selectedImages firstObject] != nil) {
                    obj = [self.selectedImages firstObject];
                }
                CALayer *imgLayer = [CALayer createRect:rect image:obj];
                [self.scrollView.layer addSublayer:imgLayer];
                
                [self.itemList addObject:imgLayer];
                
                self.indicatorLayer.frame = [self updateFrameForIndicator];
                self.indicatorLayer.backgroundColor = self.indicatorColor.CGColor;
                [self.scrollView.layer addSublayer:self.indicatorLayer];
                
            }];
        }
            break;
        case BN_ControlTypeTextImage:
        {
            [self.itemListOne removeAllObjects];
            [self.titles enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
                
                
                CGSize textSize = [obj sizeWithAttributes:self.attDic];
                CGFloat h_text = ceilf(textSize.height);
                
                CGFloat y = (self.height - h_text)/2.0;
                CGRect rect = CGRectMake(self.w_item * idx, y, self.w_item, h_text);
                rect = [self rectWithIndex:idx textSize:textSize isImg:NO];
                CGRect rectImg = [self rectWithIndex:idx textSize:textSize isImg:YES];

                CATextLayer *titleLayer = [CATextLayer createRect:rect string:obj font:self.font textColor:self.textColor alignmentMode:kCAAlignmentCenter];
                [self.scrollView.layer addSublayer:titleLayer];
                [self.itemList addObject:titleLayer];
                
                UIImage * img = self.images[idx];
                if (idx == 0 && [self.selectedImages firstObject] != nil) {
                    img = [self.selectedImages firstObject];
                }
                CALayer *imgLayer = [CALayer createRect:rectImg image:img];
                [self.scrollView.layer addSublayer:imgLayer];
                
                [self.itemListOne addObject:imgLayer];
                
                self.indicatorLayer.frame = [self updateFrameForIndicator];
                self.indicatorLayer.backgroundColor = self.indicatorColor.CGColor;
                [self.scrollView.layer addSublayer:self.indicatorLayer];
                
            }];
        }
            break;
        default:
            break;
    }
    [self.scrollView.layer getLayer];
}

- (CGRect)rectWithIndex:(NSInteger)idx textSize:(CGSize)textSize isImg:(BOOL)isImg{

    switch (self.iconMode) {
        case BN_ImgTypeRight:
        {
            if (isImg) {
               return CGRectMake(self.w_item*idx + self.w_item - self.imgSize.width, (self.height - self.imgSize.height)/2.0, self.imgSize.width, self.imgSize.height);
            }
            CGFloat y = (CGRectGetHeight(self.frame) - ceilf(textSize.height))/2.0;
            return CGRectMake(self.w_item*idx + self.w_item - self.imgSize.width - textSize.width, y, textSize.width, textSize.height);
        }
            break;
        default:
        {
             if (isImg == YES) {
                return CGRectMake(self.w_item*idx, (self.height - self.imgSize.height)/2.0, self.imgSize.width, self.imgSize.height);
             }
            CGFloat y = (CGRectGetHeight(self.frame) - ceilf(textSize.height))/2.0;
            return CGRectMake(self.w_item*idx + self.imgSize.width, y, textSize.width, textSize.height);
        }
            break;
    }
    return CGRectZero;
}


- (CGRect)updateFrameForIndicator {
    
    switch (self.type) {
        case BN_ControlTypeText:
        {
            if (self.indicatorMode == BN_IndicatorBox) {
                self.indicatorLayer.opacity = 0.3;
                if (self.indicatorSizeMode == BN_IndicatorSizeToFill) {
                    return CGRectMake(self.w_item * self.selectedIndex, 0, self.w_item, self.height);
                    
                }
                
                CGFloat w_text = [self.titles[self.selectedIndex] sizeWithAttributes:self.attDic].width;
                
                CGFloat widthEndOfIndex = self.w_item * (self.selectedIndex + 1);
                CGFloat widthBeforeIndex = self.w_item * self.selectedIndex;
                
                CGFloat x = (widthEndOfIndex - widthBeforeIndex)/2 + (widthBeforeIndex - w_text/2);
                return CGRectMake(x, 0, w_text, self.height);
                
            }
            
            CGFloat y = self.isIndicatorTop == YES ? 0.0 : self.height - self.h_indicator;
            if (self.indicatorSizeMode == BN_IndicatorSizeToFill) {
                return CGRectMake(self.w_item * self.selectedIndex, 0, self.w_item, self.height);
                
            }
            
            CGFloat w_text = [self.titles[self.selectedIndex] sizeWithAttributes:self.attDic].width;
            
            CGFloat widthEndOfIndex = self.w_item * (self.selectedIndex + 1);
            CGFloat widthBeforeIndex = self.w_item * self.selectedIndex;
            
            CGFloat x = (widthEndOfIndex - widthBeforeIndex)/2 + (widthBeforeIndex - w_text/2);
            
            return CGRectMake(x, y, w_text, self.h_indicator);
        }
            break;
        case BN_ControlTypeImage:
        {
            if (self.indicatorMode == BN_IndicatorBox) {
                self.indicatorLayer.opacity = 0.3;
                return CGRectMake(self.w_item * self.selectedIndex, 0, self.w_item, self.height);

            }
            
            CGFloat y = self.isIndicatorTop == YES ? 0.0 : self.height - self.h_indicator;
            return CGRectMake(self.w_item * self.selectedIndex, y, self.w_item,  self.h_indicator);
        }
            break;
        case BN_ControlTypeTextImage:
        {
            if (self.indicatorMode == BN_IndicatorBox) {
                self.indicatorLayer.opacity = 0.3;
                return CGRectMake(self.w_item * self.selectedIndex, 0, self.w_item, self.height);
                
            }
            
            CGFloat y = self.isIndicatorTop == YES ? 0.0 : self.height - self.h_indicator;
            return CGRectMake(self.w_item * self.selectedIndex, y, self.w_item,  self.h_indicator);
        }
            break;
        default:
            break;
    }
    
    return CGRectZero;
    
}

- (void)updateFrameForControl {
    // If there's no frame set, calculate the width of the control based on the number of segments and their size
    self.scrollView.frame = self.frame;

    NSInteger count = self.titles.count != 0 ? self.titles.count : self.images.count;
    if (!CGRectIsEmpty(self.frame) && self.isScroll == NO) {
        self.w_item = self.frame.size.width/count;
        self.height = self.frame.size.height;
        
        [self layoutIfNeeded];
        return;
    }
    self.height = self.frame.size.height;

    self.w_item = 0.0;
    switch (self.type) {
        case 0:
        {
            for (NSString *obj in self.titles) {
                CGFloat width = [obj sizeWithAttributes:self.attDic].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
                self.w_item = MAX(width, self.w_item);
            }
            
//            self.bounds = CGRectMake(0, 0, self.w_item * count, self.height);
        }
            break;
        case 1:
        {
//            self.bounds = CGRectMake(0, 0, self.w_item * count, self.height);
        }
            break;
        case 2:
        {
            for (NSString *obj in self.titles) {
                CGFloat width = [obj sizeWithAttributes:self.attDic].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
                self.w_item = MAX(width, self.w_item);

            }
            self.w_item += self.imgSize.width;
//            self.bounds = CGRectMake(0, 0, self.w_item * count, self.height);

        }
            break;
        default:
            break;
    }
    

    if (self.isScroll == YES) {
        self.scrollView.contentSize = CGSizeMake(self.w_item*count , CGRectGetHeight(self.bounds));
        
    }else{
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.bounds));
        
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    // Control is being removed
    if (newSuperview == nil)
        return;
    
    [self updateFrameForControl];

}

#pragma mark - Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {    
    if (self.isScroll == NO) {
        [self handleTouchWithEvent:event inView:self];

        return;
    }
    CGPoint point = [self handleTouchWithEvent:event inView:self.scrollView];
    [self.scrollView scrollRectToVisible:CGRectMake(point.x - self.w_item, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) animated:YES];

}

- (CGPoint)handleTouchWithEvent:(UIEvent *)event inView:(UIView *)inView{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:inView];
    
    if (CGRectContainsPoint(inView.bounds, point)) {
        NSInteger segment = point.x/self.w_item;
        
        [self updateSelectedItemWithIndex:segment];
        
        if (segment != self.selectedIndex) {
            [self setSelectedIndex:segment animated:YES];
        }
    }
    return point;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [[event allTouches] anyObject];
//    CGPoint touchLocation = [touch locationInView:self];
//
//    if (CGRectContainsPoint(self.bounds, touchLocation)) {
//        NSInteger segment = touchLocation.x / self.w_item;
//
//        [self updateSelectedItemWithIndex:segment];
//
//        if (segment != self.selectedIndex) {
//            [self setSelectedIndex:segment animated:YES];
//        }
//    }
//}

- (void)updateSelectedItemWithIndex:(NSInteger)index{
    
    switch (self.type) {
        case 0:
        {
            [self.itemList enumerateObjectsUsingBlock:^(CATextLayer *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIColor * color = index == idx ? self.textColor_H : self.textColor;
                [self.itemList[idx] setForegroundColor:color.CGColor];
                
            }];
        }
            break;
        case 1:
        {
            UIImage * image_H = self.selectedImages[index] != nil ? self.selectedImages[index] : self.images[index];
            [self.itemList enumerateObjectsUsingBlock:^(CALayer *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIImage * image = index == idx ? image_H : self.images[idx];
                [self.itemList[idx] setContents:(__bridge id _Nullable)image.CGImage];
                
            }];
        }
            break;
        case 2:
        {
            [self.itemList enumerateObjectsUsingBlock:^(CATextLayer *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIColor * color = index == idx ? self.textColor_H : self.textColor;
                [self.itemList[idx] setForegroundColor:color.CGColor];
                
            }];
            
            UIImage * image_H = self.selectedImages[index] != nil ? self.selectedImages[index] : self.images[index];
            [self.itemListOne enumerateObjectsUsingBlock:^(CALayer *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIImage * image = index == idx ? image_H : self.images[idx];
                [self.itemListOne[idx] setContents:(__bridge id _Nullable)image.CGImage];
                
            }];
        }
            break;
        default:
            break;
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
        self.indicatorLayer.actions = nil;
    
        [CATransaction animDuration:0.35 animations:^{
            self.indicatorLayer.frame = [self updateFrameForIndicator];
            [self updateSelectedItemWithIndex:index];
            
        } completion:^{
            if (self.superview)
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            
            if (self.block)
                self.block(self,index);
        }];
//        [CATransaction begin];
//        [CATransaction setAnimationDuration:0.5f];
//        [CATransaction setCompletionBlock:^{
//
//            if (self.superview)
//                [self sendActionsForControlEvents:UIControlEventValueChanged];
//
//            if (self.block)
//                self.block(self,index);
//        }];
//        self.indicatorLayer.frame = [self updateFrameForIndicator];
//        [self updateSelectedItemWithIndex:index];
//        [CATransaction commit];
    } else {
        // Disable CALayer animations
        NSDictionary * actionDic = @{
                                     @"position" : NSNull.null,
                                     @"bounds"  :   NSNull.null,
                                     
                                     };
        self.indicatorLayer.actions = actionDic;
        self.indicatorLayer.frame = [self updateFrameForIndicator];
        [self updateSelectedItemWithIndex:index];

        if (self.superview)
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        
        if (self.block)
            self.block(self,index);

    }    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (self.titles) [self updateFrameForControl];
    [self setNeedsDisplay];
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    
    self.scrollView.backgroundColor = backgroundColor;
    
}

-(void)setImgSize:(CGSize)imgSize{
    _imgSize = imgSize;
    
}

-(void)setIsScroll:(BOOL)isScroll{
    _isScroll = isScroll;
    
  
    
}

- (void)setImages:(NSArray *)images{
    if ([[images firstObject] isKindOfClass:[UIImage class]]) {
        _images = images;
        return;
    }
    _images = [self arrayWithImageNames:images];
    
}

- (void)setSelectedImages:(NSArray *)selectedImages{
    if ([[selectedImages firstObject] isKindOfClass:[UIImage class]]) {
        _selectedImages = selectedImages;
        return;
    }
    _selectedImages = [self arrayWithImageNames:selectedImages];
    
}

- (NSArray *)arrayWithImageNames:(NSArray *)imageNames{
    
    NSMutableArray * marr = [NSMutableArray array];
    [imageNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [marr addObject:[UIImage imageNamed:obj]];
        
    }];
    return marr.copy;
    
}

@end


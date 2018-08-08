
//
//  UITableView+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2018/2/28.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "UITableView+Helper.h"

@implementation UITableView (Helper)

- (void)logTableViewContentInset{
    DDLog(@"frame:%@",NSStringFromCGRect(self.frame));
    DDLog(@"contentInset:%@",NSStringFromUIEdgeInsets(self.contentInset));
    if (@available(iOS 11.0, *)) {
        DDLog(@"safeAreaInsets:%@",NSStringFromUIEdgeInsets(self.safeAreaInsets));
        DDLog(@"adjustedContentInset:%@",NSStringFromUIEdgeInsets(self.adjustedContentInset));
        
    }
}

-(void)insertIndexPaths:(NSArray *)indexPaths rowAnimation:(UITableViewRowAnimation)rowAnimation{
    if (!rowAnimation) rowAnimation = UITableViewRowAnimationNone;
    
    [self beginUpdates];
    [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self endUpdates];
}

-(void)deleteIndexPaths:(NSArray *)indexPaths rowAnimation:(UITableViewRowAnimation)rowAnimation{
    if (!rowAnimation) rowAnimation = UITableViewRowAnimationNone;
    
    [self beginUpdates];
    [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self endUpdates];
}

-(void)reloadIndexPaths:(NSArray *)indexPaths rowAnimation:(UITableViewRowAnimation)rowAnimation{
    if (!rowAnimation) rowAnimation = UITableViewRowAnimationNone;
    
    [self beginUpdates];
    [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self endUpdates];
}


-(void)deleteSectionIdxPath:(NSIndexPath *)idxPath rowAnimation:(UITableViewRowAnimation)rowAnimation{
    if (!rowAnimation) rowAnimation = UITableViewRowAnimationNone;
    
    [self beginUpdates];
    [self deleteSections:[NSIndexSet indexSetWithIndex:idxPath.section] withRowAnimation:UITableViewRowAnimationNone];
    [self endUpdates];
}


-(void)cellAddCornerRadius:(CGFloat)cornerRadius cell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    if ([self respondsToSelector:@selector(tintColor)]) {
        
        cell.backgroundColor = UIColor.clearColor;
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGMutablePathRef pathRef = CGPathCreateMutable();
        CGRect bounds = CGRectInset(cell.bounds, 10, 0);
        BOOL addLine = NO;
        if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            addLine = YES;
            
        } else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
        } else {
            CGPathAddRect(pathRef, nil, bounds);
            addLine = YES;
        }
        layer.path = pathRef;
        CFRelease(pathRef);
        //颜色修改
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.5f].CGColor;
        layer.strokeColor = [UIColor blackColor].CGColor;
        layer.strokeColor = [UIColor clearColor].CGColor;
        
        
        if (addLine == YES) {
            CALayer *lineLayer = [[CALayer alloc] init];
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
            lineLayer.backgroundColor = self.separatorColor.CGColor;
            [layer addSublayer:lineLayer];
        }
        
        UIView *bgView = [[UIView alloc] initWithFrame:bounds];
        [bgView.layer insertSublayer:layer atIndex:0];
        bgView.backgroundColor = UIColor.clearColor;
        cell.backgroundView = bgView;
    }
    
}

@end

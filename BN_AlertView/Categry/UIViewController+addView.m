//
//  UIViewController+addView.m
//  WeiHouBao
//
//  Created by 晁进 on 17-7-25.
//  Copyright (c) 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIViewController+addView.h"
#import "NSObject+Helper.h"

@implementation UIViewController (addView)

-(void)createBarBtnItemWithTitle:(NSString *)title imageName:(NSString *)imageName isLeft:(BOOL)isLeft target:(id)target aSelector:(SEL)aSelector isHidden:(BOOL)isHidden
{
    if (!isLeft) {
        
        if (imageName) {
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBtn.frame = CGRectMake(0, 0, 30, 30);
            rightBtn.exclusiveTouch = YES;
            UIImage * image = [UIImage imageNamed:imageName];
            [rightBtn setImage:image forState:UIControlStateNormal];
            //    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
            [rightBtn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
            
            rightBtn.titleLabel.text = imageName;//执行点击动作时做判断条件
            rightBtn.tag = kTAG_BTN_RightItem;

            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
            self.navigationItem.rightBarButtonItem = rightItem;
            
        }else{
            CGSize titleSize = [self sizeWithText:title font:@15 width:kScreen_width];
//            DDLog(@"size %@",NSStringFromCGSize(titleSize));
            
            
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (title.length <= 2) {
                titleSize.width = 35;
            }else{
                rightBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
                rightBtn.titleLabel.minimumScaleFactor = 1;
            }
            
//            rightBtn.layer.borderWidth = 2;
//            rightBtn.layer.borderColor = [[UIColor redColor]CGColor];
//            rightBtn.titleLabel.layer.borderWidth = 2;
//            rightBtn.titleLabel.layer.borderColor = [[UIColor redColor]CGColor];
            
            rightBtn.frame = CGRectMake(0, 0, titleSize.width, 30);
            rightBtn.titleEdgeInsets = UIEdgeInsetsMake(-10, -20, -10, -20);
            rightBtn.exclusiveTouch = YES;
            
            [rightBtn setTitle:title forState:UIControlStateNormal];
            [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            //    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
            rightBtn.tag = kTAG_BTN_RightItem;

            [rightBtn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
            self.navigationItem.rightBarButtonItem = rightItem;

        }
        
    }else{
        
        if (imageName) {
            UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            backBtn.frame = CGRectMake(0, 0, 30, 30);
            backBtn.exclusiveTouch = YES;
            UIImage * image = [UIImage imageNamed:imageName];
            [backBtn setImage:image forState:UIControlStateNormal];
            //    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
            [backBtn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
            
            backBtn.titleLabel.text = imageName;//执行点击动作时做判断条件
            backBtn.tag = kTAG_BTN_BackItem;

            UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
            self.navigationItem.leftBarButtonItem = backBtnItem;
            
        }else{

            if (!title) {
                CGSize iconSize = CGSizeMake(18, 29);
                iconSize = CGSizeMake(32, 32);

                CGSize btnSize = CGSizeMake(30, 30);
                
                UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                backBtn.frame = CGRectMake(0, 0, btnSize.width, btnSize.height);
                [backBtn setImage:[UIImage imageNamed:@"img_btnBack.png"] forState:UIControlStateNormal];
                [backBtn setImageEdgeInsets:UIEdgeInsetsMake((btnSize.height - iconSize.height)/2.0, (btnSize.width - iconSize.width)/2.0, (btnSize.height - iconSize.height)/2.0, (btnSize.width - iconSize.width)/2.0)];
                
                [backBtn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
                backBtn.tag = kTAG_BTN_BackItem;

//                backBtn.layer.borderColor = [[UIColor redColor]CGColor];
//                backBtn.layer.borderWidth = 1.0;
                UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
                self.navigationItem.leftBarButtonItem = leftItem;

            }else{
                UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                backBtn.frame = CGRectMake(0, 0, 30, 30);
                [backBtn setImage:nil forState :UIControlStateNormal];
                [backBtn setTitle:title forState:UIControlStateNormal];
                [backBtn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
                backBtn.tag = kTAG_BTN_BackItem;
                
                UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
                [backBtn addTarget:target action:aSelector forControlEvents:UIControlEventTouchUpInside];
                self.navigationItem.leftBarButtonItem = backBtnItem;

            }
        }
    }
}

- (void)addLineViewWithRect:(CGRect)rect inView:(UIView *)inView{
    
    UIView * topLineView = [[UIView alloc]initWithFrame:rect];
//    topLineView.backgroundColor = [UIColor colorWithHexString:@"#d2d2d2"];
    topLineView.backgroundColor = [UIColor greenColor];
    //        topLineView.backgroundColor = [UIColor redColor];
    
    [inView addSubview:topLineView];
}

- (void)addLineDashWithRect:(CGRect)rect tag:(NSInteger)tag inView:(UIView *)inView{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    imageView.tag = tag;
    imageView.backgroundColor = [UIColor clearColor];
    [inView addSubview:imageView];
    
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
    [imageView.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame))];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    CGFloat lengths[] = {3,1.5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor lightGrayColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0, 0);    //开始画线
    CGContextAddLineToPoint(line, CGRectGetMaxX(imageView.frame), 0);
    CGContextStrokePath(line);
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
}

- (UITableViewCell *)getCellByClickView:(UIView *)view
{
    UIView * supView = [view superview];
    while (![supView isKindOfClass:[UITableViewCell class]]) {
        
        supView = [supView superview];
    }
    UITableViewCell * tableViewCell = (UITableViewCell *)supView;
    return tableViewCell;
}

- (NSIndexPath *)getCellIndexPathByClickView:(UIView *)view  tableView:(UITableView *)tableView
{
    UITableViewCell * cell = [self getCellByClickView:view];
    NSIndexPath * indexPath = [tableView indexPathForRowAtPoint:cell.center];
    return indexPath;
}

@end

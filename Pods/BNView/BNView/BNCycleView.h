//
//  BNCycleView.h
//  ProductTemplet
//
//  Created by hsf on 2018/5/8.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNCycleView : UIView

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) NSArray *list;


- (void)start;

@end

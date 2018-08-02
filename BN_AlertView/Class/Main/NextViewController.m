//
//  NextViewController.m
//  CustomeAlertView
//
//  Created by hsf on 2017/9/29.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "NextViewController.h"

#import "BINAlertView.h"

#import "DKSButton.h"

NSString *const BN_ItemTitle = @"BN_ItemTitle";
NSString *const BN_ItemTitleColor_N = @"BN_ItemTitleColor_N";
NSString *const BN_ItemTitleColor_H = @"BN_ItemTitleColor_H";

NSString *const BN_ItemImage_N = @"BN_ItemImage_N";
NSString *const BN_ItemImage_H = @"BN_ItemImage_H";

NSString *const BN_ItemControlName = @"BN_ItemControlName";

#define  padding  8

@interface NextViewController ()


@property (nonatomic, strong) NSArray *itemList;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.itemList = @[
                      @{
                         BN_ItemTitle:          @"00000",
                         BN_ItemTitleColor_N:   @"asdada",
                         BN_ItemTitleColor_H:   @"asdada",
                         BN_ItemImage_N:        @"asdada",
                         BN_ItemImage_H:        @"asdada",
                         BN_ItemControlName:@"asdada",
                          },
                      @{
                          BN_ItemTitle:          @"11111",
                          BN_ItemTitleColor_N:   @"asdada",
                          BN_ItemTitleColor_H:   @"asdada",
                          BN_ItemImage_N:        @"asdada",
                          BN_ItemImage_H:        @"asdada",
                          BN_ItemControlName:@"asdada",
                          },
                      @{
                          BN_ItemTitle:          @"22222",
                          BN_ItemTitleColor_N:   @"asdada",
                          BN_ItemTitleColor_H:   @"asdada",
                          BN_ItemImage_N:        @"asdada",
                          BN_ItemImage_H:        @"asdada",
                          BN_ItemControlName:@"asdada",
                          },
                      @{
                          BN_ItemTitle:          @"33333",
                          BN_ItemTitleColor_N:   @"asdada",
                          BN_ItemTitleColor_H:   @"asdada",
                          BN_ItemImage_N:        @"asdada",
                          BN_ItemImage_H:        @"asdada",
                          BN_ItemControlName:   @"asdada",
                          },
                      @{
                          BN_ItemTitle:          @"44444",
                          BN_ItemTitleColor_N:   @"asdada",
                          BN_ItemTitleColor_H:   @"asdada",
                          BN_ItemImage_N:        @"asdada",
                          BN_ItemImage_H:        @"asdada",
                          BN_ItemControlName:   @"asdada",
                          },
                      
                      ];
    
    
    UIView * view = [self createViewWithRect:CGRectMake(0, 80, kScreen_width, 60) items:self.itemList];
    [self.view addSubview:view];
    
}

- (UIView *)createViewWithRect:(CGRect)rect items:(NSArray<NSDictionary *> *)items{
    
    UIView * containView = [[UIView alloc]initWithFrame:rect];
    containView.backgroundColor = [UIColor greenColor];
    
    CGFloat itemWidth = CGRectGetWidth(rect)/items.count;
    
    for (int i = 0; i <  items.count; i ++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * itemWidth, 0, itemWidth, CGRectGetHeight(rect))];
        
        NSDictionary * dict = items[i];
        
        UIButton * btn = [self createBtnWithRect:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame)) title:dict[BN_ItemTitle] tag:i];
        [view addSubview:btn];
        [containView addSubview:view];
    }
    return containView;
}

- (UIButton *)createBtnWithRect:(CGRect)rect title:(NSString *)title tag:(NSInteger)tag{
//    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    DKSButton *button = [DKSButton buttonWithType:UIButtonTypeCustom withSpace:10];
    button.buttonStyle = DKSButtonImageTop;
    button.frame = rect;
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"警告.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    return button;
}

- (void)handleActionBtn:(UIButton *)sender{
    DDLog(@"%@",sender.titleLabel.text);
    
}

- (void)setButtonImageAndTitleWithSpace:(CGFloat)spacing WithButton:(UIButton *)btn{
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    
    CGSize textSize = [self sizeWithText:btn.titleLabel.text font:btn.titleLabel.font width:kScreen_width];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}




@end

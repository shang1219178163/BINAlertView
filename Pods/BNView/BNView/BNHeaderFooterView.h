//
//  BNHeaderFooterView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/4/2.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

/*
 UITableViewHeaderFooterView根类
 
 */

#import <UIKit/UIKit.h>

@class FoldSectionModel;
@class BNHeaderFooterView;

@interface BNHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIImageView * imgViewLeft;
@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) UIButton * btn;

@property (nonatomic, copy) void (^blockView)(BNHeaderFooterView *foldView,NSInteger index);

+(instancetype)viewWithTableView:(UITableView *)tableView;

@end


//折叠数据模型
@interface FoldSectionModel : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * titleSub;

@property (nonatomic, strong) id image;

@property (nonatomic, strong) NSMutableArray * dataList;

@property (nonatomic, assign) BOOL isOpen;

@end

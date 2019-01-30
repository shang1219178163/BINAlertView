//
//  UITableViewEightyCell.m
//  
//
//  Created by BIN on 2018/5/8.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewEightyCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"
  
@implementation UITableViewEightyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //图片
    //文字
    
    [self.contentView addSubview:self.labelLeft];
    
    [self.contentView addSubview:self.itemsView];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];

    CGSize sizeItemsView = [self sizeItemsViewWidth:(kScreenWidth - kX_GAP*2) items:self.itemsView.items numberOfRow:4 itemHeight:0.0 padding:kY_GAP];

    //控件2
    CGRect labelLeftRect = CGRectMake(kX_GAP, kY_GAP, kScreenWidth - kX_GAP*2, CGRectGetHeight(self.contentView.frame) - sizeItemsView.height - kY_GAP*3);
    self.labelLeft.frame = labelLeftRect;

    CGRect viewRect = CGRectMake(kX_GAP, CGRectGetMaxY(labelLeftRect)+kY_GAP, sizeItemsView.width, sizeItemsView.height);
    self.itemsView.frame = viewRect;

    self.itemsView.hidden = self.itemsView.items.count == 0 ? YES : NO;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(BNItemsView *)itemsView{
    if (!_itemsView) {
        _itemsView = [[BNItemsView alloc]initWithFrame:CGRectZero];
        _itemsView.numberOfRow = 4;
        _itemsView.padding = 10;
    }
    return _itemsView;
}


@end

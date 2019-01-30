
//
//  UITableViewAchivementCell.m
//  
//
//  Created by BIN on 2018/7/31.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewAchivementCell.h"

@interface UITableViewAchivementCell()

@property (nonatomic, strong) NSMutableArray * viewList;

@end

@implementation UITableViewAchivementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //生产报表
    
    [self.contentView addSubview:self.monthView];
    [self.contentView addSubview:self.pairView];

    self.pairView.labOne.text = [self.itemList firstObject];
    self.pairView.labOne.textColor = [UIColor colorWithWhite:0.0 alpha:0.5];

    self.pairView.labTwo.font = [UIFont systemFontOfSize:36];
    self.pairView.labTwo.textColor = UIColor.blueColor;
    

    NSArray * itemListSub = [self.itemList subarrayWithRange:NSMakeRange(1, self.itemList.count - 1)];
    [itemListSub enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BNPairLabelView * pairView = [[BNPairLabelView alloc] initWithFrame:CGRectZero];
        pairView.labOne.textColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        pairView.labOne.text = obj;
        pairView.labTwo.text = kNIl_TEXT;
        
        pairView.labOne.font = [UIFont systemFontOfSize:15];
        pairView.labTwo.font = [UIFont systemFontOfSize:14];

        [self.contentView addSubview:pairView];
        [self.viewList addObject:pairView];
    }];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    
    NSParameterAssert(self.itemList.count == self.valueList.count);
    
    NSString *numDecStyleStr = [NSNumberFormatter numberStyle:NSNumberFormatterDecimalStyle number:[self.valueList firstObject]];
    self.pairView.labTwo.text = numDecStyleStr;
    
    self.monthView.frame = CGRectMake(kX_GAP, 0, 80, CGRectGetHeight(self.contentView.frame));
    CGFloat kW_right = self.contentView.maxX - CGRectGetWidth(self.monthView.frame) - kX_GAP*2;
    self.pairView.frame = CGRectMake(CGRectGetMaxX(self.monthView.frame) + kPadding, kY_GAP, (kW_right - kPadding*2)/3.0, 60);

    
    NSInteger rowCount = 3;
    CGSize viewSize = CGSizeMake((kW_right - kPadding*3)/3.0, 40);
    
    NSArray * itemListSub = [self.itemList subarrayWithRange:NSMakeRange(1, self.itemList.count - 1)];
    NSArray * valueListSub = [self.valueList subarrayWithRange:NSMakeRange(1, self.valueList.count - 1)];

    [self.viewList enumerateObjectsUsingBlock:^(BNPairLabelView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = (idx % rowCount) * (viewSize.width + kPadding) + CGRectGetMinX(self.pairView.frame);
        CGFloat y = (idx / rowCount) * (viewSize.height + kPadding) + CGRectGetMaxY(self.pairView.frame) + kPadding;
        CGRect rect = CGRectMake(x, y, viewSize.width, viewSize.height);
        
        BNPairLabelView * pairView = obj;
        pairView.frame = rect;
        pairView.labOne.text = itemListSub[idx];
        pairView.labTwo.text = [NSString stringWithFormat:@"%@",valueListSub[idx]];
        
    }];
    
    [self.contentView getViewLayer];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

- (BNMonthView *)monthView{
    if (!_monthView) {
        _monthView = ({
            BNMonthView * view = [[BNMonthView alloc]initWithFrame:CGRectZero];
            
            view;
        });
    }
    return _monthView;
}

-(BNPairLabelView *)pairView{
    if (!_pairView) {
        _pairView = [[BNPairLabelView alloc]initWithFrame:CGRectZero];
        
    }
    return _pairView;
}

-(NSArray *)itemList{
    if (!_itemList) {
        _itemList = @[@"母猪存栏头数",@"配种分娩率",@"月产胎次",@"窝均产仔数",@"窝均健仔数",@"窝均次品仔",@"仔猪出生均重",@"窝均断奶数",@"断奶均重",];
    }
    return _itemList;
    
}

-(NSMutableArray *)viewList{
    if (!_viewList) {
        _viewList = [NSMutableArray array];
    }
    return _viewList;
    
    
}

@end

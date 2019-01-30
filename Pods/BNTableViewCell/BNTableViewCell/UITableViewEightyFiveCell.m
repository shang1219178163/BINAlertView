//
//  UITableViewEightyFiveCell.m
//  
//
//  Created by BIN on 2018/5/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewEightyFiveCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"

@implementation UITableViewEightyFiveCell
 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    
    [self.contentView addSubview:self.turnView];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.turnView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(BNTurnView *)turnView{
    if (!_turnView) {
        _turnView = ({
            BNTurnView * view = [[BNTurnView alloc]initWithFrame:CGRectMake(kX_GAP, kY_GAP, kScreenWidth - kX_GAP*2, 60)];
            view.backgroundColor = UIColor.greenColor;
            view.imgView.image = [UIImage imageNamed:@"测试图标.png"];
            view.list = @[@"aaaaaaaaaaaaaa",];
            view.list = @[@"11111111111",@"222222222222",@"333333333333",@"444444444444",@"555555555",@"66666666666",];
            view.interval = 1.5;
            
            view;
        });
    }
    return _turnView;
}

@end

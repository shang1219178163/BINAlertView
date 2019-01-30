//
//  UITableViewEightySixCell.m
//  
//
//  Created by BIN on 2018/5/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewEightySixCell.h"
#import "BNGloble.h"

@implementation UITableViewEightySixCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    [self.contentView addSubview:self.cycleView];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.cycleView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(BNCycleView *)cycleView{
    if (!_cycleView) {
        _cycleView = ({
            BNCycleView * view = [[BNCycleView alloc]initWithFrame:CGRectMake(kX_GAP, kY_GAP + 100, kScreenWidth - kX_GAP*2, 60)];
            view.imgView.image = [UIImage imageNamed:@"img_notice_One.png"];
            view.list = @[@"11111111111",@"222222222222",@"333333333333",@"444444444444",@"555555555",@"66666666666",];
            
            view;
        });
    }
    return _cycleView;
}



@end

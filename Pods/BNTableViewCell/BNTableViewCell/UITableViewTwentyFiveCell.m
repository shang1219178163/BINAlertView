
//
//  UITableViewTwentyFiveCell.m
//  
//
//  Created by BIN on 2017/9/27.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewTwentyFiveCell.h"
#import "BNGloble.h"

@interface UITableViewTwentyFiveCell ()

@end 

@implementation UITableViewTwentyFiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{

    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

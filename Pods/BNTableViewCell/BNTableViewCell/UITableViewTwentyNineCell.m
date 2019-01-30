//
//  UITableViewTwentyNineCell.m
//  
//
//  Created by BIN on 2017/10/12.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewTwentyNineCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"

@interface UITableViewTwentyNineCell ()

@end 

@implementation UITableViewTwentyNineCell

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

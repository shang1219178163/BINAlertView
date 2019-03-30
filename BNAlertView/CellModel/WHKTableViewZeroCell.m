//
//  WHKTableViewZeroCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/16.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewZeroCell.h"

@interface WHKTableViewZeroCell ()

@end

@implementation WHKTableViewZeroCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"WHKTableViewZeroCell";
    WHKTableViewZeroCell *cell = (WHKTableViewZeroCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[WHKTableViewZeroCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        //返回系统默认cell,用于cell上只有一个控件时自定义

    }
    return self;
}

- (void)createView{
    //


}


- (void)layoutSubviews {
    [super layoutSubviews];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

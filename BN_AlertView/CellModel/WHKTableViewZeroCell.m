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
    UIView * topLine = [UIView createLineWithRect:CGRectMake(0, 0, kScreen_width, kH_LINE_VIEW) isDash:NO tag:kTAG_VIEW+10];
    [self.contentView addSubview:topLine];
    self.lineTop = topLine;
    self.lineTop.hidden = YES;

}


- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subview in self.contentView.superview.subviews) {
        if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"]) {
            subview.hidden = NO;
            CGRect frame = subview.frame;
            frame.origin.x += self.separatorInset.left;
//            frame.size.width -= self.separatorInset.right;
//            frame.size.width = kScreen_width;
            subview.frame = frame;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

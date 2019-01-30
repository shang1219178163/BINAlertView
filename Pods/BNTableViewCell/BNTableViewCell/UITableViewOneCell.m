//
//  UITableViewOneCell.m
//  
//
//  Created by BIN on 2017/8/8.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewOneCell.h"
#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "NSString+Helper.h"
#import "UIView+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface UITableViewOneCell ()

@end

/**
 图片+文字+文字+图片
 */
@implementation UITableViewOneCell

- (void)dealloc
{
    [self.labelLeft removeObserver:self forKeyPath:@"text"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
         [self.contentView addSubview:self.imgViewLeft];
         [self.contentView addSubview:self.imgViewRight];
         [self.contentView addSubview:self.labelLeft];
         [self.contentView addSubview:self.labelRight];
         
         [self.labelLeft addObserver:self forKeyPath:@"text" options: NSKeyValueObservingOptionNew context:nil];
   
         [self setupConstraint];

    }
    return self;
}

#pragma mark -observe
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        self.labelLeft.attributedText = [self.labelLeft.text toAsterisk];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupConstraint];
   
}

- (void)setupConstraint{
    //箭头不隐藏
    if (self.imgViewRight.isHidden == false) {
        [self.imgViewRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-kX_GAP);
            make.size.equalTo(kSizeArrow);
        }];
    
        //头像不为空
        if (self.imgViewLeft.image != nil) {
            [self.imgViewLeft makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.left.equalTo(self.contentView).offset(kX_GAP);
                make.width.height.equalTo(self.contentView.sizeHeight - kY_GAP*2);
            }];
            
            if (self.type.integerValue == 0) {
                //右边文字优先展示
                [self.labelRight sizeToFit];
                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.right.equalTo(self.imgViewRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];
                
                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.left.equalTo(self.imgViewLeft.right).offset(kPadding);
                    make.right.equalTo(self.labelRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];

            } else {
                //左边文字优先展示
                [self.labelLeft sizeToFit];
                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.left.equalTo(self.imgViewLeft.right).offset(kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];

                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.left.equalTo(self.labelLeft.right).offset(kPadding);
                    make.right.greaterThanOrEqualTo(self.imgViewRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];
            }

        } else {
            //头像为空
            [self.imgViewLeft makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.left.equalTo(self.contentView).offset(kX_GAP);
                make.width.height.equalTo(0.0);
            }];

            if (self.type.integerValue == 0) {
                [self.labelRight sizeToFit];
                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.right.greaterThanOrEqualTo(self.imgViewRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];

                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.left.equalTo(self.contentView).offset(kX_GAP);
                    make.right.equalTo(self.labelRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];

            } else {
                [self.labelLeft sizeToFit];
                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.left.equalTo(self.contentView).offset(kX_GAP);
                    make.height.equalTo(kSizeArrow.height);
                }];

                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.left.equalTo(self.labelLeft.right).offset(kPadding);
                    make.right.greaterThanOrEqualTo(self.imgViewRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];
            }
        }

    } else {
        //头像不为空
        if (self.imgViewLeft.image != nil) {
            [self.imgViewLeft makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.left.equalTo(self.contentView).offset(kX_GAP);
                make.width.height.equalTo(self.contentView.sizeHeight - kY_GAP*2);
            }];

            if (self.type.integerValue == 0) {
                //右边文字优先展示
                [self.labelRight sizeToFit];
                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.right.equalTo(self.contentView).offset(-kX_GAP);
                    make.height.equalTo(kSizeArrow.height);
                }];

                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.left.equalTo(self.imgViewLeft.right).offset(kPadding);
                    make.right.equalTo(self.labelRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];

            } else {
                //左边文字优先展示
                [self.labelLeft sizeToFit];
                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.left.equalTo(self.imgViewLeft.right).offset(kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];

                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.left.equalTo(self.labelLeft.right).offset(kPadding);
                    make.right.equalTo(self.contentView).offset(-kX_GAP);
                    make.height.equalTo(kSizeArrow.height);
                }];
            }

        } else {
            [self.imgViewLeft makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.left.equalTo(self.contentView).offset(kX_GAP);
                make.width.height.equalTo(0.0);
            }];
            if (self.type.integerValue == 0) {
                //右边文字优先展示
                [self.labelRight sizeToFit];
                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.right.equalTo(self.contentView).offset(-kX_GAP);
                    make.height.equalTo(kSizeArrow.height);
                }];

                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.left.equalTo(self.contentView).offset(kX_GAP);
                    make.right.equalTo(self.labelRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];
            } else {
                //左边文字优先展示
                [self.labelLeft sizeToFit];
                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.left.equalTo(self.contentView).offset(kX_GAP);
                    make.height.equalTo(kSizeArrow.height);
                }];

                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.contentView);
                    make.left.equalTo(self.labelLeft.right).offset(kPadding);
                    make.right.greaterThanOrEqualTo(self.contentView).offset(-kX_GAP);
                    make.height.equalTo(kSizeArrow.height);
                }];
            }
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

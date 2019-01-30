//
//  BNCellDefaultView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNCellDefaultView.h"

#import "BNGloble.h"
#import "UIView+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


/**
 图片+文字+文字+图片
 */
@implementation BNCellDefaultView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgViewLeft];
        [self addSubview:self.imgViewRight];
        [self addSubview:self.labelLeft];
        [self addSubview:self.labelRight];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupConstraint];

}

- (void)setupConstraint{
    //箭头不隐藏
    if (self.imgViewRight.isHidden == false) {

        [self.imgViewRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-kX_GAP);
            make.size.equalTo(kSizeArrow);
        }];

        //头像不为空
        if (self.imgViewLeft.image != nil) {
            [self.imgViewLeft makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self).offset(kX_GAP);
                make.width.height.equalTo(self.sizeHeight - kY_GAP*2);
            }];

            if (self.type.integerValue == 0) {
                //右边文字优先展示
                [self.labelRight sizeToFit];
                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.right.equalTo(self.imgViewRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];
           
                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.left.equalTo(self.imgViewLeft.right).offset(kPadding);
                    make.right.equalTo(self.labelRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];

            } else {
                //左边文字优先展示
                [self.labelLeft sizeToFit];
                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.left.equalTo(self.imgViewLeft.right).offset(kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];

                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.left.equalTo(self.labelLeft.right).offset(kPadding);
                    make.right.greaterThanOrEqualTo(self.imgViewRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];
            }

        } else {
            //头像为空
            [self.imgViewLeft makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self).offset(kX_GAP);
                make.width.height.equalTo(0.0);
            }];

            if (self.type.integerValue == 0) {
                [self.labelRight sizeToFit];
                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.right.equalTo(self.imgViewRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];

                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.left.equalTo(self).offset(kX_GAP);
                    make.right.equalTo(self.labelRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];

            } else {
                [self.labelLeft sizeToFit];
                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.left.equalTo(self).offset(kX_GAP);
                    make.height.equalTo(kSizeArrow.height);
                }];

                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.left.equalTo(self.labelLeft.right).offset(kPadding);
                    make.right.equalTo(self.imgViewRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];
            }
        }

    } else {
        //头像不为空
        if (self.imgViewLeft.image != nil) {
            [self.imgViewLeft makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self).offset(kX_GAP);
                make.width.height.equalTo(self.sizeHeight - kY_GAP*2);
            }];

            if (self.type.integerValue == 0) {
                //右边文字优先展示
                [self.labelRight sizeToFit];
                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.right.equalTo(self).offset(-kX_GAP);
                    make.height.equalTo(kSizeArrow.height);
                }];

                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.left.equalTo(self.imgViewLeft.right).offset(kPadding);
                    make.right.equalTo(self.labelRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];

            } else {
                //左边文字优先展示
                [self.labelLeft sizeToFit];
                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.left.equalTo(self.imgViewLeft.right).offset(kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];

                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.left.equalTo(self.labelLeft.right).offset(kPadding);
                    make.right.equalTo(self).offset(-kX_GAP);
                    make.height.equalTo(kSizeArrow.height);
                }];
            }

        } else {
            [self.imgViewLeft makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self).offset(kX_GAP);
                make.width.height.equalTo(0.0);
            }];
            if (self.type.integerValue == 0) {
                //右边文字优先展示
                [self.labelRight sizeToFit];
                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.right.equalTo(self).offset(-kX_GAP);
                    make.height.equalTo(kSizeArrow.height);
                }];

                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.left.equalTo(self).offset(kX_GAP);
                    make.right.equalTo(self.labelRight.left).offset(-kPadding);
                    make.height.equalTo(kSizeArrow.height);
                }];
            } else {
                //左边文字优先展示
                [self.labelLeft sizeToFit];
                [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.left.equalTo(self).offset(kX_GAP);
                    make.height.equalTo(kSizeArrow.height);
                }];

                [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self);
                    make.left.equalTo(self.labelLeft.right).offset(kPadding);
                    make.right.equalTo(self).offset(-kX_GAP);
                    make.height.equalTo(kSizeArrow.height);
                }];
            }
        }
    }
}

//(勿删)备用布局
//- (void)setupConstraint{
//    //箭头不隐藏
//    if (self.imgViewRight.isHidden == false) {
//        self.imgViewRight.frame = CGRectMake(self.sizeWidth - kX_GAP - kSizeArrow.width,
//                                             self.midY - kSizeArrow.height*0.5,
//                                             kSizeArrow.width,
//                                             kSizeArrow.height);
//
//        //头像不为空
//        if (self.imgViewLeft.image != nil) {
//            self.imgViewLeft.frame = CGRectMake(kX_GAP,
//                                                kY_GAP,
//                                                self.sizeHeight - kY_GAP*2,
//                                                self.sizeHeight - kY_GAP*2);
//
//            if (self.type.integerValue == 0) {
//                //右边文字优先展示
//                [self.labelRight sizeToFit];
//                self.labelRight.frame = CGRectMake(self.imgViewRight.minX - self.labelRight.sizeWidth - kPadding,
//                                                   self.imgViewRight.minY,
//                                                   self.labelRight.sizeWidth,
//                                                   self.imgViewRight.sizeHeight);
//
//                self.labelLeft.frame = CGRectMake(self.imgViewLeft.maxX + kPadding,
//                                                  self.imgViewRight.minY,
//                                                  self.labelRight.minX - self.imgViewLeft.maxX - kPadding*2,
//                                                  self.imgViewRight.sizeHeight);
//
//
//            } else {
//                //左边文字优先展示
//                [self.labelLeft sizeToFit];
//                self.labelLeft.frame = CGRectMake(self.imgViewLeft.maxX + kPadding,
//                                                  self.imgViewRight.minY,
//                                                  self.labelLeft.sizeWidth,
//                                                  self.imgViewRight.sizeHeight);
//
//                self.labelRight.frame = CGRectMake(self.labelLeft.maxX + kPadding,
//                                                   self.imgViewRight.minY,
//                                                   self.imgViewRight.minX - self.labelLeft.maxX - kPadding*2,
//                                                   self.imgViewRight.sizeHeight);
//
//            }
//
//        } else {
//            //头像为空
//            self.imgViewLeft.hidden = true;
//
//            if (self.type.integerValue == 0) {
//                [self.labelRight sizeToFit];
//                self.labelRight.frame = CGRectMake(kX_GAP,
//                                                   self.imgViewRight.minY,
//                                                   self.labelRight.sizeWidth,
//                                                   self.imgViewRight.sizeHeight);
//                self.labelLeft.frame = CGRectMake(kX_GAP,
//                                                  self.imgViewRight.minY,
//                                                  self.labelRight.minX - kX_GAP - kPadding,
//                                                  self.imgViewRight.sizeHeight);
//
//            } else {
//                [self.labelLeft sizeToFit];
//                self.labelLeft.frame = CGRectMake(kX_GAP,
//                                                  self.imgViewRight.minY,
//                                                  self.labelLeft.sizeWidth,
//                                                  self.imgViewRight.sizeHeight);
//
//                self.labelRight.frame = CGRectMake(self.imgViewLeft.maxX + kPadding,
//                                                   self.imgViewRight.minY,
//                                                   self.imgViewRight.minX - self.labelLeft.maxX - kPadding*2,
//                                                   self.imgViewRight.sizeHeight);
//
//            }
//        }
//
//    } else {
//        //头像不为空
//        if (self.imgViewLeft.image != nil) {
//            self.imgViewLeft.frame = CGRectMake(kX_GAP,
//                                                kY_GAP,
//                                                self.sizeHeight - kY_GAP*2,
//                                                self.sizeHeight - kY_GAP*2);
//
//            if (self.type.integerValue == 0) {
//                //右边文字优先展示
//                [self.labelRight sizeToFit];
//                self.labelRight.frame = CGRectMake(self.sizeWidth - self.labelRight.sizeWidth - kPadding,
//                                                   self.imgViewLeft.minY,
//                                                   self.labelRight.sizeWidth,
//                                                   self.labelLeft.sizeHeight);
//                self.labelLeft.frame = CGRectMake(self.imgViewLeft.maxX + kPadding,
//                                                  self.imgViewLeft.minY,
//                                                  self.labelRight.minX - self.imgViewLeft.maxX - kPadding*2,
//                                                  self.labelLeft.sizeHeight);
//
//            } else {
//                //左边文字优先展示
//                [self.labelLeft sizeToFit];
//                self.labelLeft.frame = CGRectMake(self.imgViewLeft.maxX + kPadding,
//                                                  self.imgViewLeft.minY,
//                                                  self.labelLeft.sizeWidth,
//                                                  self.labelLeft.sizeHeight);
//                self.labelRight.frame = CGRectMake(self.labelLeft.maxX + kPadding,
//                                                   self.imgViewLeft.minY,
//                                                   self.sizeWidth - self.labelLeft.maxX - kPadding*2,
//                                                   self.labelLeft.sizeHeight);
//            }
//
//        } else {
//            self.imgViewLeft.hidden = true;
//
//            if (self.type.integerValue == 0) {
//                //右边文字优先展示
//                [self.labelRight sizeToFit];
//                self.labelRight.frame = CGRectMake(self.sizeWidth - self.labelRight.sizeWidth - kPadding,
//                                                   self.imgViewLeft.minY,
//                                                   self.labelRight.sizeWidth,
//                                                   self.labelLeft.sizeHeight);
//
//                self.labelLeft.frame = CGRectMake(kX_GAP,
//                                                  self.imgViewRight.minY,
//                                                  self.labelRight.minX - self.imgViewLeft.maxX - kPadding*2,
//                                                  self.labelLeft.sizeHeight);
//
//
//            } else {
//                //左边文字优先展示
//                [self.labelLeft sizeToFit];
//                self.labelLeft.frame = CGRectMake(self.imgViewLeft.maxX + kPadding,
//                                                  self.imgViewRight.minY,
//                                                  self.labelLeft.sizeWidth,
//                                                  self.labelLeft.sizeHeight);
//
//                self.labelRight.frame = CGRectMake(self.labelLeft.maxX + kPadding,
//                                                   self.imgViewRight.minY,
//                                                   self.imgViewRight.minX - self.labelLeft.maxX - kPadding*2,
//                                                   self.labelLeft.sizeHeight);
//
//            }
//        }
//    }
//}

-(UILabel *)labelLeft{
    if (!_labelLeft) {
        _labelLeft = ({
            UILabel * view = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL type:@2];
            view.textAlignment = NSTextAlignmentLeft;
            view;
        });
    }
    return _labelLeft;
}

-(UILabel *)labelRight{
    if (!_labelRight) {
        _labelRight = ({
            UILabel * view = [UIView createLabelRect:CGRectZero text:@"" font:16 tag:kTAG_LABEL+4 type:@2];
            view.textAlignment = NSTextAlignmentLeft;
            view;
        });
    }
    return _labelRight;
}

-(UIImageView *)imgViewLeft{
    if (!_imgViewLeft) {
        _imgViewLeft = ({
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.userInteractionEnabled = YES;
            
            view;
        });
    }
    return _imgViewLeft;
}


-(UIImageView *)imgViewRight{
    if (!_imgViewRight) {
        _imgViewRight = ({
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.userInteractionEnabled = YES;
            //            imgView.backgroundColor = UIColor.orangeColor;
            view.frame = CGRectMake(self.maxX - kX_GAP - kSizeArrow.width, (self.maxY - kSizeArrow.height)/2.0, kSizeArrow.width, kSizeArrow.height);
            view.image = [UIImage imageNamed:kIMG_arrowRight];
            
            view.hidden = YES;
            view;
        });
    }
    return _imgViewRight;
}

@end

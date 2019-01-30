//
//  UITableViewTextViewCell.m
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UITableViewTextViewCell.h"

#import "BNGloble.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"
#import "UIView+Helper.h"
#import "UITextView+Helper.h"
#import "NSString+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation UITableViewTextViewCell

- (void)dealloc
{
    [self.labelLeft removeObserver:self forKeyPath:@"text"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.labelLeft];
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.labelLeftSub];

        self.wordCount = 140;
        
        self.labelLeftSub.textAlignment = NSTextAlignmentRight;
        self.labelLeftSub.font = [UIFont systemFontOfSize:13];
        [self.labelLeft addObserver:self forKeyPath:@"text" options: NSKeyValueObservingOptionNew context:nil];

        self.textView.placeHolderTextView.text = @"请输入";
        self.textView.userInteractionEnabled = YES;
        self.textView.returnKeyType = UIReturnKeyDone;
        self.textView.delegate = self;

    }
    return self;
}

#pragma mark -observe
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        self.labelLeft.attributedText = [self.labelLeft.text toAsterisk];
    }
}

- (void)setWordCount:(NSInteger)wordCount{
    _wordCount = wordCount;
    
    self.labelLeftSub.text = [NSString stringWithFormat:@"%@/%@",@(0),@(self.wordCount)];
}

-(void)layoutSubviews{
    [super layoutSubviews];
   
    [self setupConstraint];
}

-(void)setupConstraint{
    [self.labelLeft sizeToFit];
    self.labelLeft.size = CGSizeMake(self.labelLeft.sizeWidth, 25);
    
    switch (self.type.integerValue){
    case 1:
        {
            [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(kY_GAP);
                make.left.equalTo(self.contentView).offset(kX_GAP);
                make.size.equalTo(self.labelLeft.frame.size);
            }];
            
             [self.labelLeftSub makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelLeft);
                make.right.equalTo(self.contentView).offset(-kX_GAP);
                make.size.equalTo(self.labelLeft.frame.size);
             }];
            
             [self.textView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelLeft.bottom).offset(kPadding);
                 make.left.equalTo(self.labelLeft);
                 make.right.equalTo(self.labelLeftSub.right);
                make.bottom.equalTo(self.contentView).offset(-kY_GAP);
             }];
        }
            break;
    default:
        {
            [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView).offset(kY_GAP);
                make.left.equalTo(self.contentView).offset(kX_GAP);
                make.size.equalTo(self.labelLeft.size);
            }];
            
             [self.labelLeftSub makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.labelLeft);
                make.size.equalTo(self.labelLeft.frame.size);;
                make.bottom.equalTo(self.contentView).offset(-kY_GAP);
             }];
            
              [self.textView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.labelLeft);
                make.left.equalTo(self.labelLeft.right).offset(kPadding);
                make.right.equalTo(self.contentView).offset(-kX_GAP);
                make.bottom.equalTo(self.contentView).offset(-kY_GAP);
              }];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -textView

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return true;

}

- (void)textViewDidChange:(UITextView *)textView{
    self.labelLeftSub.text = [NSString stringWithFormat:@"%@/%@",@(textView.text.length),@(self.wordCount)];

}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@""]) {
        return true;
    }
    if ([text isEqualToString:@"\n"]) {
        [UIApplication.sharedApplication.keyWindow endEditing:true];
        return false;
    }
    if (range.location > self.wordCount) {
        return false;
    }
    return true;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (self.block) {
        self.block(self, textView);
    }

}

#pragma mark - -layz


@end

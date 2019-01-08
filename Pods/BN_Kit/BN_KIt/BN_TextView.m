//
//  BN_TextView.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/25.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BN_TextView.h"

//static CGFloat padding = 8.0;

@interface BN_TextView ()

@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, assign) CGFloat padding;

@end

@implementation BN_TextView

-(UILabel *)placeHolderLabel{
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _placeHolderLabel.font = self.font;
        _placeHolderLabel.numberOfLines = 0;
        _placeHolderLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _placeHolderLabel.backgroundColor = UIColor.clearColor;
        
        _placeHolderLabel.textColor = [UIColor lightTextColor];
        
        _placeHolderLabel.hidden = NO;
        
    }
    return _placeHolderLabel;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.placeholder = @"";
        self.placeholderColor = UIColor.lightGrayColor;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
        [self addSubview:self.placeHolderLabel];
        
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification{
    if (self.text.length == 0) {
        self.placeHolderLabel.hidden = NO;
        
    } else {
        self.placeHolderLabel.hidden = YES;
        
    }
}

-(void)setText:(NSString *)text{
    [super setText:text];
    [self textChanged:nil];
    
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeHolderLabel.font = font;
}

-(void)setPlaceholder:(NSString *)placeholder{
    if ([placeholder isEqualToString:@""]) return;
    
    [self textChanged:nil];
    self.placeHolderLabel.text = placeholder;
    self.placeHolderLabel.textColor = self.placeholderColor ? : UIColor.lightGrayColor;

    [self.placeHolderLabel sizeToFit];
//    CGSize labelSize = [self sizeWithText:placeholder font:self.font width:CGRectGetWidth(self.bounds)];
//    self.placeHolderLabel.frame = CGRectMake(padding, padding, labelSize.width, labelSize.height);

}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    self.placeHolderLabel.textColor = placeholderColor;
    
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];

    if (self.text.length == 0 && self.placeHolderLabel.text.length > 0) {
        self.placeHolderLabel.hidden = NO;
        
    } else {
        self.placeHolderLabel.hidden = YES;

    }
    
}

//#pragma mark - -
//- (CGSize)sizeWithText:(id)text font:(id)font width:(CGFloat)width{
//    NSAssert([text isKindOfClass:[NSString class]] || [text isKindOfClass:[NSAttributedString class]], @"请检查text格式!");
//    NSAssert([font isKindOfClass:[UIFont class]] || [font isKindOfClass:[NSNumber class]], @"请检查font格式!");
//
//    if ([font isKindOfClass:[NSNumber class]]) {
//        font = [UIFont systemFontOfSize:[(NSNumber *)font floatValue]];
//
//    }
//
//    NSDictionary *attrDict = [self attrParaDictWithFont:font textColor:UIColor.blackColor alignment:NSTextAlignmentLeft];
//    CGSize size = CGSizeZero;
//    if ([text isKindOfClass:[NSString class]]) {
//        size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrDict context:nil].size;
//
//    } else {
//        size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
//
//    }
//    size.width = ceil(size.width);
//    size.height = ceil(size.height);
//
//    return size;
//}


@end

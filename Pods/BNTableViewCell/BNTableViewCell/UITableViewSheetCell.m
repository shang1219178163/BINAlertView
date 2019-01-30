//
//  UITableViewSheetCell.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UITableViewSheetCell.h"

#import "NSString+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation UITableViewSheetCell

- (void)dealloc
{
    [self.sheetView.labelLeft removeObserver:self forKeyPath:@"text"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.sheetView];
        [self.sheetView.labelLeft addObserver:self forKeyPath:@"text" options: NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

#pragma mark -observe
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        self.sheetView.labelLeft.attributedText = [self.sheetView.labelLeft.text toAsterisk];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(BNSheetView *)sheetView{
    if (!_sheetView) {
        _sheetView = [[BNSheetView alloc]initWithFrame:self.bounds];
        _sheetView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    }
    return _sheetView;
}
@end

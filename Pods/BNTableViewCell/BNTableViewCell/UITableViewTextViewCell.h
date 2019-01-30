//
//  UITableViewTextViewCell.h
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "UIView+Helper.h"

/**
 UTextView
 */
@interface UITableViewTextViewCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic, assign) NSInteger wordCount;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) void(^block)(UITableViewTextViewCell *view, UITextView * textView);

@end


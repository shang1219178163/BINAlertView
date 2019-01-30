//
//  UITableViewSenventySevenCell.h
//  
//
//  Created by BIN on 2018/4/28.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITableViewCell+AddView.h"
#import "BNAddPictureView.h"

/**
 文字
 +图片选择器
 */
@interface UITableViewSenventySevenCell : UITableViewCell

@property (nonatomic, strong) BNAddPictureView * pictureView;

@end

//
//  BNCellDefaultView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNCellDefaultView : UIView

@property (nonatomic, strong) UIImageView * imgViewLeft;
@property (nonatomic, strong) UIImageView * imgViewRight;
@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) UILabel * labelRight;

@property (nonatomic, strong) NSNumber * type;//0,labelRight右对齐;1左对齐

@end

NS_ASSUME_NONNULL_END

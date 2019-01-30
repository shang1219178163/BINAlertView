//
//  BNSearchView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/24.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BNSearchView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, strong) UITextField * textField;

@property (nonatomic, copy) NSString * queryStr;

@end



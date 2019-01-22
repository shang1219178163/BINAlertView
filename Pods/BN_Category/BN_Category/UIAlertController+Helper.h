//
//  UIAlertController+Helper.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/17.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Helper)

+ (instancetype)showAlertTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg placeholders:(NSArray *_Nullable)placeholders actionTitles:(NSArray *_Nullable)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler;

+ (instancetype)showSheetTitle:(NSString *_Nullable)title msg:(NSString *_Nullable)msg actionTitles:(NSArray *_Nonnull)actionTitles handler:(void(^)(UIAlertController * _Nonnull alertVC, UIAlertAction * _Nonnull action))handler;

@end


//
//  MBProgressHUD+Helper.m
//  WeiHouBao
//
//  Created by hsf on 2017/8/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "MBProgressHUD+Helper.h"
#import <objc/runtime.h>

#import "UIView+Toast.h"
#import "NSObject+Helper.h"

@implementation MBProgressHUD (Helper)

-(BlockCompletion)blockCompletion{
    return objc_getAssociatedObject(self, _cmd);
    
}

-(void)setBlockCompletion:(BlockCompletion)blockCompletion{
    objc_setAssociatedObject(self, @selector(blockCompletion), blockCompletion, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

+ (MBProgressHUD *)showHUDAddedToView:(UIView *)view animated:(BOOL)animated{
    
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    if ([MBProgressHUD HUDForView:keyWindow]) {
        MBProgressHUD * hud = [MBProgressHUD HUDForView:keyWindow];
        [hud hideAnimated:YES];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:animated];
    hud.label.text = NSLocalizedString(kMsg_NetWorkRequesting, @"HUD loading title");
        
    return hud;
}

//+ (MBProgressHUD *)showHUDAddedToView:(UIView *)view animated:(BOOL)animated{
////有问题待研究
//    __block MBProgressHUD * hud = nil;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
//        if ([MBProgressHUD HUDForView:keyWindow]) {
//            hud = [MBProgressHUD HUDForView:keyWindow];
//            //        [hud hideAnimated:YES];
//        }else{
//            hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:animated];
//            hud.label.text = NSLocalizedString(kMsg_NetWorkRequesting, @"HUD loading title");
//
//        }
//    });
//    DDLog(@"hud__%@",hud);
//    return hud;
//}

- (void)changeHUDtext:(NSString *)text{
    [self changeHUDtext:text detailText:nil duration:0.0];

}

- (void)changeHUDtext:(NSString *)text detailText:(NSString *)detailText{
    [self changeHUDtext:text detailText:text duration:0.0];
    
}

- (void)changeHUDtext:(NSString *)text detailText:(NSString *)detailText duration:(CGFloat)duration{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (text) self.label.text = NSLocalizedString(text, @"HUD loading title");
        if (detailText) self.detailsLabel.text = NSLocalizedString(detailText, @"HUD loading title");
     
    });
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [self hideAnimated:YES];
        
    });

}

+ (void)showHUDinView:(UIView *)inView animated:(BOOL)animated{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
        if (keyWindow == nil) {
            keyWindow = [[[UIApplication sharedApplication]delegate]window];
        }
        
        if ([MBProgressHUD HUDForView:inView]) {
            MBProgressHUD * hud = [MBProgressHUD HUDForView:inView];
            [hud hideAnimated:YES];
        }
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:animated];
        hud.label.text = NSLocalizedString(kMsg_NetWorkRequesting, @"HUD loading title");
    });
}

+ (void)hideHUD:(MBProgressHUD *)hud animated:(BOOL)animated{
    dispatch_async(dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
        
    });
}

+ (void)showToastWithTips:(NSString *)tips inView:(UIView *)inView{
    [self showToastWithTips:tips place:@1];

}

+ (void)showToastWithTips:(NSString *)tips place:(id)place{

    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        
        if ([MBProgressHUD HUDForView:keyWindow]) {
            MBProgressHUD * hud = [MBProgressHUD HUDForView:keyWindow];
            [hud hideAnimated:YES];
        }
        NSString * msg = tips ? tips : kMsg_NetWorkFailed;
        
        //添加在window上可以通用于多个导航控制器的情况
        NSString * position = (NSString *)CSToastPositionCenter;
        NSDictionary * dict = @{
                                @"0" : CSToastPositionTop,
                                @"1" : CSToastPositionCenter,
                                @"2" : CSToastPositionBottom,
                                };
        if ([place isKindOfClass:[NSNumber class]] && [dict.allKeys containsObject:[place stringValue]]){
            position = dict[[place stringValue]];
            
        }
        else if ([place isKindOfClass:[NSValue class]]){
            position = [place pointerValue];
            
        }
        
        CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
        style.titleColor = [UIColor whiteColor];
        style.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];//white 0-1为黑到白,alpha透明度
        style.cornerRadius = 5.0;
       
        [keyWindow makeToast:msg duration:kAnimationDuration_Toast position:position style:style];
        
    });
}


@end

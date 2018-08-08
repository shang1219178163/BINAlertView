//
//  MacroBIN.h
//  HuiZhuBang
//
//  Created by 晁进 on 17-7-26.
//  Copyright (c) 2017年 WeiHouKeJi. All rights reserved.
//

#ifndef HuiZhuBang_MacroBN_h
#define HuiZhuBang_MacroBN_h

#define kX_GAP_BTN  20
#define kH_BtnView  40

#define kDDLogFuncton   DDLog(@"%@,%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd))
#define kDDLogFrame(viewframe)   DDLog(@"Frame__%@",NSStringFromCGRect(viewframe))

//        CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
//        NSLog(@"time__%.02f",time);

#endif

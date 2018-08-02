//
//  MacroBIN.h
//  HuiZhuBang
//
//  Created by 晁进 on 17-7-26.
//  Copyright (c) 2017年 WeiHouKeJi. All rights reserved.
//

#ifndef HuiZhuBang_MacroBIN_h
#define HuiZhuBang_MacroBIN_h


#define kDDLogFuncton   DDLog(@"%@,%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd))
#define kDDLogFrame(viewframe)   DDLog(@"Frame__%@",NSStringFromCGRect(viewframe))

//        CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
//        NSLog(@"time__%.02f",time);

#endif

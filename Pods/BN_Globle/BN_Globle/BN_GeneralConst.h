//
//  BN_GeneralConst.h
//  HuiZhuBang
//
//  Created by hsf on 2018/5/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const kNIl_TEXT ;

#pragma mark - - kSet

UIKIT_EXTERN NSString * const kSet_number ;
UIKIT_EXTERN NSString * const kSet_alpha ;
UIKIT_EXTERN NSString * const kSet_alpha_num ;

#pragma mark - - kTag

UIKIT_EXTERN const NSInteger kTAG_LABEL ;
UIKIT_EXTERN const NSInteger kTAG_BTN ;
UIKIT_EXTERN const NSInteger kTAG_BTN_RightItem ;
UIKIT_EXTERN const NSInteger kTAG_BTN_BackItem ;

UIKIT_EXTERN const NSInteger kTAG_IMGVIEW ;
UIKIT_EXTERN const NSInteger kTAG_TEXTFIELD ;
UIKIT_EXTERN const NSInteger kTAG_TEXTVIEW ;
UIKIT_EXTERN const NSInteger kTAG_ALERT_VIEW ;
UIKIT_EXTERN const NSInteger kTAG_ACTION_SHEET ;
UIKIT_EXTERN const NSInteger kTAG_PICKER_VIEW ;
UIKIT_EXTERN const NSInteger kTAG_DATE_PICKER ;

UIKIT_EXTERN const NSInteger kTAG_VIEW ;
UIKIT_EXTERN const NSInteger kTAG_VIEW_Segment ;
UIKIT_EXTERN const NSInteger kTAG_VIEW_RADIO ;
UIKIT_EXTERN const NSInteger kTAG_VIEW_Picture ;

UIKIT_EXTERN const NSInteger kTAG_UItableViewCell ;

UIKIT_EXTERN const NSInteger kTAG_ICAROUSEL ;
UIKIT_EXTERN const NSInteger kTAG_PAGE_CONTROL ;

#pragma mark - -MacroGeometry与计算有关的尺寸属性

UIKIT_EXTERN const CGFloat kH_StatusBar ;
UIKIT_EXTERN const CGFloat kH_NaviagtionBar ;
UIKIT_EXTERN const CGFloat kH_TabBar ;
UIKIT_EXTERN const CGFloat kH_PickerView;
UIKIT_EXTERN const CGFloat kH_SegmentOfCustom ;
UIKIT_EXTERN const CGFloat kH_SegmentControl;

UIKIT_EXTERN const CGFloat kH_searchBar;
UIKIT_EXTERN const CGFloat kH_searchBarBackgroud;

UIKIT_EXTERN const CGFloat kH_topView;
UIKIT_EXTERN const CGFloat kH_slideView;
UIKIT_EXTERN const CGFloat kH_CellHeight ;

UIKIT_EXTERN const CGFloat kX_GAP ;
UIKIT_EXTERN const CGFloat kY_GAP ;
UIKIT_EXTERN const CGFloat kPadding ;
UIKIT_EXTERN const CGFloat kW_LayerBorder ;
UIKIT_EXTERN const CGFloat kWH_ArrowRight ;
UIKIT_EXTERN const CGFloat kTimerValue ;
UIKIT_EXTERN const CGFloat kRatio_IDCard ;
UIKIT_EXTERN const CGFloat kAnimationDuration_Toast ;
UIKIT_EXTERN const CGFloat kAnimationDuration_Drop ;
UIKIT_EXTERN const CGFloat kLeftMenuRatio ;

UIKIT_EXTERN const CGFloat kW_item ;
UIKIT_EXTERN const CGFloat kW_progressView ;

UIKIT_EXTERN const CGFloat kH_LABEL ;
UIKIT_EXTERN const CGFloat kH_LABEL_TITLE ;
UIKIT_EXTERN const CGFloat kH_LABEL_SMALL ;

UIKIT_EXTERN const CGFloat kH_TEXTFIELD ;
UIKIT_EXTERN const CGFloat kH_LINE_VIEW ;
UIKIT_EXTERN const CGFloat kW_LINE_Vert ;

#pragma mark - -font

UIKIT_EXTERN const CGFloat KFZ_First ;
UIKIT_EXTERN const CGFloat KFZ_Second ;
UIKIT_EXTERN const CGFloat KFZ_Third ;
UIKIT_EXTERN const CGFloat KFZ_Fouth ;
UIKIT_EXTERN const CGFloat KFZ_Fifth ;

#pragma mark - -视图

UIKIT_EXTERN NSString * const kIMAGE_arrowRight;
UIKIT_EXTERN NSString * const kIMAGE_arrowDown;
UIKIT_EXTERN NSString * const kIMAGE_arrowBack;

UIKIT_EXTERN NSString * const kIMAGE_default_User;
UIKIT_EXTERN NSString * const kIMAGE_default_User_N;
UIKIT_EXTERN NSString * const kIMAGE_default_User_H;
UIKIT_EXTERN NSString * const kIMAGE_defaultAddPhoto;
UIKIT_EXTERN NSString * const kIMAGE_photoDelete;

UIKIT_EXTERN NSString * const kIMAGE_default_failed;
UIKIT_EXTERN NSString * const kIMAGE_default_failed_S;

UIKIT_EXTERN NSString * const kIMAGE_SexBoy;
UIKIT_EXTERN NSString * const kIMAGE_SexGril;

UIKIT_EXTERN NSString * const kIMAGE_elemetDecrease;
UIKIT_EXTERN NSString * const kIMAGE_elemetIncrease;

UIKIT_EXTERN NSString * const kIMAGE_scan ;
UIKIT_EXTERN NSString * const kIMAGE_NFC ;
UIKIT_EXTERN NSString * const kIMAGE_update ;
UIKIT_EXTERN NSString * const kIMAGE_inquiry ;
UIKIT_EXTERN NSString * const kIMAGE_warning ;

UIKIT_EXTERN NSString * const kMsg_NetWorkRequesting;
UIKIT_EXTERN NSString * const kMsg_NetWorkFailed;
UIKIT_EXTERN NSString * const kMsg_NetWorkNodata;
UIKIT_EXTERN NSString * const kMsg_NetWorkNoMoredata;
UIKIT_EXTERN NSString * const kMsg_NetWorkFailed_Params;

UIKIT_EXTERN NSString * const kMsg_Locationing;
UIKIT_EXTERN NSString * const kMsg_LocationSuccess;
UIKIT_EXTERN NSString * const kMsg_LocationFailed;
UIKIT_EXTERN NSString * const kMsg_IDCardFailed;
UIKIT_EXTERN NSString * const kMsg_IDCardSuccess;


UIKIT_EXTERN NSString * const kActionTitle_Know;
UIKIT_EXTERN NSString * const kActionTitle_Sure;
UIKIT_EXTERN NSString * const kActionTitle_Cancell;
UIKIT_EXTERN NSString * const kActionTitle_Delete;
UIKIT_EXTERN NSString * const kActionTitle_Drop;
UIKIT_EXTERN NSString * const kActionTitle_Call;
UIKIT_EXTERN NSString * const kActionTitle_Update;

UIKIT_EXTERN NSString * const kActionTitle_Collect;
UIKIT_EXTERN NSString * const kActionTitle_Recover;

#pragma mark - - 通用

UIKIT_EXTERN NSString * const kDes_week ;

UIKIT_EXTERN NSString * const kItem_obj ;
UIKIT_EXTERN NSString * const kItem_objSeleted ;
UIKIT_EXTERN NSString * const kItem_block ;

UIKIT_EXTERN NSString * const kItem_title ;
UIKIT_EXTERN NSString * const kItem_titleColor ;
UIKIT_EXTERN NSString * const kItem_textField ;

UIKIT_EXTERN NSString * const kItem_titleSub ;
UIKIT_EXTERN NSString * const kItem_titleSubColor ;
UIKIT_EXTERN NSString * const kItem_titleSection ;

UIKIT_EXTERN NSString * const kItem_image ;
UIKIT_EXTERN NSString * const kItem_image_H ;

UIKIT_EXTERN NSString * const kItem_controller ;
UIKIT_EXTERN NSString * const kItem_controller_Title ;

UIKIT_EXTERN NSString * const kItem_Height ;
UIKIT_EXTERN NSString * const kItem_dataList ;
UIKIT_EXTERN NSString * const kItem_finished ;

UIKIT_EXTERN NSString * const kItem_header ;
UIKIT_EXTERN NSString * const kItem_footer ;
/**
 推送通知
 */
UIKIT_EXTERN NSString * const kNoti_title;
UIKIT_EXTERN NSString * const kNoti_subtitle;
UIKIT_EXTERN NSString * const kNoti_body;
UIKIT_EXTERN NSString * const kNoti_badge;


/**
 通知
 */
UIKIT_EXTERN NSString * const kNotiPost_logIn;
UIKIT_EXTERN NSString * const kNotiPost_logOut;
UIKIT_EXTERN NSString * const kNotiPost_backgroudUploadLocation ;

@interface BN_GeneralConst : NSObject

@end

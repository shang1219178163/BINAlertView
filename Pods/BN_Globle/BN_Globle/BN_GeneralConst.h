//
//  BN_GeneralConst.h
//  HuiZhuBang
//
//  Created by hsf on 2018/5/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - - kSet

UIKIT_EXTERN NSString * const kSet_number ;
UIKIT_EXTERN NSString * const kSet_alpha ;
UIKIT_EXTERN NSString * const kSet_alpha_num ;

#pragma mark - - File

UIKIT_EXTERN const NSInteger kPageSize ;
UIKIT_EXTERN const NSInteger kFileSize_image ;

//plist文件路径
UIKIT_EXTERN NSString * const kPlistFilePath ;
//plist文件名
UIKIT_EXTERN NSString * const kPlistName_common ;
UIKIT_EXTERN NSString * const kPlistKey_vehicleTypeDict ;
UIKIT_EXTERN NSString * const kPlistKey_vehicleTypeArr ;
UIKIT_EXTERN NSString * const kPlistKey_vehicleTypeIconArr ;

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

UIKIT_EXTERN const NSInteger kComponent_0 ;
UIKIT_EXTERN const NSInteger kComponent_1 ;
UIKIT_EXTERN const NSInteger kComponent_2 ;


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
UIKIT_EXTERN const CGFloat kRatio_LeftMenu ;

UIKIT_EXTERN const CGFloat kAnimDuration;
UIKIT_EXTERN const CGFloat kAnimDuration_Toast ;
UIKIT_EXTERN const CGFloat kAnimDuration_Drop ;

UIKIT_EXTERN const CGFloat kW_item ;
UIKIT_EXTERN const CGFloat kW_progressView ;

UIKIT_EXTERN const CGFloat kH_LABEL ;
UIKIT_EXTERN const CGFloat kH_LABEL_TITLE ;
UIKIT_EXTERN const CGFloat kH_LABEL_SMALL ;

UIKIT_EXTERN const CGFloat kH_TEXTFIELD ;
UIKIT_EXTERN const CGFloat kH_LINE_VIEW ;
UIKIT_EXTERN const CGFloat kW_LINE_Vert ;

#pragma mark - -font

UIKIT_EXTERN const CGFloat kFZ_First ;
UIKIT_EXTERN const CGFloat kFZ_Second ;
UIKIT_EXTERN const CGFloat kFZ_Third ;
UIKIT_EXTERN const CGFloat kFZ_Fouth ;
UIKIT_EXTERN const CGFloat kFZ_Fifth ;

#pragma mark - -视图

UIKIT_EXTERN NSString * const kIMG_arrowRight ;
UIKIT_EXTERN NSString * const kIMG_arrowDown ;
UIKIT_EXTERN NSString * const kIMG_arrowBack ;
UIKIT_EXTERN NSString * const kIMG_arrowUp ;

UIKIT_EXTERN NSString * const kIMG_portrait ;
UIKIT_EXTERN NSString * const kIMG_portrait_N ;
UIKIT_EXTERN NSString * const kIMG_portrait_H ;
UIKIT_EXTERN NSString * const kIMG_pictureAdd ;
UIKIT_EXTERN NSString * const kIMG_pictureDelete ;

UIKIT_EXTERN NSString * const kIMG_defaultFailed ;
UIKIT_EXTERN NSString * const kIMG_defaultFailed_S ;

UIKIT_EXTERN NSString * const kIMG_sexBoy ;
UIKIT_EXTERN NSString * const kIMG_sexGril ;

UIKIT_EXTERN NSString * const kIMG_elemetDec ;
UIKIT_EXTERN NSString * const kIMG_elemetInc ;

UIKIT_EXTERN NSString * const kIMG_scan ;
UIKIT_EXTERN NSString * const kIMG_NFC ;

UIKIT_EXTERN NSString * const kIMG_inquiry ;
UIKIT_EXTERN NSString * const kIMG_update ;
UIKIT_EXTERN NSString * const kIMG_warning ;

UIKIT_EXTERN NSString * const kIMG_notice ;
UIKIT_EXTERN NSString * const kIMG_location_H ;
UIKIT_EXTERN NSString * const kIMG_more ;

UIKIT_EXTERN NSString * const kIMG_selected_NO ;
UIKIT_EXTERN NSString * const kIMG_selected_YES ;
UIKIT_EXTERN NSString * const kIMG_Add ;

UIKIT_EXTERN NSString * const kIMG_like_H ;
UIKIT_EXTERN NSString * const kIMG_like_W ;

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

UIKIT_EXTERN NSString * const kNIl_TEXT ;
UIKIT_EXTERN NSString * const kSeparateStr ;
UIKIT_EXTERN NSString * const kAsterisk ;
UIKIT_EXTERN NSString * const kBlankHalf ;
UIKIT_EXTERN NSString * const kBlankOne ;
UIKIT_EXTERN NSString * const kBlankTwo ;
UIKIT_EXTERN NSString * const kBlankFour ;

#pragma mark - - 通用

UIKIT_EXTERN NSString * const kDes_week ;
UIKIT_EXTERN NSString * const kDes_month ;
UIKIT_EXTERN NSString * const kDes_day ;

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

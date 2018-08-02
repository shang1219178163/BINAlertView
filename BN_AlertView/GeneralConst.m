//
//  GeneralConst.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "GeneralConst.h"

#pragma mark - - kTag

const NSInteger kTAG_LABEL = 100;
const NSInteger kTAG_BTN = 200;
const NSInteger kTAG_BTN_RightItem = 260;
const NSInteger kTAG_BTN_BackItem = 261;

const NSInteger kTAG_IMGVIEW = 300;
const NSInteger kTAG_TEXTFIELD = 400;
const NSInteger kTAG_TEXTVIEW = 500;
const NSInteger kTAG_ALERT_VIEW = 600;
const NSInteger kTAG_ACTION_SHEET = 700;
const NSInteger kTAG_PICKER_VIEW = 800;
const NSInteger kTAG_DATE_PICKER = 900;

const NSInteger kTAG_VIEW = 1000;
const NSInteger kTAG_VIEW_Segment = 1100;
const NSInteger kTAG_VIEW_RADIO = 1200;
const NSInteger kTAG_VIEW_Picture = 1300;

const NSInteger kTAG_UItableViewCell = 1500;

const NSInteger kTAG_ICAROUSEL = 950;
const NSInteger kTAG_PAGE_CONTROL = 951;

#pragma mark - -MacroGeometry与计算有关的尺寸属性

const CGFloat kH_StatusBar = 20;
const CGFloat kH_NaviagtionBar = 44;
const CGFloat kH_TabBar = 49;

const CGFloat kXY_GAP = 15;
const CGFloat kX_GAP = 10;
const CGFloat kY_GAP = 10;
const CGFloat kPadding = 8.0;

const CGFloat kW_LayerBorderWidth = 0.5;
const CGFloat kWH_ArrowRight = 25;
const CGFloat kTimerValue = 65;
const CGFloat kRatio_IDCard = 1.58;
const CGFloat kAnimationDuration_Toast = 1.5;
const CGFloat kAnimationDuration_Drop = 0.5;

const CGFloat kH_CellHeight = 60;


const CGFloat kW_item = 90;
const CGFloat kW_progressView = 130;

const CGFloat kH_LABEL = 25;
const CGFloat kH_LABEL_TITLE = 30;
const CGFloat kH_LABEL_SMALL = 20;

const CGFloat kH_TEXTFIELD = 30;
const CGFloat kH_LINE_VIEW =  1/3.0;
const CGFloat kW_LINE_Vert =  3.0;


#pragma mark - -font

const CGFloat KFZ_First =  18;
const CGFloat KFZ_Second = 16;
const CGFloat KFZ_Third =  14;
const CGFloat KFZ_Fouth =  12;
const CGFloat KFZ_Fifth =  10;

#pragma mark - -视图

NSString * const kIMAGE_arrowRight = @"img_arrowRight.png";
NSString * const kIMAGE_arrowDown = @"img_arrowDown_black.png";
NSString * const kIMAGE_arrowBack = @"img_btnBack.png";
NSString * const kIMAGE_default = @"img_headPortrait.png";
NSString * const kIMAGE_default_User = @"img_headPortrait_O.png";
NSString * const kIMAGE_defaultAddPhoto = @"img_photoAddDefault.png";
NSString * const kIMAGE_photoDelete = @"img_Picture_Delete.png";

NSString * const kIMAGE_default_failed = @"imageFailedDefault.png";
NSString * const kIMAGE_SexBoy = @"img_sex_boy.png";
NSString * const kIMAGE_SexGril = @"img_sex_gril.png";

NSString * const kIMAGE_elemetDecrease = @"decrease_elemet";
NSString * const kIMAGE_elemetIncrease = @"increase_elemet";

NSString * const kMsg_NetWorkRequesting = @"网络请求中...";
NSString * const kMsg_NetWorkFailed = @"网络请求失败,请稍后再试";
NSString * const kMsg_NetWorkNodata = @"暂无数据";
NSString * const kMsg_NetWorkNoMoredata = @"没有更多数据了";
NSString * const kMsg_NetWorkFailed_Params = @"参数错误,请稍后再试";

NSString * const kMsg_Locationing = @"定位中...";
NSString * const kMsg_LocationSuccess = @"位置信息更新成功!";
NSString * const kMsg_LocationFailed = @"定位失败,请稍后再试";
NSString * const kMsg_IDCardFailed = @"身份证识别失败,请稍后再试";
NSString * const kMsg_IDCardSuccess = @"身份证识别成功";

NSString * const kActionTitle_Sure = @"确定";
NSString * const kActionTitle_Cancell = @"取消";
NSString * const kActionTitle_Delete = @"删除";
NSString * const kActionTitle_collect = @"收藏";

@implementation GeneralConst

@end

//
//  Enum.h
//  DamaiHD
//
//  Created by lixiang on 13-9-26.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#ifndef DamaiHD_Enum_h
#define DamaiHD_Enum_h

typedef enum : NSUInteger{
    DMOrderTypeBusiness = 0,//玩什么订单
    DMOrderTypeDamai = 1,//大麦订单
} DMOrderType;

typedef enum : NSUInteger{
    DMIndexPageTypeCommon = 1,//精选
    DMIndexPageTypeToday = 2,//今天
    DMIndexPageTypeNear = 3,//附近
} DMIndexPageType;

//专题类型0普通项目，1随意跳，2WEB活动页，3专题,4艺人,5帖子
typedef enum : NSUInteger{
    DMSubjectCommon = 0,
    DMSubjectHuodong = 1,
    DMSubjectZhuban = 2,
    DMSubjectMingxing = 3,
    DMSubjectChangguan = 4,
    DMSubjectZhuanti = 5,
    DMSubjectURL = 6,//需要登陆
    DMSubjectURLNoLog = 61,//不需要登陆
} DMSubjectType;

//项目来源
typedef enum : NSUInteger{
    DMProjectSourceDouBan,      //豆瓣
    DMProjectSourceDaMai,       //大麦
    DMProjectSource             //商家自发布
} DMProjectSourceType;

typedef enum {
    DMProjectPriceValid,         //有效
    DMProjectPriceForbid,        //禁售
    DMProjectPriceHidden1,       //隐藏
    DMProjectPriceHidden2        //隐藏2
} DMProjectPriceStatus;

typedef enum {
    DMLoginFromFavorate,            //收藏
    DMLoginFromDirectPurchase,      //立即购买
    DMLoginFromSelectSeat,          //选座
    DMLoginFromSaleNotify,           //开票通知
    DMConfirmOrderNotify,           //确认订单
    DMOutOfRegisterNotify,           //缺货登记

    DMSubmitOrderNotify,           //下单
    DMLoginFromUserCenter,          //正常模式下登录
    DMLoginFromOtherPage,          //其他页面触发的登录

    DMRegFromUserLogin,           //这个属性针对注册页面的转入（其他地方不要使用）
    DMLoginFromPrivilege          //来自特权的登录
} DMLoginSource;

typedef enum {
    DMShareTypeSina,            //分享到新浪
    DMShareTypeWeixin,          //分享到微信
    DMShareTypeTimeline         //分享到微信朋友圈
} DMShareType;

typedef NS_ENUM(NSUInteger, DMPayType) {
    CODPay = 1, //货到付款
    AliPay = 2, //支付宝客户端支付
    WapPay = 3, //支付宝网页支付
    ePay = 9,   //大麦钱包支付
    WXPay = 5,   //微信支付
    UnionPay = 8,    //银联支付
    ZhongGuoYinHangPay = 12   //中国银行支付
};

typedef enum {
    DMSeatNormal = 2,           //正常状态
    DMSeatLocked = 4,           //被锁定状态
    DMSeatSoldout = 6,          //售完
    DMSeatNone = 8              //售完
} DMSeatState;

typedef NS_ENUM(NSUInteger, DMPushType){
    DMPushIndex = 2,            //跳转到首页
    DMPushProjectDetail = 3,    //跳转到项目详情页
    DMPushProjectList = 4,      //跳转到项目列表页
    DMPushWebpage = 5,          //跳转到web页
    DMPushOrderDetail = 6       //跳转到订单详情
};

typedef enum {
    fromUserCenter,//从用户中心
    fromCreateOrder//从订单详情
}   DMOpenAddressFrom;

/// 抢座状态 1等待分组 2已分组，等待开始 3进行中 4已结束
typedef NS_ENUM(NSUInteger, DMJinPaiStatus){
    DMJinPaiStatusNone = 0,
    DMJinPaiStatusWaitGroup = 1,
    DMJinPaiStatusWaitStart = 2,
    DMJinPaiStatusStarting = 3,
    DMJinPaiStatusOver = 4
};

//窗格广告类型
typedef NS_ENUM(NSUInteger, DMPaneType){
    DMSinglePaneType = 1,
    DMDoubleHorizontalPaneType = 2,
    DMDoubleVerticalBigPaneType = 8,
    DMTriplePaneType = 3,
    DMTripleReversePaneType = 5,
    DMFourPaneType = 4,
    DMCounterPaneType = 7,
    DMHotestPaneType = 6,
    DMOtherPaneType
};

//二级列表页
typedef enum {
    DMSubProjectListNormal,//通用
    DMSubProjectListIndexPage,//专题
    DMSubProjectListMap,//地图
    DMSubProjectListCalendarPage,//日历
    DMSubProjectListHotArtist//专题
}   DMSubProjectList;

//粉丝圈列表类型
typedef enum {
    DMFansClubTypeTiezi = 1,//帖子
    DMFansClubTypeXingcheng = 2,//行程
    DMFansClubTypeFans = 3,//粉丝
}   DMFansClubType;

typedef NS_ENUM(NSUInteger, DMPhotoFilterType) {
    DMPhotoFilterNormal,
    DMPhotoFilterLomo,
    DMPhotoFilterYears,
    DMPhotoFilterAxis,
    DMPhotoFilterBW,
    DMPhotoFilterFilm,
    DMPhotoFilterIndigo,
    DMPhotoFilterSunlight
};

//话题列表cell
typedef enum {
    DMFansClubCellTypeClub = 1,//话题列表
    DMFansClubCellTypeDetail = 2,//话题详情
    DMFansClubCellTypeCenter = 3,//粉丝个人中心
} DMFansClubCellType;

#endif

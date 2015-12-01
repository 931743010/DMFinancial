//
//  Enum.h
//  DamaiHD
//
//  Created by lixiang on 13-9-26.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#ifndef DamaiHD_Enum_h
#define DamaiHD_Enum_h

typedef NS_ENUM(NSUInteger, DMTabControllerSelectedIndex) {
    DMIndexPageIndex = 0,
    DMManagementPageIndex = 1,
    //    DMCalendarPageIndex = 2,
    //    DMLivePageIndex = 2,
    DMChatPageIndex = 2,
    DMUserCenterPageIndex = 3,
    
};

//资产类型
typedef NS_ENUM(NSInteger, DMAssetsType) {
    DMAssetsType1,//货币基金(宝宝类)
    DMAssetsType2,//基金
    DMAssetsType3,//股票
    DMAssetsType4,//P2P
    DMAssetsType5,//银行理财
    DMAssetsType6,//保险
    DMAssetsType7,
    DMAssetsType8,
    DMAssetsType9,
    DMAssetsType10,

};

//精选跳转类型
typedef enum : NSUInteger{
    DMSubjectCommon = 0,    //
    DMSubjectHuodong = 1,   //活动详情
    DMSubjectZhuban = 2,    //主办
    DMSubjectMingxing = 3,  //明星
    DMSubjectChangguan = 4, //场馆
    DMSubjectZhuantiHtml = 5,   //专题web页面
    DMSubjectURL = 6,       //需要登陆url
    DMSubDijia = 7,         //跳转到低价
    DMSubjectZhuantiList = 9,   //专题 根据专题id获取专题列表
} DMSubjectType;

#endif

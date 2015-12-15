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
    /*
        货币基金(宝宝类)
     */
    DMAssetsType1 = 0,//货币基金(宝宝类)
    DMAssetsType2 = 1,//基金
    DMAssetsType3 = 2,//P2P
    DMAssetsType4 = 3,//银行理财
    DMAssetsType5 = 4,//保险
    DMAssetsType6 = 5,//保险
    DMAssetsType7 = 6,
    DMAssetsType8 = 7,
    DMAssetsType9 = 8,
    DMAssetsType10 = 9,

};

//精选跳转类型
typedef enum : NSUInteger{
    DMSubjectCommon = 0,    //
    DMSubjectWeb = 1,
} DMSubjectType;

#endif

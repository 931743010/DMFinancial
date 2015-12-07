//
//  Constant.h
//  DamaiHD
//
//  Created by lixiang on 13-9-26.x5
//  Copyright (c) 2013年 damai. All rights reserved.
//

#ifndef DamaiHD_Constant_h
#define DamaiHD_Constant_h

#define DISTRIBUTION_MODE   //发布模式
#define SHOWLOG           //控制是否打印LOG

#ifndef DISTRIBUTION_MODE
    #define DEBUG_MODE //打开内网测试环境
#else
    #ifndef SHOWLOG
        #define NSLog
    #endif
#endif

/**
 *  API接口地址
 */
#ifdef DEBUG_MODE
    static NSString * const DMAPIBaseURL = @"http://career.bj-yfjn.com/api/";
#else
    static NSString * const DMAPIBaseURL = @"http://career.bj-yfjn.com/api/";
#endif

#ifdef DEBUG_MODE
#warning 现在是调试模式，发布时记得改为发布模式
#endif


#define kMessage                      @"register.php"             //消息列表
#define kIndexPageList                      @"register.php"             //首页列表
#define kHotList                      @"register.php"             //排行榜
#define kNewcomer                      @"register.php"             //新手入门
#define kYangmao                     @"register.php"             //薅羊毛
#define kP2PLib                      @"register.php"             //P2P产品库



/**
 *  百度ApiKey
 */
#define kBaiduAppKey            @"9572a0011715572721fed5533d2776fe"

/**
 *   新浪微博SDK
 */
#define kSinaWeiboAppKey            @"455219753"
#define kSinaWeiboAppSecret         @"6120aa0f8cc35dcade1ad5688128aaea"
#define kSinaWeiboRedirectURI       @"http://www.jtwsm.cn"

/**
 *  微信SDK
 */
#define kWeixinAppID            @"wx9f8bd3778b7e6c6b"
#define kWeixinAppSecret        @"0ae37ef7efb987e02e548bfa6ff77211"
#define kWeixinAccessTokenURL   @"https:/api.weixin.qq.com/sns/oauth2/access_token?"

/**
 *  QQSDK
 */
#define kTencentAppID           @"206444"
#define kTencentAppKey          @"1ceaddb327b8bfbf4383eef18f0c7d22"

/**
 *  通用提示信息
 */
static NSString * const kLoadingText = @"努力加载中";
static NSString * const kLocationDenyError = @"定位功能被关闭！请在设置中开启";
static NSString * const kLocationError = @"定位失败！请稍后再试";
static NSString * const kNetworkErrorText = @"网络连接失败！请检查您的网络设置";
static NSString * const kResourceNotFound = @"服务器异常！请稍后再试";
static NSString * const kErrorForM = @"M值错误";

static NSString * const kAlertTitle = @"";
static NSString * const kNotLogin = @"用户未登录";
static NSString * const kResponseInvalid = @"返回信息有误";
static NSString * const kOrderText = @"订单完成";


/**
 *  错误代码
 */
static int const DMStatusNotLogin           = -1;
static int const DMStatusApiError           = -2;
static int const DMStatusNetworkError       = -3;
static int const DMStatusErrorForM          = -4;
static int const DMStatusOrderDone          = -5;

static int const DMStatusResourceNotFound   = -1011;
static int const DMCommonErrorCode          = -99;


/**
 *  常用颜色字体图片
 */
static NSString * const kPanePlaceHolder        = @"icon_holder_37x37@2x.png";
static NSString * const kPanePlaceHolder_big    = @"icon_holder_57x57@2x.png";
static NSString * const kProjPlaceHolder        = @"project_default_pic.png";
static NSString * const kMemberHeadPlaceholderImage        = @"bg_headPlaceHolder.png";

#define kTableViewBgColor [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1] //灰色背景颜色 f6f6f6
#define kDMPinkColor [UIColor colorWithRed:254.0/255.0 green:96.0/255.0 blue:70.0/255.0 alpha:1] //橙色 fe6046 (程序主色)
#define kDMDefaultBlackStringColor [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1]//主标题颜色(黑色) 666666
#define kDMDefaultGrayStringColor [UIColor colorWithRed:133.0/255.0 green:133.0/255.0 blue:133.0/255.0 alpha:1]//副标题颜色(858585)
#define kDMDefaultLightGrayStringColor [UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1]//浅灰色(b4b4b4)
#define kSeperatorColor [UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1]//分割线颜色(cecece)

static float kSeperatorWidth = 0.5;
static int const kPageSize = 20;

#pragma mark-----------通知---------------------

static NSString * const kAddAssetsNotification = @"AddAssetsNotification";
/**
 *  常用目录
 */
static NSString * const kUserGuideFile = @"/Account/userguide.dat";
//static NSString * const kDMLauchImageDir = @"/LaunchImage";
#define kDMLauchImageDir PATH_AT_CACHEDIR(@"/LaunchImage")

#endif
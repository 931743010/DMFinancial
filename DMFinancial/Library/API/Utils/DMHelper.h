//
//  DMHelper.h
//  DamaiHD
//
//  Created by lixiang on 13-10-12.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMHelper : NSObject

+ (float)AppTopMargin;

/**
 *    清除字符串中的空格
 *
 *    @param String 原字符串
 *
 *    @return 处理后的字符串
 */
+ (NSString *)removeSpace:(NSString *) String;
/**
 *  判断字符串是否为纯整数
 *
 *  @param string
 *
 *  @return
 */
+ (BOOL)isNumeric:(NSString *)string;
/**
 *  判断字符串是否带有两位小数的纯数字
 *
 *  @param string
 *
 *  @return
 */
+ (BOOL)isNumericDecimal:(NSString *)string;

/**
 *  判断是否登录
 *
 *  @param code <#code description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)isLogin;
@end

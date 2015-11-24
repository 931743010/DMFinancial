//
//  CommonHelper.h
//  DamaiHD
//
//  Created by lixiang on 13-10-12.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonHelper : NSObject

/**
 *  将键值对存储到NSUserDefault中
 *
 *  @param value 值
 *  @param key   键
 */
+ (void)setValue:(id)value forKey:(NSString *)key;

/**
 *  将对象对存储到NSUserDefault中
 *
 *  @param object 对象
 *  @param key    键
 */
+ (void)setObject:(NSObject *)object forKey:(NSString *)key;

/**
 *  从NSUserDefault中读取key对应的value
 *
 *  @param key 键
 *
 *  @return 对应的值
 */
+ (id)valueForKey:(NSString *)key;

/**
 *  从NSUserDefault中读取key对应的对象
 *
 *  @param key 键
 *
 *  @return 对应的值
 */
+ (NSObject *)objectForKey:(NSString *)key;
/**
 *  序列化
 *
 *  @param object 对象
 *  @param key    键
 *
 *  @return 序列化后的数据
 */
+ (NSData *)archiverObject:(NSObject *)object forKey:(NSString *)key;

/**
 *  反序列化
 *
 *  @param archivedData 序列化后的数据
 *  @param key          键
 *
 *  @return 反序列化后得到的对象
 */
+ (NSObject *)unarchiverObject:(NSData *)archivedData withKey:(NSString *)key;

/**
 *  创建文件夹
 *
 *  @param folderPath  文件路径
 *  @param isDirectory 是否是目录
 *
 *  @return 是否成功
 */
+ (BOOL)createFolder:(NSString*)folderPath isDirectory:(BOOL)isDirectory;

/**
 *  将二进制数据保存的到文件
 *
 *  @param data 数据
 *  @param path 要保存的文件路径
 *
 *  @return 是否成功
 */
+ (BOOL)saveData:(NSData *)data toFile:(NSString *)path;

/**
 *    清除字符串中的空格
 *
 *    @param String 原字符串
 *
 *    @return 处理后的字符串
 */
+ (NSString *)removeSpace:(NSString *) String;

/**
 *  返回字符串需要占用的高度
 *
 *  @param labelString
 *  @param fontsize
 *  @param width
 *  @param height
 *
 *  @return 
 */
+ (NSInteger)heightForLabelWithString:(NSString *)labelString withFontSize:(UIFont *)fontsize withWidth:(CGFloat)width withHeight:(CGFloat)height;
/**
 *  返回字符串需要占用的宽度
 *
 *  @param labelString
 *  @param fontsize
 *  @param width
 *  @param height
 *
 *  @return 
 */
+ (NSInteger)widthForLabelWithString:(NSString *)labelString withFontSize:(UIFont *)fontsize withWidth:(CGFloat)width withHeight:(CGFloat)height;
/**
 *  返回软件版本号
 *
 *  @return 
 */
+ (int)getLocalAppVersion;
/**
 *  判断字符串是否为纯整数
 *
 *  @param string
 *
 *  @return
 */
+ (BOOL)isNumeric:(NSString *)string;
@end

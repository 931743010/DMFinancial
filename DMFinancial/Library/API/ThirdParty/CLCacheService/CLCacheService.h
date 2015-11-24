//
//  CLCacheService.h
//  CLBooking
//
//  Created by lixiang on 13-12-24.
//  Copyright (c) 2013年 cleexiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLCacheService : NSObject

+ (NSString *)absolutePathOfCacheWithKey:(NSString *)key;

+ (BOOL)existCacheForKey:(NSString *)key path:(NSString **)path;
/**
 *  读取缓存
 *
 *  @param key 缓存的键值
 *
 *  @return 缓存数据
 */
+ (id)readCacheForKey:(NSString *)key error:(NSError **)error;

/**
 *
 *
 *  @param data 数据
 *  @param key 键值
 *
 *  @return 是否成功
 */
+ (NSString *)writeCache:(NSData *)data forKey:(NSString *)key;

/**
 *  写入缓存
 *
 *  @param data         缓存数据
 *  @param key          缓存的键值
 *  @param expireTime   过期时间
 *
 *  @return 是否成功
 */
+ (NSString *)writeCache:(NSData *)data forKey:(NSString *)key expireTime:(NSTimeInterval)expireTime;

/**
 *  删除某个缓存
 *
 *  @param identifier 缓存的唯一di
 *
 *  @return 是否成功
 */
+ (BOOL)removeCacheOfKey:(NSString *)key;
/**
 *  删除所有缓存
 *
 *  @return 是否成功
 */
+ (BOOL)removeAllCache;

@end

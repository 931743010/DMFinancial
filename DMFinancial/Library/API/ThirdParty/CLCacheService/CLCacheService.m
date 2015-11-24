//
//  CLCacheService.m
//  CLBooking
//
//  Created by lixiang on 13-12-24.
//  Copyright (c) 2013年 cleexiang. All rights reserved.
//

#import "CLCacheService.h"
#import <CommonCrypto/CommonDigest.h>

#define DefaultExpireTime 86400

#ifndef kCachePath
    #define kCachePath @"/clCacheData"
#endif

@implementation CLCacheService

+ (NSString *)absolutePathOfCacheWithKey:(NSString *)key {
    NSString *identifier = [CLCacheService generateUIDwithKey:key];
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kCachePath];
    NSError *error = nil;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachePath error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    for (NSString *fileName in files) {
        if ([fileName hasPrefix:identifier]) {
            return [cachePath stringByAppendingPathComponent:fileName];
        }
    }
    return nil;
}

+ (BOOL)existCacheForKey:(NSString *)key path:(NSString **)path {
    NSString *p = [CLCacheService absolutePathOfCacheWithKey:key];
    if (p) {
        *path = p;
        return YES;
    } else {
        *path = nil;
        return NO;
    }
}

+ (NSString *)generateUIDwithKey:(NSString *)key {
    const char* string = [key UTF8String];
    unsigned char result[16];
    CC_MD5(string, strlen(string), result);
    NSString* hash = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                      result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
    return [hash lowercaseString];
}

+ (id)readCacheForKey:(NSString *)key error:(NSError **)error {
    NSString *identifier = [CLCacheService generateUIDwithKey:key];
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kCachePath];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachePath error:error];
    if (error) {
        NSLog(@"%@", [*error localizedDescription]);
    }
    for (NSString *fileName in files) {
        if ([fileName hasPrefix:identifier]) {
            NSArray *arr = [fileName componentsSeparatedByString:@"_"];
            long lastTime = 0;
            if (arr && [arr count] == 2) {
                lastTime = [arr[1] longValue];
            }
            long currentTime = (long)[[NSDate date] timeIntervalSince1970];
            if (currentTime > lastTime) {
                [[NSFileManager defaultManager] removeItemAtPath:[cachePath stringByAppendingPathComponent:fileName]
                                                           error:nil];
                return nil;
            } else {
                return [NSData dataWithContentsOfFile:[cachePath stringByAppendingPathComponent:fileName]];
            }
        }
    }
    return nil;
}


+ (NSString *)writeCache:(NSData *)data forKey:(NSString *)key{
    NSString *identifier = [CLCacheService generateUIDwithKey:key];
    return [CLCacheService writeCache:data expireTime:DefaultExpireTime withIdentifier:identifier];
}


+ (NSString *)writeCache:(NSData *)data forKey:(NSString *)key expireTime:(NSTimeInterval)expireTime {
    NSString *identifier = [CLCacheService generateUIDwithKey:key];
    return [CLCacheService writeCache:data expireTime:expireTime withIdentifier:identifier];
}


+ (NSString *)writeCache:(id)data expireTime:(NSTimeInterval)expireTime withIdentifier:(NSString *)identifier {
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kCachePath];
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:cachePath];
    NSError *err = nil;
    if (!isExist) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&err];
    }
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *path = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%.0f", identifier, time+expireTime]];
    BOOL success = [data writeToFile:path
                             options:NSDataWritingAtomic
                               error:&err];
    if (success) {
        return path;
    } else {
        return nil;
    }
}

+ (BOOL)removeCacheOfKey:(NSString *)key {
    NSString *identifier = [self generateUIDwithKey:key];
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kCachePath];
    NSError *err = nil;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachePath error:&err];
    if (err) {
        NSLog(@"%@", [err localizedDescription]);
    } else {
        for (NSString *fileName in files) {
            if ([fileName hasPrefix:identifier]) {
                BOOL success = [[NSFileManager defaultManager] removeItemAtPath:[cachePath stringByAppendingPathComponent:fileName] error:&err];
                return success;
            }
        }
    }
    return NO;
}

+ (BOOL)removeAllCache {
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:kCachePath];
    NSError *err = nil;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:cachePath error:&err];
    return success;
}

@end

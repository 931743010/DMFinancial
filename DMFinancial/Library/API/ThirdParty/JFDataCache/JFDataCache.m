//
//  JFDataCache.m
//  IndexPagesDemo
//
//  Created by Joseph Fu on 14/11/11.
//  Copyright (c) 2014年 Joseph Fu. All rights reserved.
//

#import "JFDataCache.h"
#import <CommonCrypto/CommonDigest.h>
#import "JFDictionaryToStringTransformer.h"

@interface NSDictionary (GenerateString)
- (NSString *)toString;
@end

@implementation NSDictionary (GenerateString)
- (NSString *)toString {
    NSArray *keys = [self allKeys];
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    NSMutableString *str = [NSMutableString string];
    for (NSString *key in keys) {
        [str appendFormat:@"%@%@", key, [self objectForKey:key]];
    }
    return [str lowercaseString];
}
@end

static NSString * const JFDataCacheDefaultPath = @"/clCacheData";
static NSInteger const JFDataCacheExpireTime = 60 * 20;

@interface JFDataCache () {
    NSFileManager * _fileManager;
    JFDictionaryToStringTransformer * _transformer;
}


@end
@implementation JFDataCache

+ (instancetype)sharedDataCache
{
    static JFDataCache *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
- (id)init
{
    if (self = [super init]) {
        _fileManager = [NSFileManager defaultManager];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _cachePath = [[paths lastObject] stringByAppendingPathComponent:JFDataCacheDefaultPath];
        
        _transformer = [[JFDictionaryToStringTransformer alloc] init];
        [NSValueTransformer setValueTransformer:_transformer forName:JFDictionaryToStringTransformName];
    }
    return self;
}

- (NSString *)fileNameForKey:(NSString *)key
{
    const char* string = [key UTF8String];
    unsigned char result[16];
    CC_MD5(string, (CC_LONG)strlen(string), result);
    NSString* hash = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                      result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
    return [hash lowercaseString];
}

- (NSString *)defaultCachePathForKey:(NSString *)key
{
    NSString *fileName = [self fileNameForKey:key];
    return [self.cachePath stringByAppendingPathComponent:fileName];
}

- (BOOL)dataExistsWithKey:(NSString *)key
{
    return [_fileManager fileExistsAtPath:[self defaultCachePathForKey:key]];
}

- (BOOL)isExpiredDataForKey:(NSString *)key withExpireTime:(NSInteger)expireTime
{    
    if ([self dataExistsWithKey:key]) {
        NSDictionary *attributes = [_fileManager attributesOfItemAtPath:[self defaultCachePathForKey:key]
                                                                  error:nil];
        
        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:[attributes fileModificationDate]];
        
        return interval > (expireTime == 0 ? JFDataCacheExpireTime : expireTime);
    }
    else {
        return YES;
    }
}

- (void)writeData:(id)data forKey:(NSString *)key
{

    [self writeData:data forKey:key withCompletion:nil];
}

- (void)writeData:(id)data forKey:(NSString *)key withCompletion:(void (^)(NSString *))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *cacheData = data;
        
        if (cacheData) {
            
            if (![_fileManager fileExistsAtPath:_cachePath]) {
                [_fileManager createDirectoryAtPath:_cachePath
                        withIntermediateDirectories:YES
                                         attributes:nil
                                              error:NULL];
            }
            
            NSString *filePath = [self defaultCachePathForKey:key];
            [cacheData writeToFile:filePath
                           options:NSDataWritingAtomic
                             error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(filePath);
                }
            });
        }
    });
}
- (id)readDataForKey:(NSString *)key
{
    return [NSData dataWithContentsOfFile:[self defaultCachePathForKey:key]];
}

- (void)removeDataForKey:(NSString *)key
{
    [self removeDataForKey:key
            withCompletion:nil];
}

- (void)removeDataForKey:(NSString *)key withCompletion:(void (^)(BOOL))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_fileManager removeItemAtPath:[self defaultCachePathForKey:key]
                                 error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(YES);
            }
        });
    });
}

- (void)removeAllData
{
    if ([_fileManager fileExistsAtPath:self.cachePath]) {
        [_fileManager removeItemAtPath:self.cachePath error:nil];
    }
    
}

- (NSString *)transformDictionary:(NSDictionary *)dictionary
{
    return [_transformer transformedValue:dictionary];
}

@end

@implementation JFDataCache (GenerateKey)

+ (NSString *)generateKeyWithURLAsString:(NSString *)urlAsString
                              parameters:(NSDictionary *)parameters
{
    
    NSString *key = nil;
    if (parameters) {
        key = [NSString stringWithFormat:@"%@%@", urlAsString, [parameters toString]];
    } else {
        key = urlAsString;
    }
    return key;
}

@end

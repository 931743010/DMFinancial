//
//  JFDataCache.h
//  IndexPagesDemo
//
//  Created by Joseph Fu on 14/11/11.
//  Copyright (c) 2014年 Joseph Fu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFDataCache : NSObject

@property (nonatomic, strong) NSString *cachePath;

+ (instancetype)sharedDataCache;

- (BOOL)dataExistsWithKey:(NSString *)key;

- (BOOL)isExpiredDataForKey:(NSString *)key
             withExpireTime:(NSInteger)expireTime;

- (void)writeData:(id)data
           forKey:(NSString *)key;

- (void)writeData:(id)data
           forKey:(NSString *)key
   withCompletion:(void(^)(NSString *filePath))completion;

- (id)readDataForKey:(NSString *)key;

- (void)removeDataForKey:(NSString *)key;

- (void)removeDataForKey:(NSString *)key
          withCompletion:(void(^)(BOOL finished))completion;

- (void)removeAllData;
- (NSString *)transformDictionary:(NSDictionary *)dictionary;

@end

@interface JFDataCache (GenerateKey)

//+ (NSString *)generateKeyWithURLAsString:(NSString *)urlAsString
//                              parameters:(NSDictionary *)parameters;

@end
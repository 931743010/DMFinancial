//
//  CLCachePolicy.h
//  DMCommonService
//
//  Created by lixiang on 14-1-7.
//  Copyright (c) 2014年 damai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CLCachePolicyLevel) {
    CLCachePolicyNone,
    CLCachePolicyMemory,
    CLCachePolicyDisk
};

/**
 *  缓存策略类
 */
@interface CLCachePolicy : NSObject

/**
 *  是否缓存
 */
@property (nonatomic, assign) BOOL                  isCache;
/**
 *  是否强制刷新
 */
@property (nonatomic, assign) BOOL                  isRefresh;
/**
 *  过期时间
 */
@property (nonatomic, assign) NSTimeInterval        expireTime;
/**
 *  缓存等级，内存或者硬盘
 */
@property (nonatomic, assign) CLCachePolicyLevel    policyLevel;

+ (instancetype)defaultCachePolicy;

@end

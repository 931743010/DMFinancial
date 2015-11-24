//
//  DMRequest.h
//  DamaiHD
//
//  Created by lixiang on 13-9-26.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessedBlock)(id returnData);
typedef void(^FailedBlock)(NSError *error);

@class DMRequestParser;
@class AFHTTPRequestOperation;
@class CLCachePolicy;

/**
 *   大麦接口请求类
 */
@interface DMRequest : NSObject

@property (nonatomic, assign) BOOL              needLogin;
@property (nonatomic, assign) BOOL              damaiAPI;//是否是大麦原来的接口
@property (nonatomic, strong) NSString          *requestUrl;//接口地址
@property (nonatomic, strong) NSDictionary          *parameters;//参数

@property (nonatomic, strong) DMRequestParser *requestParser;
//@property (nonatomic, copy) SuccessedBlock  successBlock;
//@property (nonatomic, copy) FailedBlock     failBlock;

/**
 *  通用大麦接口请求类
 *
 *  @param requestUrl 请求的URL后缀
 *  @param parameters 请求需要的参数
 *  @param parser     请求对应的解析类
 *  @param success    请求成功后的回调Block
 *  @param fail       请求失败后的回调Block
 */
- (void)requestWithUrl:(NSString *)requestUrl
            parameters:(NSDictionary *)parameters
                parser:(DMRequestParser *)parser
               success:(SuccessedBlock)success
                  fail:(FailedBlock)fail;
/**
 *  带缓存的请求
 *
 *  @param requestUrl 请求的URL后缀
 *  @param parameters 请求需要的参数
 *  @param cache      是否读取缓存
 *  @param parser     请求对应的解析类
 *  @param success    请求成功后的回调Block
 *  @param fail       请求失败后的回调Block
 */
- (void)requestWithUrl:(NSString *)requestUrl
            parameters:(NSDictionary *)parameters
           cachePolicy:(CLCachePolicy *)policy
                parser:(DMRequestParser *)parser
               success:(SuccessedBlock)success
                  fail:(FailedBlock)fail;

/**
 *  post的请求
 *
 *  @param requestUrl 请求的URL后缀
 *  @param parameters 请求需要的参数
 *  @param image      上传的图片
 *  @param parser     请求对应的解析类
 *  @param success    请求成功后的回调Block
 *  @param fail       请求失败后的回调Block
 */

- (void)requestPostWithUrl:(NSString *)requestUrl
                     image:(UIImage *)image
                parameters:(NSDictionary *)parameters
                    parser:(DMRequestParser *)parser
                   success:(SuccessedBlock)success
                      fail:(FailedBlock)fail;

@end

//
//  DMRequest.m
//  DamaiHD
//
//  Created by lixiang on 13-9-26.
//  Copyright (c) 2013年 damai. All rights reserved.
//

#import "DMRequest.h"
#import "DMApiClient.h"
#import "DMRequestParser.h"
#import "NSError+Additions.h"
#import "NSDictionary+Addition.h"
#import "DMAppInfo.h"
#import "CLCacheService.h"
#import "CLCachePolicy.h"
#import "DMApiClient.h"
#import "AFHTTPRequestOperation.h"
#import "DMGlobalVar.h"
#import "NSMutableDictionary+Addition.h"

@interface DMRequest () {
    //BOOL _needLogin;
}

@end

@implementation DMRequest

- (id)init {
    self = [super init];
    if (self) {
        _needLogin = NO;
        _damaiAPI = NO;
    }
    
    return self;
}

- (void)requestPostWithUrl:(NSString *)requestUrl
                        image:(UIImage *)image
            parameters:(NSDictionary *)parameters
                parser:(DMRequestParser *)parser
               success:(SuccessedBlock)success
                  fail:(FailedBlock)fail {
    
    [self requestWithUrl:requestUrl parameters:parameters parser:parser success:success fail:fail];
//    if ([parameters objectForKey:@"m"]) {
//        _needLogin = YES;
//    }
//    
//    DMApiClient *httpClient = [DMApiClient shareDMApiClient];
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    [params setSafetyObject:@"" forKey:@"DevID"];
//    [params setSafetyObject:[NSNumber numberWithInteger:[[NSDate date] timeIntervalSince1970]] forKey:@"t"];
//    [params setSafetyObject:@"" forKey:@"key"];
//
//    
//    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:requestUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        if (image) {
//            NSData *data = UIImageJPEGRepresentation(image, 1.0);
//            NSUInteger lengthK = data.length/1024;
//            
//            //图片压缩
//            if (lengthK <=  200) {
////              return;
//            }else if(lengthK > 1024){
//                data = UIImageJPEGRepresentation(image, 0.1);
//            }else if (200 < lengthK <= 1024){
//                data = UIImageJPEGRepresentation(image, 0.5);
//            }
//
//
//            [formData appendPartWithFileData:data
//                                        name:@"upfile"
//                                    fileName:@"file" mimeType:@"image/png"];
//        }
//    }];
//    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [self handleResponseData:responseObject
//                     cachePolicy:nil
//                             key:nil
//                          parser:parser
//                         success:success
//                            fail:fail];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSError *err = nil;
//        if (error.code == DMStatusResourceNotFound) {
//            err = [NSError errorWithCode:DMStatusResourceNotFound
//                                 message:kResourceNotFound];
//        } else {
//            err = [NSError errorWithCode:DMStatusNetworkError
//                                 message:kNetworkErrorText];
//        }
//        fail(err);
//    }];
//    
//    //Run
//    [httpClient.operationQueue addOperation:op];
}

- (void)requestWithUrl:(NSString *)requestUrl
            parameters:(NSDictionary *)parameters
                parser:(DMRequestParser *)parser
               success:(SuccessedBlock)success
                  fail:(FailedBlock)fail {
    
    [self requestWithUrl:requestUrl parameters:parameters cachePolicy:nil parser:parser success:success fail:fail];
}

- (void)requestWithUrl:(NSString *)requestUrl
            parameters:(NSDictionary *)parameters
           cachePolicy:(CLCachePolicy *)policy
                parser:(DMRequestParser *)parser
               success:(SuccessedBlock)success
                  fail:(FailedBlock)fail {
    _requestUrl = requestUrl;
    _parameters = parameters;
    NSString *key = nil;
    if (parameters) {
        key = [NSString stringWithFormat:@"%@%@", requestUrl, [parameters toString]];
    } else {
        key = requestUrl;
    }
    if ([parameters objectForKey:@"m"]) {
        _needLogin = YES;
    }

    if ([parameters objectForKey:@"M"]) {
        _needLogin = YES;
    }
    
    if ([requestUrl hasPrefix:@"/mapi"] || [requestUrl hasPrefix:@"mapi"]) {
        _damaiAPI = YES;
    }

    if ([requestUrl hasPrefix:@"/Update"] || [requestUrl hasPrefix:@"Update"]) {
        _damaiAPI = YES;
    }

    if ([requestUrl hasPrefix:@"/"]) {
        requestUrl = [requestUrl substringFromIndex:1];
    }
    
    if (policy && policy.isCache) {
        if (policy.isRefresh) {
            [CLCacheService removeCacheOfKey:key];
        } else {
            NSError *err = nil;
            id cacheData = [CLCacheService readCacheForKey:key error:&err];
            if (cacheData) {
                [self handleResponseData:cacheData
                             cachePolicy:policy
                                     key:nil
                                  parser:parser
                                 success:success
                                    fail:fail];
                return;
            }
        }
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [params setSafetyObject:@"" forKey:@"DevID"];
    [params setSafetyObject:[NSNumber numberWithInteger:[[NSDate date] timeIntervalSince1970]] forKey:@"t"];
    [params setSafetyObject:@"" forKey:@"key"];
    
    DMApiClient *httpClient = [DMApiClient shareDMApiClient];

    [httpClient getPath:requestUrl
             parameters:params
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [self handleResponseData:responseObject
                                 cachePolicy:policy
                                         key:key
                                      parser:parser
                                     success:success
                                        fail:fail];
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSError *err = nil;
                    if (error.code == DMStatusResourceNotFound) {
                        err = [NSError errorWithCode:DMStatusResourceNotFound
                                             message:kResourceNotFound];
                    } else {
                        err = [NSError errorWithCode:DMStatusNetworkError
                                             message:kNetworkErrorText];
                    }
                    fail(err);
                }];
}

//处理服务器返回的或者缓存的数据
/**
    判断逻辑顺序
 
    数据是否为空
    状态码
 
 *
 */
- (void)handleResponseData:(id)data
               cachePolicy:(CLCachePolicy *)policy
                       key:(NSString *)key
                    parser:(DMRequestParser *)parser
                   success:(SuccessedBlock)success
                      fail:(FailedBlock)fail {
    //如果返回数据为空,返回错误
    if ((data == nil) || ([data length] == 0)) {
        NSError *error = [NSError errorWithCode:DMCommonErrorCode message:kResponseInvalid];
        fail(error);
        return;
    }
    
    //判断状态码
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (obj != nil) {
        NSInteger errorCode = [[obj objectForKey:@"ret"] integerValue];
        NSString *errorMsg = [obj objectForKey:@"msg"];

        
        if (errorCode != 0) {//接口错误
            if ([DMHelper isNoLoginCode:errorCode]) {//登录异常
                if (IsNilOrNull(errorMsg)) {
                    errorMsg = kNotLogin;
                }

                NSError *error = [NSError errorWithCode:DMStatusNotLogin message:errorMsg];
                fail(error);
                return;
            } else {//其他异常
                if (IsNilOrNull(errorMsg)) {
                    errorMsg = kResourceNotFound;
                }
                NSError *error = [NSError errorWithCode:DMCommonErrorCode message:errorMsg];
                fail(error);
                return;

            }
        }
    }
    
    //如果使用解析器
    if (nil != parser) {
        success([parser parseData:data]);
    } else {
        id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //如果解析后是json数据,则返回解析后的数据，否则返回字符串
        if (obj != nil) {
            success(obj);
        } else {
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            success(str);
        }
    }
    
    //如果指定了缓存，则写入磁盘
    if (policy && policy.isCache && key) {
        [CLCacheService writeCache:data forKey:key expireTime:policy.expireTime];
    }
}

@end

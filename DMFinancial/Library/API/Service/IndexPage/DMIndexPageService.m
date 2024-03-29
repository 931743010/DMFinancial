//
//  DMIndexPageService.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/30.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMIndexPageService.h"
#import "DMYangmaoParser.h"
#import "DMHotListParser.h"
#import "DMMessageParser.h"
#import "DMNewcomerParser.h"
#import "DMP2PLibParser.h"
#import "JFDataCache.h"

#import "DMRequest.h"

@implementation DMIndexPageService


+ (id)fetchCacheWithParameters:(NSDictionary *)parameters
{
    NSString *key = [[JFDataCache sharedDataCache] transformDictionary:parameters];//[JFDataCache generateKeyWithURLAsString:kDiscoveryProject
    //                           parameters:parameters];
    id data = [[JFDataCache sharedDataCache] readDataForKey:key];
    
    if (data) {
//        DMProjectParser *parser = [[DMProjectParser alloc] init];
//        DMProjectList *list = [parser parseData:data];
//        return list.data;
        return [NSArray array];
    }
    return nil;
}

/**
 *  消息
 */

+ (void)getMessageListWithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestWithUrl:kMessage
                 parameters:params
                     parser:[DMMessageParser new]
                    success:^(id returnData){
                        success(returnData);
                    }
                       fail:^(NSError *error){
                           fail(error);
                       }];
}

/**
 *  排行榜
 */

+ (void)getHotListWithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestWithUrl:kHotList
                 parameters:params
                     parser:[DMHotListParser new]
                    success:^(id returnData){
                        success(returnData);
                    }
                       fail:^(NSError *error){
                           fail(error);
                       }];
}
/**
 *  羊毛
 */

+ (void)getYangmaoListWithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestWithUrl:kYangmao
                 parameters:params
                     parser:[DMYangmaoParser new]
                    success:^(id returnData){
                        success(returnData);
                    }
                       fail:^(NSError *error){
                           fail(error);
                       }];
}
/**
 *  新手入门
 */

+ (void)getNewcomerListWithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestWithUrl:kNewcomer
                 parameters:params
                     parser:[DMNewcomerParser new]
                    success:^(id returnData){
                        success(returnData);
                    }
                       fail:^(NSError *error){
                           fail(error);
                       }];
}
/**
 *  P2P产品库
 */

+ (void)getP2PLibListWithParams:(NSDictionary *)params
                             success:(void(^)(id returnData))success
                                fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestWithUrl:kP2PLib
                 parameters:params
                     parser:[DMP2PLibParser new]
                    success:^(id returnData){
                        success(returnData);
                    }
                       fail:^(NSError *error){
                           fail(error);
                       }];
}

/**
 *  首页列表
 */

+ (void)getProjectLibListWithParams:(NSDictionary *)params
                            success:(void(^)(id returnData))success
                               fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestWithUrl:kP2PLib
                 parameters:params
                     parser:[DMP2PLibParser new]
                    success:^(id returnData){
                        success(returnData);
                    }
                       fail:^(NSError *error){
                           fail(error);
                       }];

}

/**
 *  获取热门搜索
 */

+ (void)getSearchHotWordListWithParams:(NSDictionary *)params
                           cachePolicy:(CLCachePolicy *)policy
                            success:(void(^)(id returnData))success
                               fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestWithUrl:kP2PLib
                 parameters:params
                cachePolicy:policy
                     parser:[DMP2PLibParser new]
                    success:^(id returnData){
                        success(returnData);
                    }
                       fail:^(NSError *error){
                           fail(error);
                       }];
    
}
/**
 *  获取搜索结果
 */

+ (void)getSearchListWithParams:(NSDictionary *)params
                    cachePolicy:(CLCachePolicy *)policy
                               success:(void(^)(id returnData))success
                                  fail:(void(^)(NSError *error))fail {
    DMRequest *request = [DMRequest new];
    [request requestWithUrl:kP2PLib
                 parameters:params
                cachePolicy:policy
                     parser:[DMP2PLibParser new]
                    success:^(id returnData){
                        success(returnData);
                    }
                       fail:^(NSError *error){
                           fail(error);
                       }];
    
}

@end

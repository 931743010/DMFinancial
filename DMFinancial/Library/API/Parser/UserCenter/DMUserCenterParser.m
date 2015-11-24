//
//  DMUserCenterParser.m
//  DMJobGuarder
//
//  Created by 陈彦岐 on 15/5/16.
//  Copyright (c) 2015年 陈彦岐. All rights reserved.
//

#import "DMUserCenterParser.h"
#import "DMUserInfo.h"

@implementation DMUserCenterParser

//- (id)parseData:(id)data {
//    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    NSMutableArray *performs = [NSMutableArray new];
//    [performs configWithJsonData:result[@"data"] forClass:[DMUserInfo class]];
//    return performs;
//}

@end

@implementation DMUserInfoParser

- (id)parseData:(id)data {
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    DMUserInfo *item = [DMUserInfo new];
    [item configWithDictionary:result[@"data"]];
    return item;
}

@end

@implementation DMUserInfoDetailParser

- (id)parseData:(id)data {
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    DMUserInfoDetail *item = [DMUserInfoDetail new];
    [item configWithDictionary:result[@"data"]];
    return item;
}

@end

